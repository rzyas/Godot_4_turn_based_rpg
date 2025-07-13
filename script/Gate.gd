extends Node2D

func _ready() -> void:
	# Setup timer untuk continuous movement
	move_timer = Timer.new()
	move_timer.wait_time = 0.2
	move_timer.timeout.connect(_on_move_timer_timeout)
	add_child(move_timer)
	
	onready_btn_move()
	onready_btn_snap()

# --------------------------------------------
# GERAKKAN KAMERA DENGAN TWEEN DAN SET TOMBOL
# --------------------------------------------
@onready var nodes_btn_move: Node = $main_cam/parent_btn_move
@onready var node_main_cam: Camera2D = $main_cam
@onready var node_btn_snap: Button = $main_cam/parent_btn_move/btn_snap
@onready var node_prog_snap: TextureProgressBar = $main_cam/parent_btn_move/btn_snap/prog

var is_button_pressed = false
var pressed_dir = null
var move_timer: Timer
var current_move_tween: Tween

enum ENUM_CAMMOVE { RIGHT, LEFT, TOP, BOTTOM }

func tween_camera_move(camera: Camera2D, direction: ENUM_CAMMOVE) -> void:
	# Stop tween sebelumnya jika ada
	if current_move_tween:
		current_move_tween.kill()
	
	current_move_tween = create_tween()
	var target_position := camera.position
	
	match direction:
		ENUM_CAMMOVE.RIGHT:
			target_position.x += 200
		ENUM_CAMMOVE.LEFT:
			target_position.x -= 200
		ENUM_CAMMOVE.TOP:
			target_position.y -= 200
		ENUM_CAMMOVE.BOTTOM:
			target_position.y += 200
	
	# Cek apakah target_position melebihi batas sebelum clamp
	var original_position := target_position
	target_position.x = clamp(target_position.x, -6500, 6500)
	target_position.y = clamp(target_position.y, -6500, 6500)
	
	if original_position != target_position:
		print("melebihi batas")
	
	current_move_tween.tween_property(camera, 'position', target_position, 0.2)
# HUBUNGKAN TOMBOL DENGAN GERAKAN KAMERA
func onready_btn_move():
	for i in nodes_btn_move.get_child_count():
		var btn: Button = nodes_btn_move.get_child(i)
		
		# Skip btn_snap (asumsi btn_snap adalah child terakhir atau bukan bagian dari move buttons)
		if btn == node_btn_snap:
			continue
		
		match i:
			0:
				btn.set_meta('move_dir', ENUM_CAMMOVE.RIGHT)
			1:
				btn.set_meta('move_dir', ENUM_CAMMOVE.LEFT)
			2:
				btn.set_meta('move_dir', ENUM_CAMMOVE.TOP)
			3:
				btn.set_meta('move_dir', ENUM_CAMMOVE.BOTTOM)
		
		# Ketika tombol ditekan
		btn.button_down.connect(func():
			is_button_pressed = true
			pressed_dir = btn.get_meta('move_dir')
			start_moving()
		)
		
		# Ketika tombol dilepas
		btn.button_up.connect(func():
			is_button_pressed = false
			move_timer.stop()
		)
# MULAI GERAKAN CONTINUOUS
func start_moving():
	if not is_button_pressed:
		return
	
	tween_camera_move(node_main_cam, pressed_dir)
	move_timer.start()
# CALLBACK TIMER UNTUK CONTINUOUS MOVEMENT
func _on_move_timer_timeout():
	if is_button_pressed:
		tween_camera_move(node_main_cam, pressed_dir)
	else:
		move_timer.stop()
# TOMBOL SNAP KE TENGAH
func onready_btn_snap():
	var snap_state = {
		"processing": false,
		"snap_tween": null,
		"progress_tween": null
	}
	
	# Fungsi untuk reset progress bar
	var reset_progress = func():
		if snap_state.progress_tween and snap_state.progress_tween.is_valid():
			snap_state.progress_tween.kill()
		snap_state.progress_tween = create_tween()
		snap_state.progress_tween.tween_property(node_prog_snap, "value", 0, 0.2)
	
	# Fungsi untuk stop semua tween
	var stop_all_tweens = func():
		if snap_state.snap_tween and snap_state.snap_tween.is_valid():
			snap_state.snap_tween.kill()
		if snap_state.progress_tween and snap_state.progress_tween.is_valid():
			snap_state.progress_tween.kill()
	
	node_btn_snap.pressed.connect(func():
		# Jika sedang dalam proses, batalkan dan reset
		if snap_state.processing:
			snap_state.processing = false
			stop_all_tweens.call()
			reset_progress.call()
			return
		
		# Mulai proses snap
		snap_state.processing = true
		node_prog_snap.value = 0  # Reset progress bar value
		
		# Tween progress bar dari 0 ke 100 dalam 3 detik
		snap_state.progress_tween = create_tween()
		snap_state.progress_tween.tween_property(node_prog_snap, "value", 100, 3.0)
		
		# Setelah 3 detik, pindahkan camera ke posisi 0,0
		snap_state.progress_tween.finished.connect(func():
			if snap_state.processing:  # Pastikan masih dalam proses
				for i in nodes_btn_move.get_child_count():
					var btn:Button = nodes_btn_move.get_child(i)
					btn.disabled = true
				snap_state.snap_tween = create_tween()
				snap_state.snap_tween.tween_property(node_main_cam, "position", Vector2.ZERO, .5)
				snap_state.snap_tween.finished.connect(func():
					snap_state.processing = false
				, CONNECT_ONE_SHOT)
				await get_tree().create_timer(.5).timeout
				for i in nodes_btn_move.get_child_count():
					var btn:Button = nodes_btn_move.get_child(i)
					btn.disabled = false
				node_prog_snap.value = 0
		, CONNECT_ONE_SHOT) )
