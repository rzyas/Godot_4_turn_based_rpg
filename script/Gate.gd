extends Node2D
# --------------------------------------------
# ENUM ARAH GERAK KAMERA
# --------------------------------------------
enum ENUM_CAMMOVE { RIGHT, LEFT, TOP, BOTTOM }

# --------------------------------------------
# ONREADY VARIABEL
# --------------------------------------------
@onready var node_main_cam: Camera2D = $main_cam
@onready var nodes_btn_move: Node = $main_cam/parent_btn_move

# --------------------------------------------
# VARIABEL STATE TOMBOL
# --------------------------------------------
var is_button_pressed = false
var pressed_dir = null

# --------------------------------------------
# READY
# --------------------------------------------
func _ready() -> void:
	onready_btn_move()

# --------------------------------------------
# GERAKKAN KAMERA DENGAN TWEEN
# --------------------------------------------
func tween_camera_move(camera: Camera2D, direction: ENUM_CAMMOVE) -> void:
	var tween := get_tree().create_tween()
	var target_position := camera.position
	match direction:
		ENUM_CAMMOVE.RIGHT:
			target_position.x += 60
		ENUM_CAMMOVE.LEFT:
			target_position.x -= 60
		ENUM_CAMMOVE.TOP:
			target_position.y -= 60
		ENUM_CAMMOVE.BOTTOM:
			target_position.y += 60
	# Cek apakah target_position melebihi batas sebelum clamp
	var original_position := target_position
	target_position.x = clamp(target_position.x, -6500, 6500)
	target_position.y = clamp(target_position.y, -3500, 3500)
	if original_position != target_position:
		print("melebihi batas")
	tween.tween_property(camera, 'position', target_position, 0.2)

# --------------------------------------------
# HUBUNGKAN TOMBOL DENGAN GERAKAN KAMERA
# --------------------------------------------
func onready_btn_move():
	for i in nodes_btn_move.get_child_count():
		var btn: Button = nodes_btn_move.get_child(i)
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
		btn.connect('button_down', func():
			is_button_pressed = true
			pressed_dir = btn.get_meta('move_dir')
			start_moving()
		)

		# Ketika tombol dilepas
		btn.connect('button_up', func():
			is_button_pressed = false
		)

# --------------------------------------------
# ULANGI GERAKAN SELAMA TOMBOL DITEKAN
# --------------------------------------------
func start_moving():
	if not is_button_pressed:
		return
	tween_camera_move(node_main_cam, pressed_dir)
	await get_tree().create_timer(0.2).timeout
	start_moving()
