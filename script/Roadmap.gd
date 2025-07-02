extends Node2D
@onready var pnl_main = $pnl_top_quest
@onready var pnl_list = $pnl_list_quest
@onready var node_parent_quest = $pnl_list_quest/ScrollContainer/quest_parent	

func _ready() -> void:
	pnl_main.show()
	pnl_list.hide()
	btn_to_lobby.show()
	SfxManager.lw_onready_bgm(SfxManager.ENUM_BGM.ROADMAP)
	onready_btn_claim()
	hide_all_btn_quest()
	onready_btn_main()
	update_prog_main()

@onready var btn_to_lobby = $btn_lobby
@onready var node_parent_btn_main = $pnl_top_quest
var data_show_btn_quest = { 0:[0,1,2], 1:[3,4], 2:[5,6,7,8], 3:[9,10,11,12] }

func tween_customsize(target: Control, grow: bool) -> void:
	# Hapus tween lama jika ada
	if target.has_meta("custom_tween"):
		var old_tween: Tween = target.get_meta("custom_tween")
		if is_instance_valid(old_tween):
			old_tween.kill()

	# Buat tween baru
	var tween := create_tween()
	target.set_meta("custom_tween", tween)

	var to_size := Vector2(400, 400) if grow else Vector2(300, 300)
	tween.tween_property(target, "custom_minimum_size", to_size, 0.2)
func select_quest_toshow(code):
	pnl_main.hide()
	btn_to_lobby.hide()
	pnl_list.show()
	var get_arr = data_show_btn_quest[code]
	for i in node_parent_quest.get_child_count():
		node_parent_quest.get_child(i).visible = i in get_arr
func onready_btn_main():
	btn_cls_rwd.connect("pressed", func():
		pnl_rwd_main.hide())
	for i in range(13):
		update_quest_desc(i)
		var btn:Button = node_parent_quest.get_child(i).get_node("vobx/hbox/btn")
		btn.disabled = !get_rules(i)
	for child in node_parent_btn_main.get_children():
		var pnl:Panel = child.get_node("bg")
		pnl.connect("mouse_entered", tween_customsize.bind(pnl, true) )
		pnl.connect("mouse_exited", tween_customsize.bind(pnl, false) )
	btn_to_lobby.connect("pressed", func():
		AutoloadData.scene_data = "res://scenes/Lobby.tscn"
		get_tree().change_scene_to_file("res://scenes/new_loading_screen.tscn") )
	$pnl_list_quest/btn_cls.connect("pressed", func():
		pnl_main.show()
		pnl_list.hide()
		btn_to_lobby.show()
		update_prog_main())
	for i in node_parent_btn_main.get_child_count():
		var btn:Button=node_parent_btn_main.get_child(i).get_node("btn")
		btn.connect("pressed", select_quest_toshow.bind(i) )
func total_story_stage():
	var count:int = 0
	for i in AutoloadData.story_stage.size():
		count += AutoloadData.story_stage[i]["total"]
	return count-1
func total_star_stage():
	var total:int = 0
	var stage:Dictionary = AutoloadData.stage_star.duplicate()
	for level in stage.values():
		for star in level:
			total += star
	return total
# --------------------------------------
# ROADMAP MANAGER
# --------------------------------------
func set_desc(value):
	var desc = {
		0: {
			"header":"Achievement: Level Up! Powered up to level %d" % AutoloadData.roadmap_data[value]["quest"],
			"desc": "Current: %d" % AutoloadData.player_level },
		1: {
			"header":"Achievement: Adventure! clear stage %d" % AutoloadData.roadmap_data[value]["quest"],
			"desc": "Current: %d" % total_story_stage() },
		2: {
			"header":"Achievement: Perfect Battle! Collect a total of %d stars from battles." % AutoloadData.roadmap_data[value]["quest"],
			"desc": "Current: %d" % total_star_stage() },
		3: {
			"header":"Achievement: I'm Rich! Collect total %s gold on battle." % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_gold) },
		4: {
			"header":"Achievement: Miner! Collect total %s Mana stone on battle" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_mana) },
		5: {
			"header":"Achievement: War cry! Finished the battle %s times" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_battle) },
		6: {
			"header":"Achievement: Monster hunter! Make %s total damage to enemy!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_damages) },
		7: {
			"header":"Achievement: Front knight! Take heal from ally by %s total!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_heal_taked) },
		8: {
			"header":"Achievement: Angel! Gift ally heal total %s total!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_heal_gift) },
		9: {
			"header":"Achievement: Card Collector! Collect %s card!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.player_cardCollection.size()) },
		10: {
			"header":"Achievement: Card Collector! Collect %s card!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_eq) },
		11: {
			"header":"Achievement: God of Djudie! Spin %s Times!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_spin) },
		12: {
			"header":"Achievement: Enhance Master! upgrade gear %s times!" % AutoloadData.filter_num_k(AutoloadData.roadmap_data[value]["quest"]),
			"desc": "Current: %s" % AutoloadData.filter_num_k(AutoloadData.roadmap_total_enhance) },
	}
	return { "header":desc[value]["header"],"desc":desc[value]["desc"]}
func get_rules(code):
	var rules = {
		0: AutoloadData.player_level >= AutoloadData.roadmap_data[0]["quest"],
		1: total_story_stage() >= AutoloadData.roadmap_data[1]["quest"],
		2: total_star_stage() >= AutoloadData.roadmap_data[2]["quest"],
		3: AutoloadData.roadmap_gold >= AutoloadData.roadmap_data[3]["quest"],
		4: AutoloadData.roadmap_mana >= AutoloadData.roadmap_data[4]["quest"],
		5: AutoloadData.roadmap_total_battle >= AutoloadData.roadmap_data[5]["quest"],
		6: AutoloadData.roadmap_total_damages >= AutoloadData.roadmap_data[6]["quest"],
		7: AutoloadData.roadmap_total_heal_taked >= AutoloadData.roadmap_data[7]["quest"],
		8: AutoloadData.roadmap_total_heal_gift >= AutoloadData.roadmap_data[8]["quest"],
		9: AutoloadData.player_cardCollection.size() >= AutoloadData.roadmap_data[9]["quest"],
		10: AutoloadData.roadmap_total_eq >= AutoloadData.roadmap_data[10]["quest"],
		11: AutoloadData.roadmap_total_spin >= AutoloadData.roadmap_data[11]["quest"],
		12: AutoloadData.roadmap_total_enhance >= AutoloadData.roadmap_data[12]["quest"],
	}
	var liimit_code = clamp(code, 0, 12)
	return rules[liimit_code]
# -------------------------------------------------------------------
func hide_all_btn_quest():
	for child in node_parent_quest.get_children():
		child.hide()
func disabled_one_btn_quest(code):
	var limit_code = clamp(code, 0, 12)
	var btn:Button = node_parent_quest.get_child(limit_code).get_node("vobx/hbox/btn")
	btn.disabled = !get_rules(limit_code)
func update_quest_desc(code):
	var header:Label = node_parent_quest.get_child(code).get_node("vobx/quest_desc")
	var desc:Label = node_parent_quest.get_child(code).get_node("vobx/hbox/vbox/target_progress")
	header.text = set_desc(code)["header"]
	desc.text = set_desc(code)["desc"]
func claim_reward(code):
	if get_rules(code):
		SfxManager.play_money()
		
		var get_rwd = AutoloadData.roadmap_data[code]["rwd"]
		var get_count = AutoloadData.roadmap_data[code]["count"]
		if get_rwd == AutoloadData.ENUM_ROADMAP_REWARD.GOLD:
			pnl_rwd(AutoloadData.ENUM_ROADMAP_REWARD.GOLD, get_count)
			AutoloadData.player_money+=AutoloadData.roadmap_data[code]["count"]
		elif get_rwd == AutoloadData.ENUM_ROADMAP_REWARD.MANA:
			pnl_rwd(AutoloadData.ENUM_ROADMAP_REWARD.MANA, get_count)
			AutoloadData.player_exp+=AutoloadData.roadmap_data[code]["count"]
		elif get_rwd == AutoloadData.ENUM_ROADMAP_REWARD.TICKET:
			pnl_rwd(AutoloadData.ENUM_ROADMAP_REWARD.TICKET, get_count)
			AutoloadData.player_super_ticket+=AutoloadData.roadmap_data[code]["count"]
		elif get_rwd == AutoloadData.ENUM_ROADMAP_REWARD.SPIN:
			pnl_rwd(AutoloadData.ENUM_ROADMAP_REWARD.SPIN, get_count)
			AutoloadData.player_spin_coin+=AutoloadData.roadmap_data[code]["count"]
		
		AutoloadData.roadmap_data[code]["quest"]+=AutoloadData.roadmap_data[code]["increment"]
		AutoloadData.save_data()
		disabled_one_btn_quest(code)
	else:
		disabled_one_btn_quest(code)
		SfxManager.play_system_fail()
	update_quest_desc(code)
func onready_btn_claim():
	for i in range(13):
		var btn:Button = node_parent_quest.get_child(i).get_node("vobx/hbox/btn")
		btn.connect("pressed", claim_reward.bind(i) )
# ---------------------------------------------
# PROGRESS QUEST
# ---------------------------------------------
@onready var pnl_rwd_main:Panel = $bg
@onready var btn_cls_rwd:Button = $bg/btn_cls_rwd
@onready var data_rwd = Load_reward.new()
func pnl_rwd(indic, value):
	pnl_rwd_main.show()
	var header:Label = btn_cls_rwd.get_node("pnlc/vbox/header")
	var img:TextureRect = btn_cls_rwd.get_node("pnlc/vbox/hbox/img")
	var desc:Label = btn_cls_rwd.get_node("pnlc/vbox/hbox/desc")
	var count:Label = btn_cls_rwd.get_node("pnlc/vbox/count")
	
	var set_header
	var set_img
	var set_desc_
	var set_count
	match indic:
		AutoloadData.ENUM_ROADMAP_REWARD.GOLD:
			set_header=data_rwd.currency[data_rwd.ENUM_REWARD.MONEY]["name"]
			set_img=data_rwd.currency[data_rwd.ENUM_REWARD.MONEY]["icon"]
			set_desc_=data_rwd.currency[data_rwd.ENUM_REWARD.MONEY]["desc"]
			set_count=AutoloadData.filter_num_k(value)
		AutoloadData.ENUM_ROADMAP_REWARD.MANA:
			set_header=data_rwd.currency[data_rwd.ENUM_REWARD.EXP]["name"]
			set_img=data_rwd.currency[data_rwd.ENUM_REWARD.EXP]["icon"]
			set_desc_=data_rwd.currency[data_rwd.ENUM_REWARD.EXP]["desc"]
			set_count=AutoloadData.filter_num_k(value)
		AutoloadData.ENUM_ROADMAP_REWARD.TICKET:
			set_header=data_rwd.currency[data_rwd.ENUM_REWARD.TICKET]["name"]
			set_img=data_rwd.currency[data_rwd.ENUM_REWARD.TICKET]["icon"]
			set_desc_=data_rwd.currency[data_rwd.ENUM_REWARD.TICKET]["desc"]
			set_count=AutoloadData.filter_num_k(value)
		AutoloadData.ENUM_ROADMAP_REWARD.SPIN:
			set_header=data_rwd.currency[data_rwd.ENUM_REWARD.SPIN]["name"]
			set_img=data_rwd.currency[data_rwd.ENUM_REWARD.SPIN]["icon"]
			set_desc_=data_rwd.currency[data_rwd.ENUM_REWARD.SPIN]["desc"]
			set_count=AutoloadData.filter_num_k(value)
	header.text = set_header
	img.texture = set_img
	desc.text = set_desc_
	count.text = str("Recived: +",set_count)	
func update_prog_main():
	var total_mainquest:Array = [data_show_btn_quest[0].size(), data_show_btn_quest[1].size(), data_show_btn_quest[2].size(), data_show_btn_quest[3].size()]
	var total_count:Array = [0, 0, 0, 0]
	for i in total_count.size():
		var arr_loop:Array = data_show_btn_quest[i]
		for ii in arr_loop: if get_rules(ii)==true: total_count[i]+=1
		var prog:TextureProgressBar = node_parent_btn_main.get_child(i).get_node("bg/prog_main")
		var desc:Label = node_parent_btn_main.get_child(i).get_node("bg/prog_main/main")		
		prog.value = AutoloadData.set_pct(total_mainquest[i], total_count[i])
		desc.text = str("Claim\n",total_count[i],"/",total_mainquest[i])
		
		
		
		
		
		
		
		
		
		
