extends Node
enum ENUM_ICON_SPAWN_BLUE { VILLAGE, KINGDOM, HOUSE, OLD_RUIN, GRAVE, RUIN, CAMP, TOWER, BUOY, SHIP, ISLAND, BUOY_SIGNAL, TASK, CASTLE }
enum ENUM_ICON_SPAWN_ORANGE { BATTLE, MARK_PIRATE, TORNADO, SHIP_CRASH, CHEST, PORTAL, BROKEN_HOUSE, MINING, FARM }
enum ENUM_ICON_SPAWN_RED {MONSTER_LV_0, MONSTER_LV_1, MONSTER_LV_2, MONSTER_LV_3, MONSTER_LV_4, MINI_BOSS_VIKING, MINI_BOSS_DRAGON,
	MINI_BOSS_GIANT, BIG_BOSS_EVIL, SEA_MONSTER_KRAKEN, SEA_MONSTER_LEVIATAN, PIRATE, SEA_BIG_BOSS_NATURE }
enum ENUM_ICON_SPAWN_MARK {BLUE, ORANGE, RED}
enum ENUM_ICON_PROFILE {MALE, FEMALE, FARM, TIEF, GUARD, QUEEN, KING}
func _ready() -> void:
	onready_cam_nav()
	onready_btn_sector()
	node_sldv_cam.value_changed.connect(onready_cam_zoom)

	var main_btn:Button = $canvas_l/parent_btn_move/Button
	
	main_btn.connect("pressed", func():
		rng_spawn(0, _path_icon_spawn_blue(randi_range(0, 13)), randi_range(0, 2) as ENUM_ICON_SPAWN_MARK) )



# --------------------------------------
# PERSON INSPECT
# --------------------------------------
@onready var nodes_btn_cls_personinspect:Button = $canvas_l/btn_cls_info_people
@onready var _person_keys_dict = {
	0: 'name', 1: 'age', 2: 'job', 3: 'gender', 4: 'birth_date', 5: 'death_date', 6: 'height', 7: 'weight', 8: 'hobby', 9: 'origin',
	10: 'status', 11: 'trust', 12: 'marriage', 13: 'location', 14: 'is_alive', 15: 'death_location', 16: 'physical', 17: 'intelligence',
	18: 'communication', 19: 'wisdom', 20: 'stat_food', 21: 'stat_mmood', 22: 'stat_health' }

func person_inspect(code):
	var data_main = AutoloadData.all_npc[code]
	# basic
	var get_profile:TextureRect = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog/profile")
	var get_name:Label = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog/vbox_title/name")
	var get_stat:Label = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog/vbox_title/stat")
	var _pp_gender = 0 if data_main[_person_keys_dict[0]]=="Mele" else 1
	get_profile.texture = _path_icon_profile(_pp_gender)
	get_name.text = data_main[_person_keys_dict[0]]
	get_stat.text = str(data_main[_person_keys_dict[1]]," Years Old - ",data_main[_person_keys_dict[3]])
	# prog
	var _hbox_prog = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog")
	for i in range( 2, _hbox_prog.get_child_count() ):
		var prog:TextureProgressBar = _hbox_prog.get_child(i)
		prog.value = data_main[_person_keys_dict[i+14]]
	# info
	var _vbox_txt = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_info/vbox_txt")
	for i in _vbox_txt.get_child_count():
		var get_txt:Label = _vbox_txt.get_child(i)
		get_txt.text = str( data_main[_person_keys_dict[i+3]] )
	# trade
	var get_btn_parent:Button = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/scrolc/grid_parent")
	var get_btn_prosed:Button = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/scrolc/grid_parent/btn_prosed")
	var get_trade_img:TextureRect = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/img")
	var get_trade_item:Label = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/item_name")
	var get_trade_desc:Label = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/desc")
	var get_trade_btn_dec:Button = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox/btn_dec")
	var get_trade_btn_add:Button = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox/btn_add")
	var get_trade_btn_count:Label = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox/count")
	var get_trade_btn_buy:Button = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/btn_buy")
	var get_trade_btn_act:Button = nodes_btn_cls_personinspect.get_node("pnl_main/vbox_info/btn_act")

	
# --------------------------------------
# SECTOR INSPECT
# --------------------------------------
@onready var nodes_sector_inspect = $canvas_l/pnl_sector
@onready var nodes_all_btn_sector = $island_name
func onready_btn_sector():
	for i in nodes_all_btn_sector.get_child_count():
		var sector_size = nodes_all_btn_sector.get_child(i).get_child_count()
		for ii in sector_size:
			var btn:Button = nodes_all_btn_sector.get_child(i).get_child(ii)
			btn.connect("pressed", sector_inspect.bind(i, ii) )
# sector data
func sector_inspect(zone, sector):
	var node_sector_header:Label = nodes_sector_inspect.get_node("vbox/name")
	var node_sector_size:Label = nodes_sector_inspect.get_node("vbox/size")
	var _island_x_size = nodes_all_sector.get_child(zone).get_child(sector).size.x * 2
	var _island_y_size = nodes_all_sector.get_child(zone).get_child(sector).size.y * 2
	var node_vbox_prog:VBoxContainer = nodes_sector_inspect.get_node("vbox/hbox/vbox_prog")
	var node_vbox_count:VBoxContainer = nodes_sector_inspect.get_node("vbox/hbox/vbox_count")
	
	node_sector_header.text = AutoloadData.sector_data[zone][sector]["name"]
	node_sector_size.text = str("AREA SIZE: ", int(_island_x_size)+int(_island_y_size))
	var _dict_key = ["danger","mining","food","treasure","population"]
	for i in node_vbox_prog.get_child_count():
		var prog:TextureProgressBar = node_vbox_prog.get_node(str("vbox_",i,"/prog"))
		var count:Label = node_vbox_count.get_child(i)
		# Mulai dari 0
		prog.value = 0
		count.text = '0'
		# Ambil target value
		var target_value = AutoloadData.sector_data[zone][sector][_dict_key[i]]
		# Buat tween paralel
		var tween_prog = create_tween()
		tween_prog.set_parallel(true)
		# Tween prog.value dari 0 ke target
		tween_prog.tween_property(prog, 'value', target_value, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		# Tween dummy untuk update count.text saat prog.value berubah
		tween_prog.tween_method(
			func(v):
				count.text = str(int(v)),
			0.0,
			target_value,
			1.0
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
# --------------------------------------
# SECTOR SWPAN
# --------------------------------------
@onready var nodes_all_sector = $all_sector
@onready var node_btn_prosed_spawn:Button = $btn_prosed
func rng_spawn(sector, main, mark:ENUM_ICON_SPAWN_MARK):
	var get_sector_main = nodes_all_sector.get_child(sector)
	var rng_sector = randi_range( 0, get_sector_main.get_child_count()-1 )
	var get_sector:Panel = get_sector_main.get_child(rng_sector)
	
	var sector_max_x = get_sector.size.x - 50
	var sector_max_y = get_sector.size.y - 50

	var main_spawn:Button = node_btn_prosed_spawn.duplicate()
	var spawn_img:TextureRect = main_spawn.get_node("bg")
	var rng_size = randi_range(75, 500)
	spawn_img.size = Vector2(rng_size, rng_size)
	spawn_img.position = -(spawn_img.size / 2)
	
	main_spawn.show()
	spawn_img.texture = load(_path_icon_spawn_mark(mark))
	main_spawn.icon = load(main)
	
	get_sector.add_child(main_spawn)
	main_spawn.position = Vector2( randi_range(0, sector_max_x), randi_range(0, sector_max_y) )
# ---------------------------------------
# VERTICAL SLIDE ZOOM IN/OUT
# ---------------------------------------
@onready var node_sldv_cam = $canvas_l/sld_camzoom
func onready_cam_zoom(slide_value):
	var min_zoom = .5
	var max_zoom = 5.0
	var normalized = slide_value / 100.0
	var zoom_factor = lerp(min_zoom, max_zoom, normalized)
	node_main_cam.zoom = Vector2(zoom_factor, zoom_factor)
# --------------------------------------
# NAVIGATION BUTTON
# --------------------------------------
# Referensi node yang diperlukan
@onready var nodes_btn_nav = $canvas_l/parent_btn_move
@onready var node_main_cam = $main_cam
@onready var node_nav_prog = nodes_btn_nav.get_node("btn_snap/prog")
# Variabel untuk Tween dan kontrol snap
var tween: Tween
var snap_tween: Tween
var prog_tween: Tween
var is_snapping: bool = false
# Variabel untuk kontrol tombol tahan
var move_timer: Timer
var current_move_direction: Vector2 = Vector2.ZERO
var is_button_held: bool = false

func onready_cam_nav():
	# Inisialisasi Tween
	tween = create_tween()
	tween.set_loops()
	tween.pause()
	
	snap_tween = create_tween()
	snap_tween.set_loops()
	snap_tween.pause()
	
	prog_tween = create_tween()
	prog_tween.set_loops()
	prog_tween.pause()
	
	# Inisialisasi Timer untuk gerakan berulang
	move_timer = Timer.new()
	move_timer.wait_time = 0.1  # Interval gerakan saat tombol ditahan
	move_timer.timeout.connect(_on_move_timer_timeout)
	add_child(move_timer)
	# Hubungkan tombol navigasi
	var btn_right = nodes_btn_nav.get_child(0)  # Tombol kanan
	var btn_left = nodes_btn_nav.get_child(1)   # Tombol kiri
	var btn_up = nodes_btn_nav.get_child(2)     # Tombol atas
	var btn_down = nodes_btn_nav.get_child(3)   # Tombol bawah
	var btn_snap = nodes_btn_nav.get_child(4)   # Tombol snap
	# Hubungkan signal tombol untuk pressed dan released
	btn_right.button_down.connect(_on_btn_right_down)
	btn_right.button_up.connect(_on_btn_released)
	btn_left.button_down.connect(_on_btn_left_down)
	btn_left.button_up.connect(_on_btn_released)
	btn_up.button_down.connect(_on_btn_up_down)
	btn_up.button_up.connect(_on_btn_released)
	btn_down.button_down.connect(_on_btn_down_down)
	btn_down.button_up.connect(_on_btn_released)
	btn_snap.pressed.connect(_on_btn_snap_pressed)
# Fungsi untuk menggerakkan kamera (untuk kompatibilitas)
func _move_camera(offset: Vector2):
	_move_camera_instant(offset)
# Fungsi untuk tombol arah - button_down
var _nav_speed = 70
func _on_btn_right_down():
	_start_continuous_move(Vector2(_nav_speed, 0))
func _on_btn_left_down():
	_start_continuous_move(Vector2(-_nav_speed, 0))
func _on_btn_up_down():
	_start_continuous_move(Vector2(0, -_nav_speed))
func _on_btn_down_down():
	_start_continuous_move(Vector2(0, _nav_speed))
# Fungsi untuk tombol arah - button_up
func _on_btn_released():
	_stop_continuous_move()
# Fungsi untuk memulai gerakan berulang
func _start_continuous_move(direction: Vector2):
	# Batalkan snap jika sedang berlangsung
	if is_snapping:
		_cancel_snap()
	
	current_move_direction = direction
	is_button_held = true
	# Gerakan pertama langsung
	_move_camera_instant(direction)
	# Mulai timer untuk gerakan berulang
	move_timer.start()
# Fungsi untuk menghentikan gerakan berulang
func _stop_continuous_move():
	is_button_held = false
	current_move_direction = Vector2.ZERO
	move_timer.stop()
# Fungsi callback timer untuk gerakan berulang
func _on_move_timer_timeout():
	if is_button_held and current_move_direction != Vector2.ZERO:
		_move_camera_instant(current_move_direction)
	else:
		move_timer.stop()
# Fungsi untuk menggerakkan kamera secara instant (untuk gerakan berulang)
func _move_camera_instant(offset: Vector2):
	# Hentikan tween sebelumnya
	if tween:
		tween.kill()
	
	# Buat tween baru untuk perpindahan kamera dan tombol navigasi
	tween = create_tween()
	tween.set_parallel(true)  # Izinkan animasi paralel
	
	var target_cam_pos = node_main_cam.position + offset
	#var target_btn_pos = nodes_btn_nav.position + offset
	# Animasi kamera dan tombol navigasi bersamaan
	tween.tween_property(node_main_cam, "position", target_cam_pos, 0.1)
	#tween.tween_property(nodes_btn_nav, "position", target_btn_pos, 0.1)
	#nodes_btn_nav.position = Vector2(-688, 248)
# Fungsi untuk tombol snap
func _on_btn_snap_pressed():
	if is_snapping:
		# Jika sedang dalam proses snap, batalkan snap
		_cancel_snap()
		return
	
	_start_snap_process()
# -------------------- UTYLITY FUNC ------------------------
func _path_icon_profile(code):
	return str( "res://img/Gate/PP/",code,".png" )
func _path_icon_spawn_blue(code):
	var path = str("res://img/Gate/Icon/Blue/",code,".png")
	return path
func _path_icon_spawn_orange(code):
	var path = str("res://img/Gate/Icon/Gold/",code,".png")
	return path
func _path_icon_spawn_red(code):
	var path = str("res://img/Gate/Icon/Red/",code,".png")
	return path
func _path_icon_spawn_mark(code):
	var path = str("res://img/Gate/Icon/Mark/",code,".png")
	return path
func _start_snap_process():
	is_snapping = true
	# Nonaktifkan semua tombol
	_set_buttons_disabled(true)
	# Reset progress bar
	node_nav_prog.value = 0
	# Mulai progress bar animation
	if prog_tween:
		prog_tween.kill()
	
	prog_tween = create_tween()
	prog_tween.tween_property(node_nav_prog, "value", 100, 3.0)
	# Setelah 3 detik, lakukan snap jika tidak dibatalkan
	prog_tween.tween_callback(_complete_snap)
func _complete_snap():
	if not is_snapping:
		return
	
	# Snap kamera dan tombol navigasi ke tengah
	if snap_tween:
		snap_tween.kill()
	
	snap_tween = create_tween()
	snap_tween.set_parallel(true)  # Izinkan animasi paralel
	
	# Snap kamera dan tombol navigasi ke posisi (0,0)
	#var target_btn_default_pos = Vector2(-688, 248)
	snap_tween.tween_property(node_main_cam, "position", Vector2.ZERO, 0.2)
	#snap_tween.tween_property(nodes_btn_nav, "position", target_btn_default_pos, 0.2)
	
	# Setelah snap selesai, reset progress
	snap_tween.tween_callback(_reset_progress)
func _reset_progress():
	if prog_tween:
		prog_tween.kill()
	
	prog_tween = create_tween()
	prog_tween.tween_property(node_nav_prog, "value", 0, 0.1)
	prog_tween.tween_callback(_finish_snap)
func _cancel_snap():
	if not is_snapping:
		return
	# Hentikan semua tween yang berkaitan dengan snap
	if prog_tween:
		prog_tween.kill()
	if snap_tween:
		snap_tween.kill()
	# Reset progress bar dari value saat ini ke 0 dalam 0.1 detik
	prog_tween = create_tween()
	prog_tween.tween_property(node_nav_prog, "value", 0, 0.1)
	prog_tween.tween_callback(_finish_snap)
func _finish_snap():
	is_snapping = false
	# Aktifkan kembali semua tombol
	_set_buttons_disabled(false)
func _set_buttons_disabled(disabled: bool):
	# Nonaktifkan tombol arah (0-3) tapi biarkan btn_snap (4) tetap aktif
	for i in range(4):  # Hanya tombol 0-3
		var btn = nodes_btn_nav.get_child(i)
		btn.disabled = disabled
	# Jika tombol dinonaktifkan, hentikan gerakan berulang
	if disabled:
		_stop_continuous_move()
