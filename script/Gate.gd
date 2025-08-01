extends Node
enum ENUM_ICON_SPAWN_BLUE { VILLAGE, KINGDOM, HOUSE, OLD_RUIN, GRAVE, RUIN, CAMP, TOWER, BUOY, SHIP, ISLAND, BUOY_SIGNAL, TASK, CASTLE,
	FISH, FEMALE, MALE, VIKING_F, VIKING_M, WIZARD_M, WIZARD_F }
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
	onready_btn_dg_break()
	onready_dg_gate()
	# TIME
	game_time = AutoloadData.gate_date.duplicate(true)
	update_time_ui()
	# BTN
	node_sldv_cam.value_changed.connect(onready_cam_zoom)
	
	var main_btn:Button = $canvas_l/parent_btn_move/Button
	main_btn.connect("pressed", func():
		rng_spawn(true, 0, _path_icon_spawn_blue(randi_range(0, 13)), randi_range(0, 2) as ENUM_ICON_SPAWN_MARK) )

func _process(delta):
	if is_time_paused:
		return

	_time_accumulator += delta
	while _time_accumulator >= SECONDS_PER_GAME_HOUR:
		advance_hour()
		_time_accumulator -= SECONDS_PER_GAME_HOUR
		update_time_ui()

# --------------------------------------
# DUNGEON BREAK
# --------------------------------------
@onready var btn_dg_break_switch:Button = $canvas_l/btn_cls_dg_break
var currect_party = [null, null, null]

func onready_btn_dg_break():
	# btn switch dg & party
	var _dg_panel_1:VBoxContainer = btn_dg_break_switch.get_node("pnlc").get_child(0)
	var _dg_panel_2:VBoxContainer = btn_dg_break_switch.get_node("pnlc").get_child(1)
	for i in btn_dg_break_switch.get_child_count():
		var btn:Button = btn_dg_break_switch.get_node("pnlc").get_child(i).get_node("btn_switch")
		btn.pressed.connect(func():
			SfxManager.play_click()
			_dg_panel_1.visible = !_dg_panel_1.visible
			_dg_panel_2.visible = !_dg_panel_2.visible )
	# btn main cls
	btn_dg_break_switch.pressed.connect(func():
		btn_dg_break_switch.hide() )
		#await get_tree().create_timer(2).timeout
		#btn_dg_break_switch.show() )
# --------------------------------------
# TIME SIMULATION 1 SEC LOCAL TIME = 1 HOUR IN GAME
# --------------------------------------
@onready var parent_time = $canvas_l/pnl_time
@onready var nodes_time = {
	"curr_day":parent_time.get_node("hbox/day"),	# label current day
	"date":parent_time.get_node("hbox/vbox/date"),	# label date example: 1/1/1500
	"time":parent_time.get_node("hbox/vbox/time"),}	# label time example: 21:00 
var game_time = { "day_in": 0, "day": 1, "mounth": 1, "year": 1500, "hour": 0 }
const SECONDS_PER_GAME_HOUR = 1.0 / 3.0
var _time_accumulator = 0.0

func advance_hour():
	game_time.hour += 1
	if game_time.hour >= 24:
		game_time.hour = 0
		game_time.day += 1
		game_time.day_in += 1
		if game_time.day > 30:
			game_time.day = 1
			game_time.mounth += 1
			if game_time.mounth > 12:
				game_time.mounth = 1
				game_time.year += 1
	AutoloadData.gate_date = game_time.duplicate(true)
	AutoloadData.save_data()

func update_time_ui():
	nodes_time.curr_day.text = 'Day %s' % str(game_time.day_in)
	nodes_time.date.text = '%s/%s/%s' % [game_time.day, game_time.mounth, game_time.year]
	nodes_time.time.text = '%02d:00' % game_time.hour

# Utility functions
func get_current_datetime_string() -> String:
	return '%02d/%02d/%04d %02d:00' % [game_time.day, game_time.mounth, game_time.year, game_time.hour]
# Set Custom times
func set_time(hour: int, day: int, mounth: int, year: int):
	game_time.hour = hour
	game_time.day = day
	game_time.mounth = mounth
	game_time.year = year
	AutoloadData.gate_date = game_time.duplicate(true)
	AutoloadData.save_data()
	update_time_ui()
# Skil hours
func skip_hours(amount: int):
	for i in range(amount):
		advance_hour()
# Skil Days
func skip_days(amount: int):
	for i in range(amount):
		game_time.hour = 0
		advance_hour()
# Paused game
var is_time_paused = false
func pause_time(state: bool) -> void:
	is_time_paused = state
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
	1:{0:100, 1:1, 2:35, 3:2, 4:20},
	2:{0:10, 1:50, 2:30, 3:1, 4:5},
	3:{0:2, 1:20, 2:1, 3:200, 4:30},
	4:{0:300, 1:250, 2:100, 3:500, 4:100}, }
const _trade_value = {
	0:{0:10, 1:20, 2:20, 3:10, 4:5},
	1:{0:250, 1:1, 2:50, 3:2, 4:100},
	2:{0:25, 1:100, 2:75, 3:10, 4:5},
	3:{0:2, 1:150, 2:1, 3:300, 4:30},
	4:{0:500, 1:500, 2:150, 3:1000, 4:200}, }

var _temp_trade_data = { "item_code":null, "item_price":null, "npc_code":null, "min":0, "max":0 }
# Utility for trade
func _calculate_power(physical: int, intelligence: int, communication: int, wisdom: int) -> int:
	# Clamp semua input agar tetap 0 - 100
	physical = clamp(physical, 0, 100)
	intelligence = clamp(intelligence, 0, 100)
	communication = clamp(communication, 0, 100)
	wisdom = clamp(wisdom, 0, 100)
	# Bobot kontribusi tiap atribut
	var weight_physical = 0.35
	var weight_intelligence = 0.25
	var weight_communication = 0.2
	var weight_wisdom = 0.2
	# Hitung total power (maksimum 100), lalu skalakan ke 0–10_000
	var power = (
		physical * weight_physical +
		intelligence * weight_intelligence +
		communication * weight_communication +
		wisdom * weight_wisdom )

	var scaled_power = power * 100.0
	return int(round(scaled_power))

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
		pause_time(false)
		update_currency() )
	# btn switch info and trade
	var btn_act:Button = person_trade["btn_act"]
	btn_act.text = "GIFT"
	btn_act.connect("pressed", func():
		if person_trade["btn_act"].text == "GIFT":
			btn_act.text = "INFO"
			person_trade["hbox_trade"].show()
			person_trade["hbox_info"].hide()
		else:
			btn_act.text = "GIFT"
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
		AutoloadData.all_npc[_temp_trade_data["npc_code"]]["item_count"][curr_job][curr_item]+=_current_tool["count"]
		AutoloadData.all_npc[_temp_trade_data["npc_code"]]["stat"][curr_job]["sources"]+=_trade_value[curr_job][curr_item]*_current_tool["count"]
		AutoloadData.gate_coin_cummon-=current_price
		AutoloadData.save_data()
		person_inspect(_temp_trade_data["npc_code"]) )
	
func person_inspect(code):
	if AutoloadData.all_npc.has(code)== false: return
	pause_time(true)
	print(AutoloadData.all_npc[code]["power"])
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
		if i == 1:
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
			var txt_count:Label = btn.get_node("count")
			var get_bool = data_items[keys][ii]
			btn.disabled = get_bool
			txt_sold.visible = get_bool
			txt_count.text = str(data["item_count"][i][ii])
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
	var _dict_key = ["danger","mining","soil_index","treasure","water_index"]
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
# DUNNGEON GATE
# --------------------------------------
@onready var btn_cls_dg_gate = $canvas_l/btn_cls_dg_break

@onready var vbox_member = $canvas_l/btn_cls_dg_break/pnlc/vbox_party/vbox
func onready_dg_gate():
	for i in range(3):
		var path_btn = str("pnl_party_",i)
		var btn:Button = vbox_member.get_node(str(path_btn,"/hbox/btn_inspect"))
		btn.connect("pressed", func():
			SfxManager.play_click()
			if currect_party[i]==null: return
			person_inspect(currect_party[i]) )
			
@onready var dg_gate_vbox_main = $canvas_l/btn_cls_dg_break/pnlc/vbox_main
@onready var dg_gate_vbox_party = $canvas_l/btn_cls_dg_break/pnlc/vbox_party
@onready var nodes_dg_gate = {
	"img":dg_gate_vbox_main.get_node("img"),
	"name":dg_gate_vbox_main.get_node("txt_name"),
	"desc":dg_gate_vbox_main.get_node("scrol_c/vbox/txt_desc"),
	"power":dg_gate_vbox_main.get_node("txt_power"),
	"prog":vbox_member.get_node("hbox_prog/prog_main"),
	"rwd":dg_gate_vbox_party.get_node("rwd") }

func _update_npcs(code_npc, code_party):
	dg_gate_vbox_main.show()
	dg_gate_vbox_party.hide()
	var dg_desc_data = Gate_desc.new()
	var main_dg = AutoloadData.gate_party[code_party]
	var _gate_level = main_dg["gate"]["main"]
	nodes_dg_gate["img"].texture = load(dg_desc_data.dg_break_data[_gate_level]["img"])
	nodes_dg_gate["name"].text = str(dg_desc_data.dg_break_data[_gate_level]["name"], " (Monster Level: ",_gate_level,")")
	nodes_dg_gate["desc"].text = dg_desc_data.dg_break_data[_gate_level]["desc"]
	nodes_dg_gate["rwd"].text = str("Reward: ", AutoloadData.filter_num_k(dg_desc_data.dg_break_data[_gate_level]["rwd"]))
	var keys_code = ['physical', 'intelligence', 'communication', 'wisdom']
	var total_npc_power:int = 0
	var total_enem_power = AutoloadData.gate_party[code_party]["gate"]["power"]
	nodes_dg_gate["power"].text = AutoloadData.filter_num_k(total_enem_power)
	for i in range(3):
		var _npc_data = AutoloadData.all_npc[code_npc[i]]
		var pwr = _calculate_power(_npc_data[keys_code[0]], _npc_data[keys_code[1]], _npc_data[keys_code[2]], _npc_data[keys_code[3]])
		total_npc_power+=pwr
		var path_btn = str("pnl_party_",i)
		var txt_name:Label = vbox_member.get_node( str(path_btn,"/hbox/txt_name") )
		var txt_power:Label = vbox_member.get_node( str(path_btn,"/hbox/txt_power") )
		txt_name.text = str(_npc_data["name"])
		txt_power.text = AutoloadData.filter_num_k(pwr)
	nodes_dg_gate["power"].text = AutoloadData.filter_num_k(total_enem_power)
	nodes_dg_gate["prog"].value = compare_power_strength(total_npc_power, total_enem_power)
		
func dg_gate_inspect(code_party):
	if AutoloadData.gate_party.has(code_party)== false:
		SfxManager.play_system_fail()
		return
	SfxManager.play_click()
	btn_cls_dg_gate.show()
	var party = AutoloadData.gate_party[code_party]["member"]
	_update_npcs(party, code_party)
func compare_power_strength(value_a: int, value_b: int) -> int:
	if value_a == value_b:
		return 50
	if value_a + value_b == 0:
		return 50  # kasus khusus kalau dua-duanya nol

	var ratio = float(value_a) / float(value_a + value_b)
	return int(round(ratio * 100))
# utility func
func calculate_dg_pct(danger_val: int) -> int:
	danger_val = clamp(danger_val, 0, 100)
	var max_level := 5

	if danger_val < 10:
		max_level = 5
	elif danger_val < 20:
		max_level = 10
	elif danger_val < 40:
		max_level = 13
	elif danger_val < 60:
		max_level = 15
	elif danger_val < 80:
		max_level = 17
	elif danger_val < 100:
		max_level = 19
	else:
		max_level = 20

	# Distribusi berbobot: semakin tinggi danger_val, peluang level tinggi makin besar
	var curve := danger_val / 100.0
	var weighted := pow(randf(), 1.0 - curve)
	return int(weighted * (max_level - 1)) + 1


# --------------------------------------
# SECTOR SWPAN
# --------------------------------------
@onready var nodes_all_sector = $all_sector
@onready var node_btn_prosed_spawn:Button = $btn_prosed
# utility for npc data items
# Hitung peluang item bernilai true berdasarkan statistik NPC (jika tidak terkena penalti)
func _calculate_true_chance(job: String, stats: Dictionary) -> float:
	match job:
		"Farm":
			return 0.0  # Tidak pernah punya item
		"Fisher":
			var strength = stats["physical"]
			var wisdom = stats["wisdom"]
			if strength >= 80 and wisdom >= 98:
				return 0.25
			elif strength >= 70 and wisdom >= 95:
				return 0.1
			else:
				return 0.0  # Tidak layak, akan di-handle penalti slot
		"Hunter":
			var strength = stats["physical"]
			var intelligence = stats["intelligence"]
			var communication = stats["communication"]
			if strength >= 98 and intelligence >= 80 and communication >= 80:
				return 0.3
			elif strength >= 95 and intelligence >= 65 and communication >= 65:
				return 0.1
			else:
				return 0.0
		"Miner":
			var strength = stats["physical"]
			var wisdom = stats["wisdom"]
			var intelligence = stats["intelligence"]
			if strength >= 85 and wisdom >= 95 and intelligence < 20:
				return 0.25
			elif strength >= 75 and wisdom >= 90 and intelligence <= 40:
				return 0.1
			else:
				return 0.0
		"Thief":
			var strength = stats["physical"]
			var intelligence = stats["intelligence"]
			var communication = stats["communication"]
			var wisdom = stats["wisdom"]
			if strength <= 5 and intelligence >= 98 and communication >= 98 and wisdom <= 10:
				return 0.3
			elif strength <= 15 and intelligence >= 95 and communication >= 95 and wisdom <= 25:
				return 0.1
			else:
				return 0.0
		_:
			return 0.0
# Hasilkan data inventory berdasarkan pekerjaan dan statistik NPC
func _generate_inventory_for_npc(stats: Dictionary) -> Dictionary:
	var result = {}
	var jobs = ["Farm", "Fisher", "Hunter", "Miner", "Thief"]

	for job in jobs:
		var items = {0: false, 1: false, 2: false, 3: false, 4: false}
		var chance = _calculate_true_chance(job, stats)
		# Penanganan khusus penalti untuk job tertentu
		match job:
			"Fisher":
				var strength = stats["physical"]
				var wisdom = stats["wisdom"]
				if strength < 70:
					items[2] = true
					items[4] = true
				if wisdom < 90:
					items[0] = true
			"Hunter":
				var strength = stats["physical"]
				var intelligence = stats["intelligence"]
				if strength < 95:
					items[1] = true
					items[2] = true
				if intelligence < 65:
					if randf() < 0.8:
						items[0] = true
					if randf() < 0.8:
						items[3] = true
			"Miner":
				var strength = stats["physical"]
				if strength < 75:
					items[1] = true
					items[3] = true
			"Thief":
				var communication = stats["communication"]
				var intelligence = stats["intelligence"]
				if communication < 95:
					items[0] = true
					items[1] = true
					items[3] = true
				if intelligence < 95:
					items[3] = true
					items[4] = true
		# Jika tidak kena penalti di suatu slot, pakai peluang true normal
		for i in range(5):
			if items[i] == false and chance > 0.0:
				items[i] = randf() < chance
		result[job] = items
	return result
# NPC DICT
func _new_npc(sector, zona):
	var npc_data = NPC_generator.new()
	var new_npc:Dictionary = npc_data.npc_new()
	var _npc_id = new_npc.keys()[0]
	var _npc_data = new_npc[_npc_id]
	var keys_code = ['physical', 'intelligence', 'communication', 'wisdom']
	# add new data dict
	_npc_data["stat"] = {
		0:{"sources":0, "progress":0},
		1:{"sources":0, "progress":0},
		2:{"sources":0, "progress":0},
		3:{"sources":0, "progress":0},
		4:{"sources":0, "progress":0} }
	_npc_data["inventory"] = _generate_inventory_for_npc(_npc_data)
	_npc_data["location"] = {"sector":sector, "zone":zona}
	_npc_data["spawn"] = {"position":[], "main":"", "mark":"" }
	_npc_data["item_count"] = {0:[0, 0, 0, 0, 0],1:[0, 0, 0, 0, 0],2:[0, 0, 0, 0, 0],3:[0, 0, 0, 0, 0],4:[0, 0, 0, 0, 0],}
	_npc_data["global_pos"] = ""
	_npc_data["power"] = _calculate_power(_npc_data[keys_code[0]], _npc_data[keys_code[1]], _npc_data[keys_code[2]], _npc_data[keys_code[3]])
	AutoloadData.all_npc[_npc_id] = _npc_data
	AutoloadData.save_data()
	return _npc_id
# is rng == true: for first spawn || false: for func _ready (load)
# npc code: code spawn
func rng_spawn(is_rng: bool, sector, main, mark:ENUM_ICON_SPAWN_MARK, get_party_id = ""):
	var get_sector_main = nodes_all_sector.get_child(sector)
	var rng_sector = randi_range(0, get_sector_main.get_child_count() - 1)
	var get_sector = get_sector_main.get_child(rng_sector) as Panel
	# data new spawn
	var sector_max_x = get_sector.size.x - 50
	var sector_max_y = get_sector.size.y - 50
	# data temp
	var pos_x = 0
	var pos_y = 0
	var radaar_img = ""
	var btn_icon = ""
	# data unility
	var main_spawn: Button = node_btn_prosed_spawn.duplicate()
	var spawn_img: TextureRect = main_spawn.get_node("bg")
	var radar_size = randi_range(200, 250)
	# data db temp
	var _gate_party:Array = []
	# make uniq id then save party to db
	var npc_data = NPC_generator.new()
	var party_id = npc_data._generate_unique_id()
	# gate 
	var rng_gate_locaion = randi_range(0, get_sector_main.get_child_count() - 1)
	
	AutoloadData.gate_party[party_id]={}
	# confirm
	if is_rng:
		# make 3 new npc and assign all to party
		for i in range(3):
			# make new npc and auto saved to db: all_npc
			var _rng_sector = randi_range(0, get_sector_main.get_child_count() - 1)
			var new_npc = _new_npc(sector, _rng_sector)
			# new npc return id npc then save to temp arr
			_gate_party.append(new_npc)
			# new dict data for every npc
			AutoloadData.all_npc[new_npc]["spawn"] = {
				"position": [randi_range(0, sector_max_x), randi_range(0, sector_max_y)] }
		# save db for party data
		AutoloadData.gate_party[party_id]["member"] = _gate_party
		AutoloadData.gate_party[party_id]["btn_icon"] = main
		AutoloadData.gate_party[party_id]["radar_img"] = _path_icon_spawn_mark(mark)
		AutoloadData.gate_party[party_id]["radar_size"] = radar_size
		AutoloadData.gate_party[party_id]["location"] = {"sector":sector, "zone":rng_gate_locaion}
		AutoloadData.gate_party[party_id]["position"] = [randi_range(0, sector_max_x), randi_range(0, sector_max_y)]
		var data_gate_desc = Gate_desc.new()
		var rng_monster = calculate_dg_pct(AutoloadData.sector_data[sector][rng_gate_locaion]["danger"])
		var rng_rwd = data_gate_desc.dg_break_data[rng_monster]["rwd"]
		var rng_pwr = data_gate_desc.dg_break_data[rng_monster]["power"]
		AutoloadData.gate_party[party_id]["gate"] = {"rwd": rng_rwd, "power":rng_pwr, "main":rng_monster}
		# set local pos
		pos_x = AutoloadData.gate_party[party_id]["position"][0]
		pos_y = AutoloadData.gate_party[party_id]["position"][1]
	else:
		if AutoloadData.gate_party.has(get_party_id)==false: return
		
			
	# get icon btn
	btn_icon = main
	# get img radar
	radaar_img = _path_icon_spawn_mark(mark)
	# Set ukuran dan posisi texture background
	spawn_img.size = Vector2(radar_size, radar_size)
	spawn_img.position = -(spawn_img.size / 2)
	# Set ikon tombol dan radar
	spawn_img.texture = load(radaar_img)
	main_spawn.icon = load(btn_icon)
	# connect btn
	main_spawn.connect("pressed", func():
		for i in range(3):
			currect_party[i]=_gate_party[i]
		dg_gate_inspect(party_id) )
	# child to parent
	main_spawn.show()
	get_sector.add_child(main_spawn)
	
	main_spawn.position = Vector2(pos_x, pos_y)
	# Simpan data
	var gb_pos = Vector2(main_spawn.global_position.x, main_spawn.global_position.y)
	# save new data (global pos)
	AutoloadData.gate_party[party_id]["global_pos"] = gb_pos
	AutoloadData.save_data()
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
var _nav_speed = 100
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
	if tween: tween.kill()
	# Hitung posisi target dan batasi antara -8000 sampai 8000
	var raw_target = node_main_cam.position + offset
	var clamped_target = Vector2(
		clamp(raw_target.x, -8000, 8000),
		clamp(raw_target.y, -8000, 8000) )
	# Buat tween baru
	tween = create_tween()
	tween.set_parallel(true)
	# Tween posisi kamera
	tween.tween_property(node_main_cam, "position", clamped_target, 0.1)
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
