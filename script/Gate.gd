extends Node
enum ENUM_ICON_SPAWN_BLUE { VILLAGE, KINGDOM, HOUSE, OLD_RUIN, GRAVE, RUIN, CAMP, TOWER, BUOY, SHIP, ISLAND, BUOY_SIGNAL, TASK, CASTLE }
enum ENUM_ICON_SPAWN_ORANGE { BATTLE, MARK_PIRATE, TORNADO, SHIP_CRASH, CHEST, PORTAL, BROKEN_HOUSE, MINING, FARM }
enum ENUM_ICON_SPAWN_RED {MONSTER_LV_0, MONSTER_LV_1, MONSTER_LV_2, MONSTER_LV_3, MONSTER_LV_4, MINI_BOSS_VIKING, MINI_BOSS_DRAGON,
	MINI_BOSS_GIANT, BIG_BOSS_EVIL, SEA_MONSTER_KRAKEN, SEA_MONSTER_LEVIATAN, PIRATE, SEA_BIG_BOSS_NATURE }
enum ENUM_ICON_SPAWN_MARK {BLUE, ORANGE, RED}
enum ENUM_ICON_PROFILE {MALE, FEMALE, FARM, TIEF, GUARD, QUEEN, KING}

enum ENUM_NPC_JOB_FARM {CANGKUL, PUPUK, BENIH, AIR, ORANG_SAWAH}
enum ENUM_NPC_JOB_FISHER {KAPAL, UMPAN, PANCING, JARING, NET}
enum ENUM_NPC_JOB_HUNTER {TRAP, CROSSBOW, SWORD, ROPE, RANSEL}
enum ENUM_NPC_JOB_MINER {HELM, PICKEXE, LENTERA, CART, OKSIGEN}
enum ENUM_NPC_JOB_THIEF {DAGGER, POISON, BOW, FOODO, BOM_ASAP}

func _ready() -> void:
	update_currency()
	onready_cam_nav()
	onready_btn_sector()
	onready_person_inspect()
	# BTN
	node_sldv_cam.value_changed.connect(onready_cam_zoom)
	
	var main_btn:Button = $canvas_l/parent_btn_move/Button
	main_btn.connect("pressed", func():
		rng_spawn(0, _path_icon_spawn_blue(randi_range(0, 13)), randi_range(0, 2) as ENUM_ICON_SPAWN_MARK) )
# --------------------------------------
# UPDATE CURRECNCY
# --------------------------------------
@onready var gate_currency = {0:$canvas_l/vbox_currecy/hbox_0/count, 1:$canvas_l/vbox_currecy/hbox_1/count, 2:$canvas_l/vbox_currecy/hbox_2/count}
func update_currency():
	var coin_star:Label = gate_currency[0]
	var coin_skull:Label = gate_currency[1]
	var coin_cumon:Label = gate_currency[2]
	coin_star.text = str(AutoloadData.filter_num_k(AutoloadData.gate_coin_star))
	coin_skull.text = str(AutoloadData.filter_num_k(AutoloadData.gate_coin_skull))
	coin_cumon.text = str(AutoloadData.filter_num_k(AutoloadData.gate_coin_cummon))
# --------------------------------------
# PERSON INSPECT
# --------------------------------------
@onready var btn_cls_personinspect := $canvas_l/btn_cls_info_people
@onready var profile = btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog/profile")
@onready var name_lbl = btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog/vbox_title/name")
@onready var stat_lbl = btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog/vbox_title/stat")
@onready var hbox_prog = btn_cls_personinspect.get_node("pnl_main/vbox_info/hbox_prog")
@onready var vbox_txt = btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_info/vbox_txt")

@onready var person_trade = {
	"img": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/img"),
	"item_name": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/item_name"),
	"desc": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/desc"),
	"btn_dec": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox/btn_dec"),
	"btn_add": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox/btn_add"),
	"count": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox/count"),
	"btn_buy": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/btn_buy"),
	"btn_act": btn_cls_personinspect.get_node("pnl_main/vbox_info/btn_act"),
	"hbox_trade": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade"),
	"hbox_info": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_info"),
	"hbox_price_img": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox_price/icon_price"),
	"hbox_price_txt": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox_price/price"),
	"hbox_price_own": btn_cls_personinspect.get_node("pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox/hbox_price/own"), }
@onready var _person_keys_dict = {
	0: 'name', 1: 'age', 2: 'job', 3: 'gender', 4: 'birth_date', 5: 'death_date', 6: 'height', 7: 'weight',
	8: 'hobby', 9: 'origin', 10: 'status', 11: 'trust', 12: 'marriage', 13:'location', 14: 'is_alive',
	15: 'death_location', 16: 'physical', 17: 'intelligence', 18: 'communication', 19: 'wisdom',
	20: 'stat_food', 21: 'stat_mood', 22: 'stat_health', 23:'inventory' }
const _trade_price = {
	0:{0:5, 1:5, 2:5, 3:1, 4:2},
	1:{0:30, 1:1, 2:3, 3:2, 4:2},
	2:{0:3, 1:7, 2:4, 3:1, 4:5},
	3:{0:2, 1:3, 2:1, 3:20, 4:30},
	4:{0:25, 1:20, 2:10, 3:100, 4:5}, }
const _trade_value = {
	0:{0:10, 1:20, 2:20, 3:10, 4:5},
	1:{0:30, 1:1, 2:3, 3:2, 4:2},
	2:{0:3, 1:7, 2:4, 3:1, 4:5},
	3:{0:2, 1:3, 2:1, 3:20, 4:30},
	4:{0:25, 1:20, 2:10, 3:100, 4:5}, }

var _temp_trade_data = { "item_code":null, "item_price":null, "npc_code":null, "min":0, "max":0 }
# Utility for trade
func _trade_inspect_reset(_bool:bool=true):
	if _bool:
		person_trade["btn_buy"].disabled = true
		person_trade["btn_dec"].disabled = true
		person_trade["btn_add"].disabled = true
		_current_tool["job"]=null
		_current_tool["item"]=null
		person_trade["img"].texture = null
		person_trade["item_name"].text = str("-")
		person_trade["desc"].text = str("-")
		person_trade["count"].text = str("-")       
		var price:Label = person_trade["hbox_price_txt"]
		var own:Label = person_trade["hbox_price_own"]
		price.text = "-"
		own.text = str( "OWN: ",AutoloadData.filter_num_k(AutoloadData.gate_coin_cummon) )
func _trade_job(code):
	if AutoloadData.all_npc.has(code)==false: return
	
@onready var vbox_tools_item = $canvas_l/btn_cls_info_people/pnl_main/vbox_info/pnl_data/hbox_trade/scrolc/vbox
@onready var vbox_tools_inspect = $canvas_l/btn_cls_info_people/pnl_main/vbox_info/pnl_data/hbox_trade/pnl_desc/vbox
var _current_tool = {"job":null, "item":null, "count":1}
# update count trade
func _update_trade_count():
	var txt_count:Label = person_trade["count"]
	txt_count.text = str(_current_tool["count"])
func onready_person_inspect():
	# btn dec
	var btn_add:Button = person_trade["btn_add"]
	var btn_dec:Button = person_trade["btn_dec"]
	btn_dec.connect("pressed", func():
		if _current_tool["count"]<=1:
			SfxManager.play_system_fail()
			return
		SfxManager.play_money()
		var decrease = _current_tool["count"]-1
		var limit_decrease = clamp(decrease, 1, 999)
		_current_tool["count"]=limit_decrease
		_update_trade_count() )
	# btn add
	btn_add.connect("pressed", func():
		if _current_tool["job"] == null:
			SfxManager.play_system_fail()
			return
		var cummon_coin = AutoloadData.gate_coin_cummon
		var curr_job = _current_tool["job"]
		var curr_item = _current_tool["item"]
		var next_count = _current_tool["count"] + 1
		var item_price = _trade_price[curr_job][curr_item]
		var total_price_next = item_price * next_count
		if cummon_coin < total_price_next:
			SfxManager.play_system_fail()
			return
		SfxManager.play_money()
		_current_tool["count"] = clamp(next_count, 1, 999)
		_update_trade_count() )
	# btn tools items
	var data_tools = Gate_desc.new()
	for i in vbox_tools_item.get_child_count():
		var vbox_items = vbox_tools_item.get_child(i).get_node("vbox/hbox_item")
		for ii in vbox_items.get_child_count()-1:
			var btn:Button = vbox_items.get_child(ii)
			var node_img:TextureRect = vbox_tools_inspect.get_node("img")
			var node_item_name:Label = vbox_tools_inspect.get_node("item_name")
			var node_desc:Label = vbox_tools_inspect.get_node("desc")
			# price
			var price:Label = person_trade["hbox_price_txt"]
			var own:Label = person_trade["hbox_price_own"]
			# btn select items on job
			btn.connect("pressed", func():
				_current_tool["job"]=i
				_current_tool["item"]=ii
				_current_tool["count"]=1
				_update_trade_count()
				SfxManager.play_click()
				node_img.texture = load(data_tools.tools_path_img(i, ii))
				node_item_name.text = data_tools.tools_item[data_tools.tools_code[i]][ii]["name"]
				node_desc.text = str("+",_trade_value[i][ii]," Sources\n",data_tools.tools_item[data_tools.tools_code[i]][ii]["desc"])
				price.text = str(_trade_price[i][ii]*_current_tool["count"])
				person_trade["btn_buy"].disabled = false
				person_trade["btn_dec"].disabled = false
				person_trade["btn_add"].disabled = false
				own.text = str( "OWN: ",AutoloadData.filter_num_k(AutoloadData.gate_coin_cummon) ) )
	# btn close panel
	btn_cls_personinspect.connect("pressed", func():
		btn_cls_personinspect.hide()
		update_currency() )
	# btn switch info and trade
	var btn_act:Button = person_trade["btn_act"]
	btn_act.text = "TRADE"
	btn_act.connect("pressed", func():
		if person_trade["btn_act"].text == "TRADE":
			btn_act.text = "INFO"
			person_trade["hbox_trade"].show()
			person_trade["hbox_info"].hide()
		else:
			btn_act.text = "TRADE"
			person_trade["hbox_trade"].hide()
			person_trade["hbox_info"].show() )
	# btn trade (buy)
	person_trade["btn_buy"].connect("pressed", func():
		if AutoloadData.all_npc.has(_temp_trade_data["npc_code"])==false:
			SfxManager.play_system_fail()
			return
		var curr_job = _current_tool["job"]
		var curr_item = _current_tool["item"]
		var current_price = _trade_price[curr_job][curr_item]*_current_tool["count"]
		if AutoloadData.gate_coin_cummon < current_price:
			SfxManager.play_system_fail()
			return
		AutoloadData.all_npc[_temp_trade_data["npc_code"]]["stat"][curr_job]["sources"]+=_trade_value[curr_job][curr_item]*_current_tool["count"]
		AutoloadData.gate_coin_cummon-=current_price
		AutoloadData.save_data()
		person_inspect(_temp_trade_data["npc_code"]) )
	
func person_inspect(code):
	if AutoloadData.all_npc.has(code)== false: return
	btn_cls_personinspect.visible = true
	_trade_inspect_reset()
	_temp_trade_data["npc_code"]=code
	var data = AutoloadData.all_npc[code]
	var tools = Gate_desc.new()
	# Profile
	var gender_index = 0 if data['gender'] == 'Male' else 1
	profile.texture = load(_path_icon_profile(gender_index))
	name_lbl.text = data['name']
	var job = data["job"] if data["job"]!=null else ""
	stat_lbl.text = "%s Years Old - %s" % [data['age'], job]
	# Progress Bars
	for i in range(2, hbox_prog.get_child_count()):
		var bar:TextureProgressBar = hbox_prog.get_child(i)
		bar.value = data[_person_keys_dict[i + 14]]
	# Text Info
	for i in range(vbox_txt.get_child_count()):
		var txt:Label = vbox_txt.get_child(i)
		var temp_data = data[_person_keys_dict[i + 3]]
		if i in [1, 2]:
			var result = "%02d/%02d/%d - %02d:00" % [temp_data["day"], temp_data["month"], temp_data["year"], temp_data["hour"]]
			txt.text = result
		elif i == 11:
			if temp_data: txt.text = "Surviving"
			else: txt.text = "Dead"
		elif i == 10:
			txt.text = str(
				"Sector: ",AutoloadData.sector_data.keys()[temp_data["sector"]],
				" - Zone: ",AutoloadData.sector_data[temp_data["sector"]][temp_data["zone"]]["name"] )
		else:
			if temp_data == null: txt.text = "-"
			else: txt.text = str(data[_person_keys_dict[i + 3]])
	# disabled btn items job & set progress, resources, count
	var data_items:Dictionary = AutoloadData.all_npc[code]["inventory"]
	var data_prog:Dictionary = AutoloadData.all_npc[code]["stat"]
	for i in vbox_tools_item.get_child_count():
		var hbox_items = vbox_tools_item.get_child(i).get_node("vbox/hbox_item")
		for ii in hbox_items.get_child_count()-1:
			# btn disabled
			var btn:Button = hbox_items.get_child(ii)
			var keys = tools.tools_code[i]
			var txt_sold:Label = btn.get_node("txt")
			var get_bool = data_items[keys][ii]
			btn.disabled = get_bool
			txt_sold.visible = get_bool
			# progress
			var vbox_prog = hbox_items.get_node("vbox")
			var prog_0:TextureProgressBar = vbox_prog.get_node("hbox_0/prog")
			var prog_1:TextureProgressBar = vbox_prog.get_node("hbox_1/prog")
			var count_0:Label = vbox_prog.get_node("hbox_0/count")
			var count_1:Label = vbox_prog.get_node("hbox_1/count")
			prog_0.value = data_prog[i]["sources"]
			prog_1.value = data_prog[i]["progress"]
			count_0.text = str(data_prog[i]["sources"])
			count_1.text = str(data_prog[i]["progress"])
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

var _npc_job = {
	"Farm": {0:false, 1:false, 2:false, 3:false, 4:false},
	"Fisher": {0:false, 1:false, 2:false, 3:false, 4:false},
	"Hunter": {0:false, 1:false, 2:false, 3:false, 4:false},
	"Miner": {0:false, 1:false, 2:false, 3:false, 4:false},
	"Thief": {0:false, 1:false, 2:false, 3:false, 4:false} }
# NPC DICT
func _new_npc(sector, zona):
	var npc_data = NPC_generator.new()
	var new_npc:Dictionary = npc_data.npc_new()
	var _npc_id = new_npc.keys()[0]
	var _npc_data = new_npc[_npc_id]
	_npc_data["stat"] = {
		0:{"sources":randi_range(0, 100), "progress":randi_range(0, 100)},
		1:{"sources":randi_range(0, 100), "progress":randi_range(0, 100)},
		2:{"sources":randi_range(0, 100), "progress":randi_range(0, 100)},
		3:{"sources":randi_range(0, 100), "progress":randi_range(0, 100)},
		4:{"sources":randi_range(0, 100), "progress":randi_range(0, 100)} }
	_npc_data["inventory"] = _npc_job
	_npc_data["location"] = {"sector":sector, "zone":zona}
	AutoloadData.all_npc[_npc_id] = _npc_data
	AutoloadData.save_data()
	return _npc_id
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
	
	var npc = _new_npc(sector, rng_sector)
	main_spawn.connect("pressed", person_inspect.bind(npc) )
	
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
@onready var node_cam_loc = $canvas_l/cam_loc
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

	# Buat tween baru
	tween = create_tween()
	tween.set_parallel(true)

	# Hitung posisi target
	var target_cam_pos = node_main_cam.position + offset

	# Tween posisi kamera
	tween.tween_property(node_main_cam, "position", target_cam_pos, 0.1)

	# Setelah selesai, update teks label posisi kamera
	tween.tween_callback(Callable(self, "_update_cam_loc_label"))
func _update_cam_loc_label():
	var pos = node_main_cam.position.round()
	node_cam_loc.text = 'X:%d, Y:%d' % [pos.x, pos.y]
func _on_btn_snap_pressed():
	if is_snapping:
		# Jika sedang dalam proses snap, batalkan snap
		_cancel_snap()
		return
	_start_snap_process()
# -------------------- UTYLITY FUNC ------------------------
func _path_icon_profile(code):
	return str("res://img/Gate/PP/",code,".png")
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
	node_cam_loc.text = str("X: 0, Y:0")
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
