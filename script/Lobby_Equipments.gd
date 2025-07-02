extends Node2D
class_name Lobby_equipments

var img_data = Load_images.new()
func filter_num_k(value: int) -> String:
	if value >= 1000000000000000: # Quadrillion (Qa)
		return "%.2fQa" % (value / 1000000000000000.0)
	elif value >= 1000000000000: # Trillion (T)
		return "%.2fT" % (value / 1000000000000.0)
	elif value >= 1000000000: # Billion (B)
		return "%.2fB" % (value / 1000000000.0)
	elif value >= 1000000: # Million (M)
		return "%.2fM" % (value / 1000000.0)
	elif value >= 1000: # Thousand (K)
		return "%.2fK" % (value / 1000.0) # Memastikan angka tetap dua desimal
	return str(value)
var btn_switch = {
	true:preload("res://Themes/THEME V3/BTN_BLUE.tres"),
	false:preload("res://Themes/THEME V3/BTN_FOR_SWITCH.tres") }
var btn_handle = {
	true: "res://img/UI (new)/Deck/select_all.png",
	false: "res://img/UI (new)/Deck/select_all_disabled.png" }
func handle_all_btn(handle_bool:bool, main_btn: Dictionary, gear_bool: Dictionary, grade_bool: Dictionary) -> Dictionary:
	handle_bool = !handle_bool
	for _key in gear_bool.keys(): gear_bool[_key]=handle_bool
	for _key in  grade_bool.keys(): grade_bool[_key]=handle_bool
	for i in range(1, 12):
		var btn: Button = main_btn[i]
		btn.icon = img_data.img_inven_gear[i][gear_bool[i]]
	for i in range(12, 17):
		var btn: Button = main_btn[i]
		btn.theme = btn_switch[grade_bool[i]]
	return {"_bool":handle_bool}
func set_btn_filter(main_btn: Dictionary, gear_bool: Dictionary, grade_bool: Dictionary) -> void:
	# Handle tombol untuk gear (slot 1–11)
	for i in range(1, 12):
		if main_btn.has(i):
			var btn: Button = main_btn[i]
			btn.connect("pressed", func():
				gear_bool[i] = !gear_bool[i]
				btn.icon = img_data.img_inven_gear[i][gear_bool[i]]
			)
		else:
			push_warning("Tombol gear index %d tidak ditemukan!" % i)

	# Handle tombol untuk grade (slot 12–16)
	for i in range(12, 17):
		if main_btn.has(i):
			var btn: Button = main_btn[i]
			btn.connect("pressed", func():
				grade_bool[i] = !grade_bool[i]
				btn.theme = btn_switch[grade_bool[i]]
			)
		else:
			push_warning("Tombol grade index %d tidak ditemukan!" % i)
func _eq_gear_confirm(code) -> Dictionary:
	var _data = {
	'eq_wpn_melee': 1,
	'eq_wpn_wiz': 2,
	'eq_armor': 3,
	'eq_gloves': 4,
	'eq_helm': 5,
	'eq_shoes': 6,
	'eq_trouser': 7,
	'eq_acc_ring': 8,
	'eq_acc_earring': 9,
	'eq_acc_amuelt': 10,
	'eq_acc_belt': 11}
	return {
		"id":code,
		"code":_data[code]
	}
func _eq_grade_confirm(code) -> Dictionary :
	var _data = {"A":12, "S":13, "SS":14, "SSS":15, "UR":16}
	return {
		"id":code,
		"code":_data[code]
	}
func stat_code_tier(tier_txt):
	var color_code = "#FFFFFF"  # Default warna putih jika tier tidak dikenali
	
	match tier_txt:
		"GRADE: D": color_code = "#a57638"
		"GRADE: C": color_code = "#3db854"
		"GRADE: B": color_code = "#2c6cd7"
		"GRADE: A": color_code = "#ae28e0"
		"GRADE: S": color_code = "#FF9100"
		"GRADE: SS": color_code = "#FFF000"
		"GRADE: SSS": color_code = "#ff3d3d"
		"GRADE: UR": color_code = "#00f6ff"
		
	return "[color=%s]%s[/color]" % [color_code, tier_txt]

func stat_code(code, value):
	match code:
		"atk_flat":return filter_num_k(value)
		"atk_pct":return str(filter_num_k(value),"%")
		"def_flat":return filter_num_k(value)
		"def_pct":return str(filter_num_k(value),"%")
		"hp_flat":return filter_num_k(value)
		"hp_pct":return str(filter_num_k(value),"%")
		"turn_flat":return str(filter_num_k(value))
		"turn_pct":return str(filter_num_k(value),"%")
		"crit_rate":return str(filter_num_k(value),"%")
		"crit_dmg":return str(filter_num_k(value),"%")
		"spd_flat":return filter_num_k(value)
		"eva_flat":return filter_num_k(value)
		"crit_def":return str(filter_num_k(value),"%")
func stat_code_indic(code):
	match code:
		"atk_flat", "atk_pct":return "Attack: +"
		"def_flat", "def_pct":return "Defense: +"
		"hp_flat", "hp_pct":return "Health: +"
		"turn_flat", "turn_pct":return "Turn Speed: +"
		"crit_rate":return "Critical Rate: +"
		"crit_dmg":return "Critical Damage: +"
		"spd_flat":return "Speed Attack: +"
		"eva_flat":return "Evation: +"
		"crit_def":return "Critical Defense: +"
func stat_code_indic_clear(code):
	match code:
		"atk_flat", "atk_pct":return "Attack"
		"def_flat", "def_pct":return "Defense"
		"hp_flat", "hp_pct":return "Health"
		"turn_flat", "turn_pct":return "Turn Speed"
		"crit_rate":return "Critical Rate"
		"crit_dmg":return "Critical Damage"
		"spd_flat":return "Speed Attack"
		"eva_flat":return "Evation"
		"crit_def":return "Critical Defense"
func sort_equipments(bool_gear:Dictionary, bool_grade:Dictionary) -> Array :
	var arr_gear:Array = []
	var arr_grade:Array = []
	
	var num_gear=1
	for _key in bool_gear.keys():
		if bool_gear[_key]==true: arr_gear.append(num_gear)
		num_gear+=1
		
	var num_grade=12
	for _key in bool_grade.keys():
		if bool_grade[_key]==true: arr_grade.append(num_grade)
		num_grade+=1
	
	var temp_arr:Array = []
	
	for _key in AutoloadData.player_equipment.keys():
		var _gear = _eq_gear_confirm(AutoloadData.player_equipment[_key]["id_gb"])["code"] in arr_gear
		var _grade = _eq_grade_confirm(AutoloadData.player_equipment[_key]["grade_txt"])["code"] in arr_grade
		if _gear and _grade: temp_arr.append(_key)
		
	return temp_arr
func new_equipment(_prosed:PanelContainer, _parent:HFlowContainer, _key, inspect_pnl, pnl_ask, _super_node, pnl_enhance, pnl_gear_to_del, gearset_parent):
	var new_item:PanelContainer = _prosed.duplicate()
	var _get_icon:TextureRect = new_item.get_node("hbox/icon")
	var get_icon_indic:TextureRect = new_item.get_node("hbox/icon/icon_eq")
	var get_gs_indic:TextureRect = new_item.get_node("hbox/icon/icon_gs")
	var get_card_indic:TextureRect = new_item.get_node("hbox/icon/icon_card")
	var get_enhance:Label = new_item.get_node("hbox/icon/enhance")
	var get_icon_stat_1:TextureRect = new_item.get_node("hbox/vflow/icon_stat_1")
	var get_desc_stat_1:RichTextLabel = new_item.get_node("hbox/vflow/desc_stat_1")
	var get_icon_stat_2:TextureRect = new_item.get_node("hbox/vflow/icon_stat_2")
	var get_desc_stat_2:RichTextLabel = new_item.get_node("hbox/vflow/desc_stat_2")
	var get_icon_stat_3:TextureRect = new_item.get_node("hbox/vflow/icon_stat_3")
	var get_desc_stat_3:RichTextLabel = new_item.get_node("hbox/vflow/desc_stat_3")
	var get_btn_switch:Button = new_item.get_node("hbox/icon/btn_switch")
	
	get_btn_switch.connect("pressed", func():
		inspect_eq(inspect_pnl, _key, pnl_ask, _super_node, pnl_enhance, pnl_gear_to_del, gearset_parent))
	
	var _data = AutoloadData.player_equipment[_key]
	var _set_icon = load(_data["icon_raw"])
	if AutoloadData.player_equipment[_key]["is_equiped"] is bool:
		get_card_indic.hide()
		get_card_indic.texture = null
	else:
		var _data_card = Card_data_s1.new()
		get_card_indic.show()
		get_card_indic.texture = load(_data_card.dict_all_card_s1[AutoloadData.player_equipment[_key]["is_equiped"]]["icon"])
	new_item.name = _data["id_node"]
	_get_icon.texture = _set_icon
	get_icon_indic.texture = img_data.img_eq_main(_data["id_gb"])
	get_gs_indic.texture = load(img_data.img_gs_main(_data["gs"], true))
	get_enhance.text = str("+",_data["enhance_main"])
	get_icon_stat_1.texture = img_data.img_eq_stat(_data["stat_1"]["stat_code"])
	get_icon_stat_2.texture = img_data.img_eq_stat(_data["stat_2"]["stat_code"])
	get_icon_stat_3.texture = img_data.img_eq_stat(_data["stat_3"]["stat_code"])
	
	get_desc_stat_1.text = stat_code( _data["stat_1"]["stat_code"], _data["stat_1"]["stat_main"] ) + '[color=' + str(_data['stat_1']['stat_color']) + ']' + ' ( ' + str(_data['stat_1']['stat_grade']) + ' )' + '[/color]'
	get_desc_stat_2.text = stat_code( _data["stat_2"]["stat_code"], _data["stat_2"]["stat_main"] ) + '[color=' + str(_data['stat_2']['stat_color']) + ']' + ' ( ' + str(_data['stat_2']['stat_grade']) + ' )' + '[/color]'
	get_desc_stat_3.text = stat_code( _data["stat_3"]["stat_code"], _data["stat_3"]["stat_main"] ) + '[color=' + str(_data['stat_3']['stat_color']) + ']' + ' ( ' + str(_data['stat_3']['stat_grade']) + ' )' + '[/color]'
	
	_parent.add_child(new_item)
	new_item.show()
func slide_manager(arr_total: int) -> Dictionary:
	var max_item = 64
	var total_slide = 0
	var total_slide_reminder = 0
	var counter = 0

	for i in arr_total:
		counter += 1
		if counter == max_item:
			total_slide += 1
			counter = 0

	if counter > 0:
		total_slide += 1
		total_slide_reminder = counter
	else:
		total_slide_reminder = max_item

	return {
		"total_slide": total_slide,
		"total_slide_reminder": total_slide_reminder,
		"max_item": max_item }
# ----------------------- UI INSPECT EQ ------------------------------
func get_pct(value, pct):
	return (value * pct) / 100
func set_pct(value_ask, target_to_pct):
	if target_to_pct == 0:
		return 0
	return int((float(value_ask) / target_to_pct) * 100)
func get_pnl_ask_sell(pnl_main:Panel, pnl_parent:Node, get_gear, btn_upgrade:Button, btn_sell:Button, gearset_parent:Node):
	var new_pnl:Panel = pnl_main.duplicate()
	pnl_parent.add_child(new_pnl)
	new_pnl.visible=true
	var get_header: Label = new_pnl.get_node("panel_c/vbox/header") as Label
	var get_desc: RichTextLabel = new_pnl.get_node("panel_c/vbox/scrolc/main_txt") as RichTextLabel
	var get_btn_yes: Button = new_pnl.get_node("panel_c/vbox/hbox/btn_yes") as Button
	var get_btn_no: Button = new_pnl.get_node("panel_c/vbox/hbox/btn_no") as Button
	
	get_btn_yes.text = "SELL"
	get_header.text = "Are You Sure ?"
	get_desc.text = str("Sold items will be permanently lost (non-refundable), and you will receive gold equal to their value.\n",
	"Total:[color=gold] ",filter_num_k(AutoloadData.player_equipment[local_code]["sell"])," GOLD[/color]")
	
	dc_conn_btn(get_btn_yes)
	dc_conn_btn(get_btn_no)
	var callbback_yes = func():
		var temp_to_del = AutoloadData.player_equipment[local_code]["id_node"]
		AutoloadData.player_money+=AutoloadData.player_equipment[local_code]["sell"]
		AutoloadData.player_equipment.erase(local_code)
		get_gear.get_node(temp_to_del).queue_free()
		var node_to_delete = gearset_parent.find_child(temp_to_del, true, false)
		if node_to_delete:
			node_to_delete.queue_free()
		AutoloadData.save_data()
		new_pnl.queue_free()
		btn_upgrade.text = "SELLED !"
		btn_upgrade.disabled=true
		btn_sell.text="SELLED"
		btn_sell.disabled=true
	var callback_no = func():
		new_pnl.queue_free()

	get_btn_yes.pressed.connect(callbback_yes)
	get_btn_no.pressed.connect(callback_no)
	
func get_pnl_ask(confirm: bool, _main_node: Panel, str_header, str_desc, btn_callable: Callable, _super_node: Node, pnl_enhance:Panel):
	# Hapus panel lama jika ada
	for child in _super_node.get_children():
		if child.name == "pnl_ask_instance":
			child.queue_free()

	var new_pnl: Panel = _main_node.duplicate()
	new_pnl.name = "pnl_ask_instance"
	_super_node.add_child(new_pnl)

	var pnl_ask_header: Label = new_pnl.get_node("panel_c/vbox/header") as Label
	var pnl_ask_desc: RichTextLabel = new_pnl.get_node("panel_c/vbox/scrolc/main_txt") as RichTextLabel
	var pnl_ask_btn_yes: Button = new_pnl.get_node("panel_c/vbox/hbox/btn_yes") as Button
	var pnl_ask_btn_no: Button = new_pnl.get_node("panel_c/vbox/hbox/btn_no") as Button

	# -------------------------- ENHANCE PANEL :START --------------------------------
	var enhance_img:TextureRect = pnl_enhance.get_node("main_gear")
	var enhance_name:Label = pnl_enhance.get_node("pnlc/hbox/main_name")
	var enhance_up_before:Label = pnl_enhance.get_node("pnlc/hbox/main_stat/stat_before")
	var enhance_up_after:RichTextLabel = pnl_enhance.get_node("pnlc/hbox/main_stat/stat_afater")
	var enhance_stat1_before:Label = pnl_enhance.get_node("pnlc/hbox/stat_1/stat_before")
	var enhance_stat1_after:RichTextLabel = pnl_enhance.get_node("pnlc/hbox/stat_1/stat_afater")
	var enhance_stat2_before:Label = pnl_enhance.get_node("pnlc/hbox/stat_2/stat_before")
	var enhance_stat2_after:RichTextLabel = pnl_enhance.get_node("pnlc/hbox/stat_2/stat_afater")
	var enhance_stat3_before:Label = pnl_enhance.get_node("pnlc/hbox/stat_3/stat_before")
	var enhance_stat3_after:RichTextLabel = pnl_enhance.get_node("pnlc/hbox/stat_3/stat_afater")
	var enhance_btn_upgrade:Button = pnl_enhance.get_node("enhance_upgrade")
	var enhance_btn_exit:Button = pnl_enhance.get_node("enhance_upgrade2")
	# -------------------------- ENHANCE PANEL :END --------------------------------
	new_pnl.visible = true

	if confirm:
		pnl_ask_header.text = str(str_header)
		pnl_ask_desc.text = str(str_desc)
		pnl_ask_btn_yes.disabled = false
	
		if not pnl_ask_btn_yes.is_connected("pressed", btn_callable):
			pnl_ask_btn_yes.connect("pressed", btn_callable)
		var callback_yes = func():
			pnl_ask_btn_yes.disabled = true
			pnl_ask_btn_no.disabled = true
			new_pnl.queue_free() 
			# ------------------- PNL SHOW:START --------------------------
			var _data = AutoloadData.player_equipment[local_code]
			pnl_enhance.visible=true
			enhance_btn_upgrade.disabled=false
			enhance_btn_exit.disabled=true
			enhance_stat1_after.hide()
			enhance_stat2_after.hide()
			enhance_stat3_after.hide()
			enhance_img.texture = load(_data["icon_raw"])
			enhance_name.text = str(_data["name"])
			enhance_up_before.text = str("+",_data["enhance_main"]-1)
			enhance_up_after.text = str("+",_data["enhance_main"]," [color=crimson](MAX: ",_data["enhance_max"],")[/color]")
			enhance_stat1_before.text = stat_code_indic(_data["stat_1"]["stat_code"])
			enhance_stat2_before.text = stat_code_indic(_data["stat_2"]["stat_code"])
			enhance_stat3_before.text = stat_code_indic(_data["stat_3"]["stat_code"])
			enhance_stat1_after.text = str(stat_code(_data["stat_1"]["stat_code"], local_stat["stat_before_1"])," to ",stat_code(_data["stat_1"]["stat_code"], _data["stat_1"]["stat_main"]),"[color=gold] +(",stat_code(_data["stat_1"]["stat_code"], local_stat["rng_1"]),"[/color]) of MAX:[color=crimson] ",stat_code(_data["stat_1"]["stat_code"],local_stat["stat_max_1"]),"[/color]", local_stat["is_max_1"] )
			enhance_stat2_after.text = str(stat_code(_data["stat_2"]["stat_code"], local_stat["stat_before_2"])," to ",stat_code(_data["stat_2"]["stat_code"], _data["stat_2"]["stat_main"]),"[color=gold] +(",stat_code(_data["stat_2"]["stat_code"], local_stat["rng_2"]),"[/color]) of MAX:[color=crimson] ",stat_code(_data["stat_2"]["stat_code"],local_stat["stat_max_2"]),"[/color]", local_stat["is_max_2"] )
			enhance_stat3_after.text = str(stat_code(_data["stat_3"]["stat_code"], local_stat["stat_before_3"])," to ",stat_code(_data["stat_3"]["stat_code"], _data["stat_3"]["stat_main"]),"[color=gold] +(",stat_code(_data["stat_3"]["stat_code"], local_stat["rng_3"]),"[/color]) of MAX:[color=crimson] ",stat_code(_data["stat_3"]["stat_code"],local_stat["stat_max_3"]),"[/color]", local_stat["is_max_3"] )
		
		if pnl_ask_btn_yes.pressed.is_connected(callback_yes):
			pnl_ask_btn_yes.pressed.disconnect(callback_yes)
		pnl_ask_btn_yes.pressed.connect(callback_yes)
			# ------------------- PNL SHOW:END --------------------------
	else:
		pnl_ask_header.text = "WARNING !"
		pnl_ask_desc.text = "[color=crimson]Not enough money or gear item already max upgraded![/color]"
		pnl_ask_btn_yes.disabled = true
	
	dc_conn_btn(pnl_ask_btn_no)	
	var callback_ask_no = func():
		pnl_ask_btn_yes.disabled = true
		pnl_ask_btn_no.disabled = true
		new_pnl.queue_free()
	pnl_ask_btn_no.pressed.connect(callback_ask_no)
	
func check_upgradeable(enhance_price, player_money, min_enhance, max_enhance) -> bool:
	if player_money >= enhance_price and min_enhance < max_enhance: return true
	else: return false
func _set_string_color(txt, color_code):
	return str("[color=",color_code,"]",txt,"[/color]")
func inpect_eq_hide(_main_node): _main_node.visible = false

var local_stat = {
	"rng_1":0, "rng_2":0, "rng_3":0,
	"stat_before_1":0, "stat_before_2":0, "stat_before_3":0,
	"stat_max_1":0, "stat_max_2":0, "stat_max_3":0,
	"is_max_1":"", "is_max_2":"", "is_max_3":"",
}
func upgrade_gear(price, _node):
	AutoloadData.player_equipment[_node]["enhance_main"]+=1
	const rng_max = 10
	var rng_1 = randi_range(1, rng_max)
	var rng_2 = randi_range(1, rng_max)
	var rng_3 = randi_range(1, rng_max)
	local_stat["is_max_1"] = "[color=gold] MAX[/color]" if rng_1 == rng_max else ""
	local_stat["is_max_2"] = "[color=gold] MAX[/color]" if rng_2 == rng_max else ""
	local_stat["is_max_3"] = "[color=gold] MAX[/color]" if rng_3 == rng_max else ""
	var rng_stat_1 = get_pct(AutoloadData.player_equipment[_node]["stat_1"]["default_stat"], rng_1)
	var rng_stat_2 = get_pct(AutoloadData.player_equipment[_node]["stat_2"]["default_stat"], rng_2)
	var rng_stat_3 = get_pct(AutoloadData.player_equipment[_node]["stat_3"]["default_stat"], rng_3)
	var stat_max_1 = get_pct(AutoloadData.player_equipment[_node]["stat_1"]["default_stat"], rng_max)
	var stat_max_2 = get_pct(AutoloadData.player_equipment[_node]["stat_2"]["default_stat"], rng_max)
	var stat_max_3 = get_pct(AutoloadData.player_equipment[_node]["stat_3"]["default_stat"], rng_max)
	if rng_stat_1 <=0: rng_stat_1 = 1
	if rng_stat_2 <=0: rng_stat_2 = 1
	if rng_stat_3 <=0: rng_stat_3 = 1
	local_stat["rng_1"] = rng_stat_1
	local_stat["rng_2"] = rng_stat_2
	local_stat["rng_3"] = rng_stat_3
	local_stat["stat_max_1"] = stat_max_1
	local_stat["stat_max_2"] = stat_max_2
	local_stat["stat_max_3"] = stat_max_3
	local_stat["stat_before_1"] = AutoloadData.player_equipment[_node]["stat_1"]["stat_main"]
	local_stat["stat_before_2"] = AutoloadData.player_equipment[_node]["stat_2"]["stat_main"]
	local_stat["stat_before_3"] = AutoloadData.player_equipment[_node]["stat_3"]["stat_main"]
	AutoloadData.player_equipment[_node]["stat_1"]["stat_main"]+=rng_stat_1
	AutoloadData.player_equipment[_node]["stat_2"]["stat_main"]+=rng_stat_2
	AutoloadData.player_equipment[_node]["stat_3"]["stat_main"]+=rng_stat_3
	AutoloadData.player_money-=price
	AutoloadData.save_data()

# Fungsi untuk memutus koneksi 'pressed' (gunakan tab jika diperlukan)
func dc_conn_btn(_target: BaseButton) -> void:
	# Validasi target
	if not is_instance_valid(_target):
		push_error("Target button tidak valid")
		return
	
	if not _target is BaseButton:
		push_error("Target bukan Button")
		return
	
	const SIGNAL_NAME = "pressed"
	var disconnected_count = 0
	
	# Putuskan koneksi
	var connections = _target.get_signal_connection_list(SIGNAL_NAME)
	for connection in connections:
		var callable = connection["callable"]
		if _target.is_connected(SIGNAL_NAME, callable):
			_target.disconnect(SIGNAL_NAME, callable)
			disconnected_count += 1
	
	print("Diputus %d koneksi 'pressed'" % disconnected_count)
var local_code
func inspect_eq(_node_eq, eq_code, pnl_ask, _super_node, pnl_enhance, pnl_gear_to_del, gearset_parent):
	local_code = eq_code
	_node_eq.visible=true
	var _data = AutoloadData.player_equipment[eq_code]
	var inspect_pnl:Panel = _node_eq
	var img_main:TextureRect = inspect_pnl.get_node("hbox/pnl_wpn/vbox/img_main")
	var img_gs:TextureRect = inspect_pnl.get_node("hbox/pnl_wpn/vbox/img_gs")
	img_gs.texture = load( img_data.img_gs_main(_data["gs"], false) )
	img_main.texture = load(_data["icon_raw"])
	#var img_gs:TextureRect = inspect_pnl.get_node("hbox/pnl_wpn/vbox/img_gs")
	# ------------------------- BTN UPGRADE: START ------------------------------------
	var btn_upgrade:Button = inspect_pnl.get_node("hbox/pnl_wpn/vbox/btn_up")
	var btn_sell:Button = inspect_pnl.get_node("hbox/pnl_wpn/vbox/btn_sell")
	btn_sell.disabled = false
	btn_sell.text = "SELL"
	btn_upgrade.disabled = false
	btn_upgrade.text = "UPGRADE"
	var is_upgradeable = check_upgradeable(_data["enhance_price"], AutoloadData.player_money, _data["enhance_main"], _data["enhance_max"])

	# Create new callback
	var upgrade_callback = func():
		get_pnl_ask(
			is_upgradeable,
			pnl_ask,
			"Enhance Gear!",
			str("You need [color=gold]", filter_num_k(_data["enhance_price"])," GOLD", 
				"[/color] to enhance gear!\nRemaining GOLD: [color=gold]",filter_num_k(AutoloadData.player_money),"[/color]\n\n",
				"Upgrading gear will randomly increase stats by 1% to 10% of the gear's basic stats, more highly grade more expensive price to upgradeable.\n",
				"Your gold is sufficient in this transaction, do you want to continue to upgrade your gear?"),
			func():
				# All parameters for this inner function
				upgrade_gear.call(_data["enhance_price"], eq_code)
				pnl_ask.visible = false
				inspect_pnl.visible = false,
				_super_node,  # Parameter to get_pnl_ask, not to the inner function
				pnl_enhance
		)
		gearset_parent.get_node(str(eq_code,"/vbox/img/vbox/enhance")).text = str("+", AutoloadData.player_equipment[eq_code]["enhance_main"])
	var callaable_gear_sell = func():
		get_pnl_ask_sell(
			pnl_ask,
			_super_node,
			pnl_gear_to_del,
			btn_upgrade,
			btn_sell,
			gearset_parent)
	# -------------------- SIGNAL CLEANER:START --------------------------
	#var connections = btn_upgrade.get_signal_connection_list("pressed")
	#for connection in connections:
		#if connection["callable"].get_object() == self:
			#btn_upgrade.disconnect("pressed", connection["callable"])
	#var connections_2 = btn_sell.get_signal_connection_list("pressed")
	#for connection in connections_2:
		#if connection["callable"].get_object() == self:
			#btn_sell.disconnect("pressed", connection["callable"])
	# --------------------- SIGNAL CLEANER:END --------------------------
		
	# -----------------------------SIGNAL RESET:START-------------------------------------------
	#var upgrade_connections = btn_upgrade.get_signal_connection_list("pressed")
	#for connection in upgrade_connections:
		#btn_upgrade.disconnect("pressed", connection["callable"])
	## Hapus SEMUA koneksi "pressed" dari btn_sell (tanpa filter)
	#var sell_connections = btn_sell.get_signal_connection_list("pressed")
	#for connection in sell_connections:
		#btn_sell.disconnect("pressed", connection["callable"])
	# -------------------------------SIGNAL RESET:END-----------------------------------------
	dc_conn_btn(btn_upgrade)
	dc_conn_btn(btn_sell)
	btn_upgrade.pressed.connect(upgrade_callback)
	btn_sell.pressed.connect(callaable_gear_sell)
	
	print(btn_upgrade.get_signal_connection_list("pressed"))
	print(btn_sell.get_signal_connection_list("pressed"))
	# ------------------------- BTN UPGRADE: END ------------------------------------
	
	var name_eq:Label = inspect_pnl.get_node("hbox/pnl_desc/vbox/name_wpn")
	name_eq.text = _data["name"]
	var txt_eq:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_eq/desc")
	txt_eq.text = _data["type"]
	var txt_rank:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_rank/desc")
	txt_rank.text = _set_string_color(_data["grade_txt"], _data["grade_color"])
	var txt_enhance:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_enhance/desc")
	txt_enhance.text = "+" + filter_num_k(_data["enhance_main"]) + str(" [color=crimson]MAX(+",_data["enhance_max"],")")
	var txt_enhance_price:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_enhance_p/desc")
	txt_enhance_price.text = filter_num_k(_data["enhance_price"])
	var txt_eq_sell:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_eq_sell/desc")
	txt_eq_sell.text = str('[color="gold"]', filter_num_k(_data["sell"]))
	var txt_eq_gs:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_gs/desc")
	txt_eq_gs.text = str(_data["id_uniq"])
	var txt_eq_gs_stat:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_gs_stat/desc")
	txt_eq_gs_stat.text = _data["desc_uniq"]
	var txt_eq_main_stat:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_stat/desc")
	txt_eq_main_stat.text = str(
		stat_code_indic(_data["stat_1"]["stat_code"]) ,stat_code(_data["stat_1"]["stat_code"], _data["stat_1"]["stat_main"])," ",_set_string_color(_data["stat_1"]["stat_grade"],_data["stat_1"]["stat_color"]),"\n",
		stat_code_indic(_data["stat_2"]["stat_code"]) ,stat_code(_data["stat_2"]["stat_code"], _data["stat_2"]["stat_main"])," ",_set_string_color(_data["stat_2"]["stat_grade"],_data["stat_2"]["stat_color"]),"\n",
		stat_code_indic(_data["stat_3"]["stat_code"]) ,stat_code(_data["stat_3"]["stat_code"], _data["stat_3"]["stat_main"])," ",_set_string_color(_data["stat_3"]["stat_grade"],_data["stat_3"]["stat_color"]),"\n"
	)
	var txt_eq_main_desc:RichTextLabel = inspect_pnl.get_node("hbox/pnl_desc/vbox/hbox_desc/desc")
	txt_eq_main_desc.text = _data["desc"]
	var btn_cls:Button = inspect_pnl.get_node("hbox/pnl_desc/vbox/btn_cls")
	
	var callable_btn_cls = func():
		if AutoloadData.player_equipment.has(eq_code):
			gearset_parent.get_node(str(eq_code, "/vbox/img/vbox/enhance")).text = str("+", AutoloadData.player_equipment[eq_code]["enhance_main"])
		_node_eq.visible = false

	if not btn_cls.is_connected("pressed", callable_btn_cls):
		btn_cls.pressed.connect(callable_btn_cls)
	print(btn_cls.get_signal_connection_list("pressed"))

	if _data["is_equiped"] is bool:
		btn_sell.disabled = false
	else:
		btn_sell.disabled = true
		btn_sell.text = "EQUIPED"
	
# ------------------------------ EQUIPED GEAR:START --------------------------------------
func new_gear_dict(card_code):
	var gear_dict = {
		str(card_code):{
			"wpn":null, "armor":null, "gloves":null,
			"helm":null, "shoes":null, "trouser":null,
			"acc_1":null, "acc_2":null, "acc_3":null,
			"acc_4":null,
		}
	}
	AutoloadData.player_gear.merge(gear_dict)
	AutoloadData.save_data()

func preview_gearset(_node:Node, _code, is_reset:bool, is_reset_code):
	var get_img:TextureRect = _node.get_node("vbox/img")
	var _get_name:Label = _node.get_node("vbox/name")
	var get_header:VBoxContainer = _node.get_node("vbox/hbox/header")
	var get_header_stat_1:Label = get_header.get_node("stat_1")
	var get_header_stat_2:Label = get_header.get_node("stat_2")
	var get_header_stat_3:Label = get_header.get_node("stat_3")
	var get_desc:VBoxContainer = _node.get_node("vbox/hbox/desc")
	var get_enhance:Label = get_desc.get_node("enhance")
	var get_desc_stat_1:RichTextLabel = get_desc.get_node("stat_1")
	var get_desc_stat_2:RichTextLabel = get_desc.get_node("stat_2")
	var get_desc_stat_3:RichTextLabel = get_desc.get_node("stat_3")
	var get_gs_desc:Label = _node.get_node("vbox/scroll_c/gs_desc")
	var get_btn_act:Button = _node.get_node("vbox/btn_act")
	
	if is_reset:
		get_btn_act.disabled=true
		get_img.texture = img_data.img_default_gs(is_reset_code)
		_get_name.text = ""
		get_header_stat_1.text = "Stat 1"
		get_header_stat_2.text = "Stat 2"
		get_header_stat_3.text = "Stat 3"
		get_enhance.text = ""
		get_desc_stat_1.text = ""
		get_desc_stat_2.text = ""
		get_desc_stat_3.text = ""
		get_gs_desc.text = ""
		return
	get_btn_act.disabled=false
	var _data = AutoloadData.player_equipment[_code]
	
	# Grade Stat 1
	var grade_text_1 = _data["stat_1"]["stat_grade"]
	var grade_color_1 = _data["stat_1"]["stat_color"]
	var grade_stat_1 = str( "(",_set_string_color(grade_text_1.replace("GRADE: ", ""), grade_color_1),")" )

	# Grade Stat 2
	var grade_text_2 = _data["stat_2"]["stat_grade"]
	var grade_color_2 = _data["stat_2"]["stat_color"]
	var grade_stat_2 = str( "(",_set_string_color(grade_text_2.replace("GRADE: ", ""), grade_color_2),")" )

	# Grade Stat 3
	var grade_text_3 = _data["stat_3"]["stat_grade"]
	var grade_color_3 = _data["stat_3"]["stat_color"]
	var grade_stat_3 = str( "(",_set_string_color(grade_text_3.replace("GRADE: ", ""), grade_color_3),")" )
	
	get_img.texture = load(_data["icon_raw"])
	_get_name.text = _data["name"]
	get_header_stat_1.text = stat_code_indic_clear(_data["stat_1"]["stat_code"])
	get_header_stat_2.text = stat_code_indic_clear(_data["stat_2"]["stat_code"])
	get_header_stat_3.text = stat_code_indic_clear(_data["stat_3"]["stat_code"])
	get_enhance.text = str("+",_data["enhance_main"])
	get_desc_stat_1.text = str( stat_code(_data["stat_1"]["stat_code"], _data["stat_1"]["stat_main"]), grade_stat_1 )
	get_desc_stat_2.text = str( stat_code(_data["stat_2"]["stat_code"], _data["stat_2"]["stat_main"]), grade_stat_2 )
	get_desc_stat_3.text = str( stat_code(_data["stat_3"]["stat_code"], _data["stat_3"]["stat_main"]), grade_stat_3 )
	get_gs_desc.text = _data["desc_uniq"]
	
func _new_gearset(_node:PanelContainer, _parent:GridContainer, _code, pnl_preview_gs:Node, data_current_gearset:Dictionary):
	var new_eq:PanelContainer = _node.duplicate()
	var get_img:TextureRect = new_eq.get_node("vbox/img")
	var get_icon_eq:TextureRect = get_img.get_node("vbox/eq") 
	var get_icon_gs:TextureRect = get_img.get_node("vbox/gs") 
	var get_enhance:Label = get_img.get_node("vbox/enhance") 
	
	var get_btn:Button = get_img.get_node("btn")
	get_btn.connect("pressed", func():
		preview_gearset(pnl_preview_gs, _code, false, false)
		data_current_gearset["use"]=_code)
	
	var get_stat_1:TextureRect = new_eq.get_node("vbox/hbox/stat_1")
	var get_stat_2:TextureRect = new_eq.get_node("vbox/hbox/stat_2")
	var get_stat_3:TextureRect = new_eq.get_node("vbox/hbox/stat_3")
	
	var _data = AutoloadData.player_equipment[_code]
	get_img.texture = load(_data["icon_raw"])
	get_icon_eq.texture = img_data.img_eq_main(_data["id_gb"])
	get_icon_gs.texture = load(img_data.img_gs_main(_data["gs"], true))
	get_enhance.text = str("+",_data["enhance_main"])
	
	get_stat_1.texture = img_data.img_eq_stat(_data["stat_1"]["stat_code"])
	get_stat_2.texture = img_data.img_eq_stat(_data["stat_2"]["stat_code"])
	get_stat_3.texture = img_data.img_eq_stat(_data["stat_3"]["stat_code"])
	new_eq.show()
	new_eq.name = _data["id_node"]
	_parent.add_child(new_eq)
	
func set_onready_btn(
	_node_eq:Node,
	_node_acc:Node,
	pnl_eq_all:HBoxContainer,
	pnl_eq_set:HBoxContainer,
	data_gearset_enabled:Dictionary,
	gearset_parent:GridContainer,
	data_current_gearset:Dictionary,
	pnl_preview_gs:Dictionary): # PNL TRUE: PNL USE GS, FALSE: PNL USED
	# ----------------- EQ --------------------
	var child_size = _node_eq.get_child_count()
	var _data_dict = {0:"wpn", 1:"armor", 2:"gloves", 3:"helm", 4:"shoes", 5:"trouser", 6:"acc"}
	for i in range(child_size):
		var btn:Button = _node_eq.get_node(_data_dict[i])
		btn.connect("pressed", func():
			data_current_gearset["gs_code"]= _data_dict[i]
			preview_gearset(pnl_preview_gs[true], false, true, _data_dict[i])
			if AutoloadData.player_gear[data_current_gearset["card_code"]][_data_dict[i]] == null:
				preview_gearset(pnl_preview_gs[false], false, true, _data_dict[i])
			else:
				preview_gearset(pnl_preview_gs[false], AutoloadData.player_gear[data_current_gearset["card_code"]][_data_dict[i]] , false, false )
			for _child in gearset_parent.get_children(): _child.hide()
			var get_arr_enabled = data_gearset_enabled[_data_dict[i]]
			if get_arr_enabled != null and get_arr_enabled.is_empty() == false:
				for _gear in get_arr_enabled:
					var get_node_name = gearset_parent.get_child(_gear).name
					if AutoloadData.player_equipment[get_node_name]["is_equiped"] is bool:
						gearset_parent.get_child(_gear).show()
			pnl_eq_all.visible = !pnl_eq_all.visible
			pnl_eq_set.visible = !pnl_eq_set.visible )
	# ------------ ACC ---------------
	var acc_size = _node_acc.get_child_count()
	var _data_acc = {0:"acc_1", 1:"acc_2",2:"acc_3",3:"acc_4"}
	for i in range(acc_size):
		var btn:Button = _node_acc.get_node(_data_acc[i])
		btn.connect("pressed", func():
			data_current_gearset["gs_code"]= _data_acc[i]
			preview_gearset(pnl_preview_gs[true], false, true, "acc")
			if AutoloadData.player_gear[data_current_gearset["card_code"]][_data_acc[i]] == null:
				preview_gearset(pnl_preview_gs[false], false, true, _data_acc[i])
			else:
				preview_gearset(pnl_preview_gs[false], AutoloadData.player_gear[data_current_gearset["card_code"]][_data_acc[i]] , false, false )
			for _child in gearset_parent.get_children(): _child.hide()
			#var get_acc_enabled = data_gearset_enabled["acc"]
			if data_gearset_enabled.has("acc") and data_gearset_enabled["acc"] != null and data_gearset_enabled["acc"].is_empty() == false:
				for _acc in data_gearset_enabled["acc"]:
					var get_name_tohide = gearset_parent.get_child(_acc).name
					if AutoloadData.player_equipment[get_name_tohide]["is_equiped"] is bool:
						gearset_parent.get_child(_acc).show()
					else: gearset_parent.get_child(_acc).hide()
			pnl_eq_all.visible = !pnl_eq_all.visible
			pnl_eq_set.visible = !pnl_eq_set.visible )
		
func set_onready_gearset(_node, _parent, pnl_preview_gs_use, data_current_gearset):
	var total_size:int = 0
	if AutoloadData.player_equipment.size() == 0: return false
	else: total_size = AutoloadData.player_equipment.size()
	var _childern = _parent.get_children()
	for i in range(1, _childern.size()):
		var child_to_del = _childern[i]
		_parent.remove_child(child_to_del)
		child_to_del.queue_free()
	
	var _arr_wpn:Array = []
	var _arr_armor:Array = []
	var _arr_gloves:Array = []
	var _arr_helm:Array = []
	var _arr_shoes:Array = []
	var _arr_trouser:Array = []
	var _arr_acc:Array = []
	
	for i in range(total_size):
		var get_keys = AutoloadData.player_equipment.keys()[i]
		var _data = AutoloadData.player_equipment[get_keys]
		_new_gearset(_node, _parent, get_keys, pnl_preview_gs_use, data_current_gearset)
		match _data["id_gb"]:
			"eq_acc_ring", "eq_acc_earring", "eq_acc_amuelt", "eq_acc_belt":_arr_acc.append(i+1)
			"eq_armor": _arr_armor.append(i+1)
			"eq_gloves": _arr_gloves.append(i+1)
			"eq_helm": _arr_helm.append(i+1)
			"eq_shoes": _arr_shoes.append(i+1)
			"eq_trouser": _arr_trouser.append(i+1)
			"eq_wpn_melee", "eq_wpn_wiz": _arr_wpn.append(i+1)
	
	return {
		"wpn":_arr_wpn, "armor":_arr_armor, "gloves":_arr_gloves, "helm":_arr_helm,
		"shoes":_arr_shoes, "trouser":_arr_trouser, "acc":_arr_acc
	}

func enbaled_player_gear(_bool:bool, pnl_gear_eq, pnl_gear_all, _btn_switch, _panelContainer):
	var pnl_eq:HBoxContainer = pnl_gear_eq
	var pnl_all: HBoxContainer = pnl_gear_all
	var pnl_story:PanelContainer = _panelContainer
	var btn:Button = _btn_switch
	pnl_story.visible = true
	pnl_all.visible = false
	pnl_eq.visible = false
	btn.visible = _bool
	
func player_gear_equip(pnl_preview_gs:Dictionary, data_current_gearset:Dictionary, gearset_parent:Node):
	var player_eq = AutoloadData.player_equipment
	var player_gear = AutoloadData.player_gear
	var card_code = data_current_gearset["card_code"]
	var gs_code = data_current_gearset["gs_code"]
	var use = data_current_gearset["use"]
	player_eq[use]["is_equiped"]=card_code
	if player_gear[card_code][gs_code] != null:
		player_eq[player_gear[card_code][gs_code]]["is_equiped"]=false
		var _get_node_name = player_eq[player_gear[card_code][gs_code]]["id_node"]
		gearset_parent.get_node(_get_node_name).show()
	gearset_parent.get_node(use).hide()
	player_gear[card_code][gs_code] = use
	AutoloadData.save_data()
	preview_gearset(pnl_preview_gs[true], false, true, gs_code)
	preview_gearset(pnl_preview_gs[false], use, false, false)
	
func player_gear_unequip(pnl_preview_gs:Dictionary, data_current_gearset:Dictionary, gearset_parent:Node):
	var player_eq = AutoloadData.player_equipment
	var player_gear = AutoloadData.player_gear
	var card_code = data_current_gearset["card_code"]
	var gs_code = data_current_gearset["gs_code"]
	#var use = data_current_gearset["use"]
	player_eq[player_gear[card_code][gs_code]]["is_equiped"]=false
	var _get_node_name = player_eq[player_gear[card_code][gs_code]]["id_node"]
	gearset_parent.get_node(_get_node_name).show()
	player_gear[card_code][gs_code]=null
	AutoloadData.save_data()
	preview_gearset(pnl_preview_gs[false], false, true, gs_code)
	
func load_gear_img(data_current_gearset:Dictionary, gearset_parent_btn_eq:GridContainer, gearset_parent_btn_acc:GridContainer):
	var _data_eq = {0:"wpn", 1:"armor", 2:"gloves", 3:"helm", 4:"shoes", 5:"trouser", 6:"acc"}
	var _data_acc = {0:"acc_1", 1:"acc_2",2:"acc_3",3:"acc_4"}
	var eq_size = gearset_parent_btn_eq.get_child_count()
	var acc_size = gearset_parent_btn_acc.get_child_count()
	var _data = AutoloadData.player_gear[data_current_gearset["card_code"]]
	for i in range(eq_size):
		
		var btn:Button = gearset_parent_btn_eq.get_node(_data_eq[i])
		var get_vbox:VBoxContainer = btn.get_node("vbox")
		var get_eq:TextureRect = get_vbox.get_node("eq")
		var get_gs:TextureRect = get_vbox.get_node("gs")
		var get_enhance:Label = get_vbox.get_node("enhance")
		if _data[_data_eq[i]] == null:
			btn.icon = img_data.img_default_eq(_data_eq[i])
			get_vbox.hide()
		else:
			var _data_equipment = AutoloadData.player_equipment[_data[_data_eq[i]]]
			btn.icon = load(AutoloadData.player_equipment[_data[_data_eq[i]]]["icon_raw"])
			get_vbox.show()
			get_eq.texture = img_data.img_eq_main(_data_equipment["id_gb"])
			get_gs.texture = load(img_data.img_gs_main(_data_equipment["gs"], true))
			get_enhance.text = str("+",_data_equipment["enhance_main"])
			
	for i in range(acc_size):
		var btn:Button = gearset_parent_btn_acc.get_node(_data_acc[i])
		var get_vbox:VBoxContainer = btn.get_node("vbox")
		var get_eq:TextureRect = get_vbox.get_node("eq")
		var get_gs:TextureRect = get_vbox.get_node("gs")
		var get_enhance:Label = get_vbox.get_node("enhance")
		if _data[_data_acc[i]] == null:
			btn.icon = img_data.img_default_eq(_data_acc[i])
			get_vbox.hide()
		else:
			var _data_equipment = AutoloadData.player_equipment[_data[_data_acc[i]]]
			btn.icon = load(AutoloadData.player_equipment[_data[_data_acc[i]]]["icon_raw"])
			get_vbox.show()
			get_eq.texture = img_data.img_eq_main(_data_equipment["id_gb"])
			get_gs.texture = load(img_data.img_gs_main(_data_equipment["gs"], true))
			get_enhance.text = str("+",_data_equipment["enhance_main"])

func gearset_count(arr: Array) -> Dictionary:
	var result: Dictionary = {}
	for item in arr:
		if item == null: continue
		if result.has(item): result[item] += 1
		else: result[item] = 1
	return result #{'apel': 2, 'jeruk': 2, 'nanas': 1}
		
func gearset_aply(card_code)->Dictionary:
	var get_eq_code:Array = AutoloadData.player_gear[card_code].values()
	var arr_gs:Array = [] # GS ARR: acc_gs_1, acc_gs_2, eq_gs_4, eq_gssc_6
	for eq in get_eq_code:
		if eq == null: continue
		else:
			var _get_gs_code = AutoloadData.player_equipment[eq]["gs"]
			arr_gs.append(_get_gs_code)
	var dict_gs:Dictionary = gearset_count(arr_gs)
	var gs_code:Dictionary = {}
	var gs_main: Dictionary = {
		'atk_flat': 0, 'atk_pct': 0, 'def_flat': 0, 'def_pct': 0, 'hp_flat': 0,
		'hp_pct': 0,'turn_flat': 0, 'turn_pct': 0, 'crit_rate': 0, 'crit_dmg': 0,
		'spd_flat': 0, 'eva_flat': 0, 'crit_def': 0, 'dmg_dragon':0, 'dmg_all_dg':0, 'def_pen':0}
	for key_gs in dict_gs.keys():
		var gs_code_index = gs_code.size()+1
		match key_gs:
			# ------------- ACC --------------
			"acc_gs_1","none": gs_code[gs_code_index]=key_gs
			"acc_gs_2":
				if dict_gs[key_gs] == 4:
					gs_main["crit_rate"]+=20
					gs_code[gs_code_index]=key_gs
			"acc_gs_3": if dict_gs[key_gs] == 4:
				gs_main["crit_def"]+=35
				gs_code[gs_code_index]=key_gs
			"acc_gs_4": if dict_gs[key_gs] == 4:
				gs_main["dmg_dragon"]+=500
				gs_code[gs_code_index]=key_gs
			"acc_gs_5":
				for i in range(4):
					if dict_gs[key_gs] == i:
						gs_main["crit_def"] += 15*i
						gs_code[gs_code_index]=key_gs
			"acc_gs_6": if dict_gs[key_gs] == 4:
				gs_main["dmg_all_dg"]+=1000
				gs_code[gs_code_index]=key_gs
			# ------------- EQ BASIC ---------------------
			"eq_gs_0": if dict_gs[key_gs] == 3:
				gs_main["atk_pct"]+=25
				gs_main["atk_flat"]+=10000
				gs_code[gs_code_index]=key_gs
			"eq_gs_1": if dict_gs[key_gs] == 3:
				gs_main["def_pct"]+=25
				gs_main["def_flat"]+=2500
				gs_code[gs_code_index]=key_gs
			"eq_gs_2": if dict_gs[key_gs] == 3:
				gs_main["hp_pct"]+=25
				gs_main["hp_flat"]+=25000
				gs_code[gs_code_index]=key_gs
			"eq_gs_3": if dict_gs[key_gs] == 3:
				gs_main["turn_pct"]+=25
				gs_code[gs_code_index]=key_gs
			"eq_gs_4": if dict_gs[key_gs] == 3:
				gs_main["spd_flat"]+=250
				gs_code[gs_code_index]=key_gs
			"eq_gs_5": if dict_gs[key_gs] == 3:
				gs_main["eva_flat"]+=150
				gs_code[gs_code_index]=key_gs
			"eq_gs_6": if dict_gs[key_gs] == 3:
				gs_main["def_pen"]+=25
				gs_code[gs_code_index]=key_gs
			"eq_gs_7": if dict_gs[key_gs] == 3:
				gs_main["crit_def"]+=25
				gs_code[gs_code_index]=key_gs
			# ------------- EQ SPECIAL -------------------
			"eq_gssc_0":
				if dict_gs[key_gs] == 6:
					gs_main["crit_def"]+=35
					gs_main["def_pct"]+=50
					gs_main["def_flat"]+=5000
					gs_code[gs_code_index]=key_gs
				elif dict_gs[key_gs] >= 3:
					gs_main["crit_def"]+=20
					gs_main["def_pct"]+=35
					gs_main["def_flat"]+=3000
					gs_code[gs_code_index]=key_gs
			"eq_gssc_1":
				if dict_gs[key_gs] == 6:
					gs_main["crit_rate"]+=25
					gs_main["atk_flat"]+=40000
					gs_main["atk_pct"]+=50
					gs_code[gs_code_index]=key_gs
				elif dict_gs[key_gs] >= 3:
					gs_main["crit_rate"]+=35
					gs_main["atk_flat"]+=20000
					gs_main["atk_pct"]+=35
					gs_code[gs_code_index]=key_gs
			"eq_gssc_2":
				if dict_gs[key_gs] == 6:
					gs_main["eva_flat"]+=1000
					gs_main["turn_pct"]+=40
					gs_code[gs_code_index]=key_gs
				elif dict_gs[key_gs] >= 3:
					gs_main["eva_flat"]+=500
					gs_main["turn_pct"]+=20
					gs_code[gs_code_index]=key_gs
			"eq_gssc_3":
				if dict_gs[key_gs] == 6:
					gs_main["hp_flat"]+=100000
					gs_main["hp_pct"]+=50
					gs_main["spd_flat"]+=1500
					gs_code[gs_code_index]=key_gs
				elif dict_gs[key_gs] >= 3:
					gs_main["hp_flat"]+=50000
					gs_main["hp_pct"]+=35
					gs_main["spd_flat"]+=1000
					gs_code[gs_code_index]=key_gs
			"eq_gssc_4":
				if dict_gs[key_gs] == 6:
					gs_main["atk_pct"]+=200
					gs_main["hp_pct"]+=200
					gs_code[gs_code_index]=key_gs
			"eq_gssc_5":
				if dict_gs[key_gs] == 6:
					gs_main["atk_pct"]+=200
					gs_main["hp_pct"]+=200
					gs_code[gs_code_index]=key_gs
			"eq_gssc_6":
				if dict_gs[key_gs] == 6:
					gs_main["atk_pct"]+=400
					gs_main["hp_pct"]+=400
					gs_code[gs_code_index]=key_gs
	return {
		"gs_main":gs_main,
		"gs_code":gs_code # RETURN: acc_gs_3, acc_gs_4, eq_gs_1, eq_gssc_4 etc.
	}
# ------------------------------ EQUIPED GEAR:END --------------------------------------

# ------------------------------- PROGRESS ANIMATION:START -----------------------------------
func get_gearset_desc(gs_code)->Dictionary:
	var _data_desc = Load_reward.new()
	var get_desc:String = ""
	var get_icon = img_data.img_gs_main(gs_code, false)
	match gs_code:
		"acc_gs_1":get_desc = _data_desc._eq_gearset_acc(1)["desc"]
		"acc_gs_2":get_desc = _data_desc._eq_gearset_acc(2)["desc"]
		"acc_gs_3":get_desc = _data_desc._eq_gearset_acc(3)["desc"]
		"acc_gs_4":get_desc = _data_desc._eq_gearset_acc(4)["desc"]
		"acc_gs_5":get_desc = _data_desc._eq_gearset_acc(5)["desc"]
		"acc_gs_6":get_desc = _data_desc._eq_gearset_acc(6)["desc"]
		
		"eq_gs_0":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET1_FANGCLAW)["desc"]
		"eq_gs_1":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET2_STONEWALL)["desc"]
		"eq_gs_2":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET3_HEARTROOT)["desc"]
		"eq_gs_3":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET4_SWIFTWIND)["desc"]
		"eq_gs_4":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET5_STORMLASH)["desc"]
		"eq_gs_5":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET6_SHADOWSTEP)["desc"]
		"eq_gs_6":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET7_PIERCER)["desc"]
		"eq_gs_7":get_desc = _data_desc._eq_gearset_desc(Load_reward.ENUM_GEARSET.SET8_IRONVEIL)["desc"]
		
		"eq_gssc_0":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET1_TEMPLAR_VOW)["desc"]
		"eq_gssc_1":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET2_CRIMSON_ABYSS)["desc"]
		"eq_gssc_2":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET3_NIGHTSHADE)["desc"]
		"eq_gssc_3":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET4_RAGEHOWL)["desc"]
		"eq_gssc_4":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET5_DARK_OVERLOARD)["desc"]
		"eq_gssc_5":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET6_CELESTIAL_EMPEROR)["desc"]
		"eq_gssc_6":get_desc = _data_desc._eq_gearset_sc_desc(Load_reward.ENUM_GEARSET_SC.SET7_GAIA)["desc"]
		
	return{ "icon":get_icon, "desc":get_desc }	

func eq_prog_player(
	dict_prog: Dictionary,
	dict_over:Dictionary,
	dict_final: Dictionary,
	dict_text: Dictionary,
	_card_inspect_stat: Dictionary,
	eq_prog:Callable,
	card_code:String,
	gearset_indic:Dictionary):
	
	var data_gear:Dictionary = AutoloadData.player_gear[card_code]
	var data_eq:Dictionary = AutoloadData.player_equipment
	var new_stat:Dictionary = _card_inspect_stat.duplicate()
	var new_stat_temp:Dictionary = new_stat.duplicate()
	var stat_sc:Dictionary = {"dmg_dragon":0, "dmg_all_dg":0, "def_pen":0}
	
	for gear in data_gear.values():
		if gear is String:
			var stat:Dictionary = {
				"stat_1":{
					"main":data_eq[gear]["stat_1"]["stat_main"],
					"code":data_eq[gear]["stat_1"]["stat_code"] },
				"stat_2":{
					"main":data_eq[gear]["stat_2"]["stat_main"],
					"code":data_eq[gear]["stat_2"]["stat_code"] },
				"stat_3":{
					"main":data_eq[gear]["stat_3"]["stat_main"],
					"code":data_eq[gear]["stat_3"]["stat_code"] }, }
			
			for set_data in stat:
				match stat[set_data]["code"]:
					"atk_flat": new_stat_temp[0] += stat[set_data]["main"]
					"atk_pct": new_stat_temp[0] += get_pct(new_stat[0], stat[set_data]["main"])
					"def_flat": new_stat_temp[1] += stat[set_data]["main"]
					"def_pct": new_stat_temp[1] += get_pct(new_stat[1], stat[set_data]["main"])
					"hp_flat": new_stat_temp[2] += stat[set_data]["main"]
					"hp_pct": new_stat_temp[2] += get_pct(new_stat[2], stat[set_data]["main"])
					"turn_flat": new_stat_temp[3] += stat[set_data]["main"]
					"turn_pct": new_stat_temp[3] += get_pct(new_stat[3], stat[set_data]["main"])
					"crit_rate": new_stat_temp[6] += stat[set_data]["main"]
					"crit_dmg": new_stat_temp[7] += stat[set_data]["main"]
					"spd_flat": new_stat_temp[9] += stat[set_data]["main"]
					"eva_flat": new_stat_temp[5] += stat[set_data]["main"]
					"crit_def": new_stat_temp[8] += stat[set_data]["main"]
	
	var stat_basic_rm = _card_inspect_stat.duplicate()
	var gearset_main:Dictionary = gearset_aply(card_code)
	for set_data in gearset_main["gs_main"].keys():
		match set_data:
			"atk_flat": new_stat_temp[0] += gearset_main["gs_main"][set_data]
			"atk_pct": new_stat_temp[0] += get_pct(new_stat[0], gearset_main["gs_main"][set_data])
			"def_flat": new_stat_temp[1] += gearset_main["gs_main"][set_data]
			"def_pct": new_stat_temp[1] += get_pct(new_stat[1], gearset_main["gs_main"][set_data])
			"hp_flat": new_stat_temp[2] += gearset_main["gs_main"][set_data]
			"hp_pct": new_stat_temp[2] += get_pct(new_stat[2], gearset_main["gs_main"][set_data])
			"turn_flat": new_stat_temp[3] += gearset_main["gs_main"][set_data]
			"turn_pct": new_stat_temp[3] += get_pct(new_stat[3], gearset_main["gs_main"][set_data])
			"crit_rate": new_stat_temp[6] += gearset_main["gs_main"][set_data]
			"crit_dmg": new_stat_temp[7] += gearset_main["gs_main"][set_data]
			"spd_flat": new_stat_temp[9] += gearset_main["gs_main"][set_data]
			"eva_flat": new_stat_temp[5] += gearset_main["gs_main"][set_data]
			"crit_def": new_stat_temp[8] += gearset_main["gs_main"][set_data]
			"dmg_dragon": stat_sc["dmg_dragon"] += gearset_main["gs_main"][set_data]
			"dmg_all_dg": stat_sc["dmg_all_dg"] += gearset_main["gs_main"][set_data]
			"def_pen": stat_sc["def_pen"] += gearset_main["gs_main"][set_data]
	
	var stat_basic_mn = new_stat_temp.duplicate()
	for key in stat_basic_mn.keys():
		if stat_basic_rm.has(key):
			var result = stat_basic_mn[key] - stat_basic_rm[key]
			stat_basic_mn[key] = clamp(result, 0, result)
	print(stat_basic_mn)
	
	stat_basic_mn.merge(stat_sc)
	AutoloadData.player_equiped[card_code]=stat_basic_mn
	AutoloadData.save_data()
	# -------------------------- SET ICON AND DESC:START ------------------------
	if gearset_main["gs_code"].is_empty():
		var _desc_eq_:Label = gearset_indic["eq_desc"]
		_desc_eq_.text = ""
		var _desc_acc_:Label = gearset_indic["acc_desc"]
		_desc_acc_.text = ""
		var _img_eq_:TextureRect = gearset_indic["eq_main"]
		_img_eq_.texture = load( img_data.img_gs_main("none", false) )
		var _img_acc_:TextureRect = gearset_indic["acc_main"]
		_img_acc_.texture = load( img_data.img_gs_main("none", false) )
	
	var _get_desc_eq:Label = gearset_indic["eq_desc"]
	var _get_img_eq:TextureRect = gearset_indic["eq_main"]
	var _get_desc_acc:Label = gearset_indic["acc_desc"]
	var _get_img_acc:TextureRect = gearset_indic["acc_main"]
	
	var arr_gs_acc:Array=[]
	var arr_gs_eq:Array=[]
	for gs_sort:String in gearset_main["gs_code"].values():
		var final_sort = gs_sort.substr(0,3)
		if final_sort == "acc": arr_gs_acc.append(gs_sort)
		else: arr_gs_eq.append(gs_sort)
	# ---------------- ACC --------------------
	if arr_gs_acc.is_empty():
		_get_desc_acc.text = ""
		_get_img_acc.texture = load( img_data.img_gs_main("none", false) )
	else:
		_get_desc_acc.text = get_gearset_desc(arr_gs_acc[0])["desc"]
		_get_img_acc.texture = load( get_gearset_desc(arr_gs_acc[0])["icon"] )
	# ---------------- EQ --------------------
	if arr_gs_eq.is_empty():
		_get_desc_eq.text = ""
		_get_img_eq.texture = load( img_data.img_gs_main("none", false) )
	else:
		if arr_gs_eq.size() >= 2:
			var rng_img = randi_range(0, arr_gs_eq.size())
			_get_desc_eq.text = str( get_gearset_desc(arr_gs_eq[0])["desc"], "\n", get_gearset_desc(arr_gs_eq[1])["desc"] )
			_get_img_eq.texture = load( get_gearset_desc(arr_gs_eq[rng_img])["icon"] )
		else:
			_get_desc_eq.text = get_gearset_desc(arr_gs_eq[0])["desc"]
			_get_img_eq.texture = load( get_gearset_desc(arr_gs_eq[0])["icon"] )
	
	var new_filter:Dictionary = {
		0: set_pct(new_stat_temp[0], 50000), # atk
		1: set_pct(new_stat_temp[1], 3000), # def
		2: set_pct(new_stat_temp[2], 300000), # hp
		3: set_pct(new_stat_temp[3], 200), # turn
		4: set_pct(new_stat_temp[4], 25), # cst
		5: set_pct(new_stat_temp[5], 500), # eva
		6: set_pct(new_stat_temp[6], 100), # crit
		7: set_pct(new_stat_temp[7], 1000), # crit dmg
		8: set_pct(new_stat_temp[8], 100), # crit def
		9: set_pct(new_stat_temp[9], 500) } # spd atk
		
	eq_prog.call(
		dict_prog, 
		dict_over, 
		dict_final,
		dict_text,
		new_filter,
		new_stat_temp
	)
	
	
# ------------------------------- PROGRESS ANIMATION:END -----------------------------------

# ---------------------------------- DEFAULT STAT -----------------------------------
