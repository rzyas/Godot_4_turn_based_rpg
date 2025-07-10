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
	onready_fragments_set()
	onready_soul()

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
		SceneManager.move_to_scene(SceneManager.ENUM_SCENE.LOBBY) )
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
# ----------------------------------------------
# UNLOCKED HERO
# ----------------------------------------------
@onready var parent_prosed_unlocked = $hero_unlocked/ScrollContainer/hbox
@onready var prosed_unlocked:PanelContainer = $hero_unlocked/ScrollContainer/hbox/prosed_0
@onready var data_card = Card_data_s1.new()
@onready var data_img = Load_images.new()
func set_string_elem(code):
	match code:
		0:return "Light"
		1:return "Nature"
		2:return "Water"
		3:return "Dark"
		4:return "Fire"
func set_string_class(code):
	match code:
		0:return "Warrior"
		1:return "Archer"
		2:return "Knight"
		3:return "Assasin"
		4:return "Support"
		5:return "Mech"
		6:return "Beast"
		7:return "Mage"
		8:return "Healer"
func onready_fragments_set():
	$btn_unlocked.connect("pressed", func():
		$hero_unlocked.show())
	$hero_unlocked/btn_cls.connect("pressed", func():
		$hero_unlocked.hide())
	for card_code in AutoloadData.player_cardAvailable:
		if AutoloadData.player_cardFragments.has(card_code)==false:
			var price:int=0
			var get_rank = data_card.dict_all_card_s1[card_code]["rank"]
			var get_elem = data_card.dict_all_card_s1[card_code]["elem"]
			if get_rank == card_generator.RANK.STAR_1:price+=20000
			elif get_rank == card_generator.RANK.STAR_2:price+=50000
			elif get_rank == card_generator.RANK.STAR_3:price+=100000
			elif get_rank == card_generator.RANK.STAR_4:price+=300000
			elif get_rank == card_generator.RANK.STAR_5:price+=1000000
			elif get_rank == card_generator.RANK.STAR_6:price+=2500000
			if get_elem == card_generator.ELEM.LIGHT or card_generator.ELEM.DARK:
				price += AutoloadData.get_pct(price, 200)
			AutoloadData.player_cardFragments[card_code]={"count":0, "price":price, "locked":true}
			AutoloadData.save_data()
	for card_code in AutoloadData.player_cardFragments:
		generate_unlocked(card_code)
func update_fragmanet(code):
	var node_main = parent_prosed_unlocked.get_node(code)
	var node_frag_count:Label = node_main.get_node("vbox/hbox_frag/total")
	var node_btn_buy:Button = node_main.get_node("vbox/btn")
	var get_count = AutoloadData.player_cardFragments[code]["count"]
	node_frag_count.text = str( AutoloadData.filter_num_k(get_count),"/500" )
	if AutoloadData.player_exp >= AutoloadData.player_cardFragments[code]["price"] and AutoloadData.player_cardFragments[code]["count"] >= 500:
		node_btn_buy.disabled = false
		node_btn_buy.text = str("ARISE: ", AutoloadData.filter_num_k(AutoloadData.player_cardFragments[code]["price"])," Mana")
func generate_unlocked(code):
	var validate_code = AutoloadData.player_cardFragments[code]["locked"]
	if validate_code == false: return
	
	var card_code = data_card.dict_all_card_s1[code]
	
	var new_unlocked = prosed_unlocked.duplicate()
	new_unlocked.name = code
	var node_name:Label = new_unlocked.get_node("vbox/name")
	var node_img:TextureRect = new_unlocked.get_node("vbox/img")
	var node_sprite_star:Sprite2D = new_unlocked.get_node("vbox/main")
	var node_elem_img:TextureRect = new_unlocked.get_node("vbox/hbox_elem/img")
	var node_elem_txt:Label = new_unlocked.get_node("vbox/hbox_elem/txt")
	var node_class_img:TextureRect = new_unlocked.get_node("vbox/hbox_class/img")
	var node_class_txt:Label = new_unlocked.get_node("vbox/hbox_class/txt")
	var node_frag_total:Label = new_unlocked.get_node("vbox/hbox_frag/total")
	var node_btn_arise:Button = new_unlocked.get_node("vbox/hbox_frag/btn_arise")
	var node_btn:Button = new_unlocked.get_node("vbox/btn")
	
	# BTN ARISE --------------
	var check_price = AutoloadData.get_pct(AutoloadData.player_cardFragments[code]["price"], 10)
	node_btn_arise.text = str("Arise: ",AutoloadData.filter_num_k(check_price))
	node_btn_arise.connect("pressed", func():
		var check_mana = AutoloadData.player_exp
		if check_mana >= check_price:
			if AutoloadData.player_cardFragments[code]["count"] >= 500:
				node_btn_arise.text = "Soul Full"
				node_btn_arise.disabled = true
				SfxManager.play_system_fail()
				return
			AutoloadData.player_exp -= check_price
			AutoloadData.save_data()
			show_soul(code)
		else:
			SfxManager.play_system_fail() )
	
	var node_pnl_skill:PanelContainer = new_unlocked.get_node("vbox/pnl_skill")
	var node_skill_0:VBoxContainer = node_pnl_skill.get_node("vbox_s0")
	var node_skill_1:VBoxContainer = node_pnl_skill.get_node("vbox_s1")
	var node_skill_2:VBoxContainer = node_pnl_skill.get_node("vbox_s2")
	var node_skill_3:VBoxContainer = node_pnl_skill.get_node("vbox_s3")
	
	var node_hbox_btn:HBoxContainer = new_unlocked.get_node("vbox/hbox_btn_skill")
	var node_btn_skill_0:Button = node_hbox_btn.get_node("btn_s0")
	var node_btn_skill_1:Button = node_hbox_btn.get_node("btn_s1")
	var node_btn_skill_2:Button = node_hbox_btn.get_node("btn_s2")
	var node_btn_skill_3:Button = node_hbox_btn.get_node("btn_s3")
	
	var all_vbox_skill = [node_skill_0, node_skill_1, node_skill_2, node_skill_3]
	var all_btn_switch = [node_btn_skill_0, node_btn_skill_1, node_btn_skill_2, node_btn_skill_3]
	var all_desc_skill = [Card_data_s1.ENUM_SET_DES.S0, Card_data_s1.ENUM_SET_DES.S1, Card_data_s1.ENUM_SET_DES.S2, Card_data_s1.ENUM_SET_DES.S3]
	# SET BTN PRESSED FOR HIDE AND SHOW SKILL & DESC
	for i in all_btn_switch.size():
		# DESC
		var get_desc:RichTextLabel = all_vbox_skill[i].get_node("pnl_skill/vbox/desc_main")
		var get_cd:Label = all_vbox_skill[i].get_node("pnl_skill/vbox/hbox/cd")
		var desc_main = data_card.set_desc_card(all_desc_skill[i], code)["desc"]
		var desc_cd = data_card.set_desc_card(all_desc_skill[i], code)["cd"]
		get_desc.text = desc_main
		get_cd.text = desc_cd
		# BTN
		var btn:Button = all_btn_switch[i]
		btn.connect("pressed", func():
			SfxManager.play_click()
			for ii in all_vbox_skill.size():
				all_vbox_skill[ii].visible = i==ii )
	# SET BTN PRESSED FOR HIDE MAIN PANEL SKILL
	var node_btn_switch:Button = new_unlocked.get_node("vbox/btn_switch_skill")
	node_btn_switch.show()
	node_sprite_star.show()
	node_btn_switch.connect("pressed", func():
		SfxManager.play_click()
		node_img.visible = !node_img.visible
		node_hbox_btn.visible = !node_hbox_btn.visible
		node_pnl_skill.visible = !node_pnl_skill.visible
		if node_img.visible:node_btn_switch.text = "SHOW SKILL"
		else: node_btn_switch.text = "HIDE SKILL" )
	
	node_name.text = card_code["name"]
	node_img.texture = load(card_code["img"])
	node_sprite_star.frame = card_code["rank"]
	node_elem_img.texture = data_img.img_elemen[card_code["elem"]+1][true]
	node_elem_img.show()
	node_elem_txt.text = set_string_elem(card_code["elem"])
	node_class_img.texture = data_img.img_class[card_code["job"]+1][true]
	node_class_img.show()
	node_class_txt.text = set_string_class(card_code["job"])
	node_frag_total.text = str( AutoloadData.filter_num_k(AutoloadData.player_cardFragments[code]["count"]),"/500" )
	
	if AutoloadData.player_cardFragments[code]["count"] >= 500 and AutoloadData.player_exp >= AutoloadData.player_cardFragments[code]["price"]:
		node_btn.disabled = false
		node_btn.text = str("ARISE: ", AutoloadData.filter_num_k(AutoloadData.player_cardFragments[code]["count"]),"Mana")
	else:
		node_btn.text = "NOT ENOUGH"
	
	node_btn.connect("pressed", func():
		if AutoloadData.player_cardFragments[code]["count"] >= 500 and AutoloadData.player_exp >= AutoloadData.player_cardFragments[code]["price"]:
			SfxManager.play_money()
			node_btn.text="Card Purchased !"
			node_btn.disabled=true
			AutoloadData.player_exp -= AutoloadData.player_cardFragments[code]["price"]
			AutoloadData.player_cardFragments[code]["price"] -= 500
			AutoloadData.player_cardFragments[code]["locked"]=false
			AutoloadData.player_cardCollection.append(code)
			AutoloadData.save_data() )
	
	new_unlocked.show()
	parent_prosed_unlocked.add_child(new_unlocked)
@onready var pnl_soul = $pnl_soul
func start_random_blink(texture_rect: TextureRect) -> void:
	await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
	if not is_instance_valid(texture_rect):
		return
	var fade_out := create_tween()
	fade_out.tween_property(texture_rect, "self_modulate:a", 0.0, randf_range(0.1, 0.3))
	await fade_out.finished
	var fade_in := create_tween()
	fade_in.tween_property(texture_rect, "self_modulate:a", 1.0, randf_range(0.1, 0.3))
	await fade_in.finished
	# Lanjutkan blink lagi
	start_random_blink(texture_rect)
func rotate_forever(texture_rect: TextureRect, duration: float, clockwise: bool, random_blink: bool) -> void:
	var tween := create_tween()
	tween.set_loops()
	var angle := TAU if clockwise else -TAU
	tween.tween_property(texture_rect, "rotation", angle, duration)\
		.from(0.0)\
		.as_relative()
	if random_blink:
		start_random_blink(texture_rect)
func onready_soul():
	var node_ss_spell = pnl_soul.get_node("ss_bg/ss_spell")
	var node_ss_particel_0 = pnl_soul.get_node("ss_bg/ss_particel_0")
	var node_ss_particel_1 = pnl_soul.get_node("ss_bg/ss_particel_1")
	var node_ss_particel_2 = pnl_soul.get_node("ss_bg/ss_particel_2")
	rotate_forever(node_ss_spell, 15.0, true, false)
	rotate_forever(node_ss_particel_0, 1.5, false, true)
	rotate_forever(node_ss_particel_1, 2.5, true, true)
	rotate_forever(node_ss_particel_2, 5.0, false, true)
	var btn_cls_soul:Button = pnl_soul.get_node("btn_cls")
	btn_cls_soul.connect("pressed", func():
		pnl_soul.hide() )
func tween_number(from_value, to_value, duration, label_node: Label) -> void:
	var tween := create_tween()
	tween.tween_method(
		func(value):
			label_node.text = str(round(value))
			SfxManager.play_count(),
		from_value,
		to_value,
		duration
	)
func show_soul(card_code):
	var get_count:Label = pnl_soul.get_node("count")
	get_count.text = "0"
	var get_img_main:TextureRect = pnl_soul.get_node("ss_bg/ss_main")
	get_img_main.texture = load(data_card.dict_all_card_s1[card_code]["icon"])
	var rng = randi_range(1, 100)
	pnl_soul.show()
	SfxManager.play_roadmap_soul()
	await get_tree().create_timer(.25).timeout
	var total_soul:int = 0
	if rng <= 10: total_soul += randi_range(100, 250)
	elif rng <= 30: total_soul += randi_range(50, 100)
	elif rng <= 50: total_soul += randi_range(25, 50)
	else: total_soul += 25
	tween_number(0, total_soul, 1, get_count)
	AutoloadData.player_cardFragments[card_code]["count"]+=total_soul
	var limit_count = clamp( AutoloadData.player_cardFragments[card_code]["count"], 0, 500 )
	AutoloadData.player_cardFragments[card_code]["count"] = limit_count
	update_fragmanet(card_code)
	AutoloadData.save_data()
	
	
