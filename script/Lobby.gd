extends Node

func _ready():
	#---------------------------------
	onready_slide_story()
	onreadt_btn_unlocked_level()
	onready_setting()
	onready_gearset()
	onready_inven_eq_btn()
	onready_btn_inven()
	onready_btn_cardManager()
	onready_btn_card()
	autoload_redeem_history()
	autoload_story_stage()
	onready_redeem()
	onready_filter_deck()
	onready_prosedural_deck()
	onready_btn_enemy_deck()
	onready_anim_deck()
	onready_btn_sort_class()
	onready_btn_sort_elem()
	onready_btn_sort_star()
	onready_btn_setting_story()
	onready_btn_setting()
	onready_btn_bab()
	onready_btn_action()
	onready_btn_gate()
	onready_btn_stage()
	onready_btn_pickDeck()
	update_resources_player()
	cm_menu_card = ENUM_CARD_MENU.MY_CARD
	cm_filter_main()
	SfxManager.lw_onready_bgm(SfxManager.ENUM_BGM.LOBBY)
	update_bab_story(data_story_desc[1])
	# level
	var update_level = AutoloadData.update_player_level()
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/vbox/level.text = update_level["level"]
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/vbox/exp_need.text = update_level["exp"]
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/vbox/prog_exp.value = update_level["prog"]
	set_bab_indicator(AutoloadData.temp_bab)

# =======================================================
# SLIDER
# =======================================================
func scroll_slide(scroll_node: ScrollContainer, is_horizontal: bool, is_reverse: bool) -> void:
	var tween := create_tween()
	var delta := 200
	if is_reverse:
		delta *= -1
	if is_horizontal:
		var from := scroll_node.scroll_horizontal
		var to := from + delta
		tween.tween_property(scroll_node, "scroll_horizontal", to, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	else:
		var from := scroll_node.scroll_vertical
		var to := from + delta
		tween.tween_property(scroll_node, "scroll_vertical", to, 0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func onready_slide_story():
	var get_scrollc_story = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer
	var get_parent_story = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/hbox_btn
	var get_parent_stage = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/vbox
	var get_scrollc_stage = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2
	var get_scrollc_fullstory = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer2/ScrollContainer
	var get_parent_fullstory = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer2/vbox
	var get_parent_smallstory = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/prosedural_bab_story/btn_fullstory/vbox
	var get_scroll_smallstory = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/prosedural_bab_story/ScrollContainer
	var btn_next:Button = get_parent_story.get_child(0)
	var btn_prev:Button = get_parent_story.get_child(1)
	btn_next.connect("pressed", scroll_slide.bind(get_scrollc_story, true, true) )
	btn_prev.connect("pressed", scroll_slide.bind(get_scrollc_story, true, false) )
	var btn_slide_top:Button = get_parent_stage.get_child(0)
	var btn_slide_bott:Button = get_parent_stage.get_child(1)
	btn_slide_top.connect("pressed", scroll_slide.bind(get_scrollc_stage, false, true) )
	btn_slide_bott.connect("pressed", scroll_slide.bind(get_scrollc_stage, false, false) )
	var btn_fullstory_top = get_parent_fullstory.get_child(0)
	var btn_fullstory_bott = get_parent_fullstory.get_child(1)
	btn_fullstory_top.connect("pressed", scroll_slide.bind(get_scrollc_fullstory, false, true) )
	btn_fullstory_bott.connect("pressed", scroll_slide.bind(get_scrollc_fullstory, false, false) )
	var btn_smallstory_up:Button = get_parent_smallstory.get_child(0)
	var btn_smallstory_down:Button = get_parent_smallstory.get_child(1)
	btn_smallstory_up.connect("pressed", scroll_slide.bind(get_scroll_smallstory, false, true) )
	btn_smallstory_down.connect("pressed", scroll_slide.bind(get_scroll_smallstory, false, false) )
# --------------------------------------------------------
enum ENUM_SET_NOTIF{RED, ORANGE, BLUE}

func onreadt_btn_unlocked_level():
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_dungeon/VBoxContainer4/dungeon.connect("pressed", func():
		set_notification(ENUM_SET_NOTIF.RED, "Under developing !") )
	
	$btn_lock_shop.connect("pressed", func():
		if AutoloadData.player_level >= 5:
			$btn_lock_shop.hide()
			$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/panel_shop/VBoxContainer/shop.disabled=false
		else:set_notification(ENUM_SET_NOTIF.ORANGE, "SHOP OPEN IN LEVEL 5") )
	
	$btn_lock_roadmap.connect("pressed", func():
		if AutoloadData.player_level >= 6:
			$btn_lock_roadmap.hide()
			$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_quest/VBoxContainer2/quest.disabled=false
		else:set_notification(ENUM_SET_NOTIF.ORANGE, "ROADMAP OPEN IN LEVEL 6") )
	
	if AutoloadData.player_level >= 5:
		$btn_lock_shop.hide()
		$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/panel_shop/VBoxContainer/shop.disabled=false
	if AutoloadData.player_level >= 6:
		$btn_lock_roadmap.hide()
		$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_quest/VBoxContainer2/quest.disabled=false

func add_player_exp_level(value):
	AutoloadData.system_level_manager(value)
	var update_level = AutoloadData.update_player_level()
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/vbox/level.text = update_level["level"]
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/vbox/exp_need.text = update_level["exp"]
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/vbox/prog_exp.value = update_level["prog"]
#---------------------------------AUTOLOAD--------------------------------------
@onready var player_money:Label = $ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/PanelContainer3/HBoxContainer/money
@onready var player_exp:Label = $ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/PanelContainer2/HBoxContainer/exp
@onready var player_super_ticket:Label = $ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/PanelContainer/HBoxContainer/super_ticket

func update_resources_player():
	AutoloadData.load_data()
	player_money.text = str(filter_num_k(AutoloadData.player_money))
	player_exp.text = str(filter_num_k(AutoloadData.player_exp))
	player_super_ticket.text = str(filter_num_k(AutoloadData.player_super_ticket))
	$ui_currency/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/PanelContainer4/HBoxContainer/spin_coin.text = str(AutoloadData.player_spin_coin)
#-------------------------------------------------------------------------------
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
#-------------------------------------------------------------------------------
func autload_player_money(value):
	AutoloadData.player_money+=value
	AutoloadData.save_data()
	update_resources_player()
func autoload_player_exp(value):
	AutoloadData.player_exp+=value
	AutoloadData.save_data()
	update_resources_player()
func autoload_player_super_ticket():
	AutoloadData.player_super_ticket+=1000
	AutoloadData.save_data()
	update_resources_player()
func autoload_add_new_card(code:String):
	if code in AutoloadData.player_cardCollection: return
	else:
		AutoloadData.player_cardCollection.append(code)
		AutoloadData.save_data()

func autoload_story_stage():
	var clear_stage = AutoloadData.story_stage[0]["total"]
	for i in arr_prosedural_main_stage.size():
		arr_prosedural_main_stage[i].disabled = clear_stage == 0 or i >= clear_stage

# ----------- BTN ACTION SWITCH -----------
enum ENUM_LOBBY_ACTION { GATE, BAB_STORY, BAB_ALL }
@onready var lobby_action_switch = [
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/prosedural_bab_story,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer
]

func lobby_action(code: ENUM_LOBBY_ACTION):
	for i in range(lobby_action_switch.size()):
		lobby_action_switch[i].visible = (i == code)  # Perbaikan di sini

# ----------- BTN BAB -----------
@onready var arr_btn_bab = [
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer/bab_1,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer2/bab_2,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer3/bab_3,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer4/bab_4,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer5/bab_5,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer6/bab_6,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer7/bab_7
]
func onready_btn_bab():
	for i in range(arr_btn_bab.size()):
		var btn = arr_btn_bab[i]
		if btn is Button:
			btn.connect("pressed", on_button_pressed.bind(btn, i))
			btn.connect("mouse_entered", on_button_hover.bind(btn))
			btn.connect("mouse_exited", on_button_exit.bind(btn))
			btn.disabled = true  # Set awal semua tombol disabled
var last_pressed_button = null  # Menyimpan tombol terakhir yang ditekan
func on_button_pressed(selected_button, index):
	SfxManager.play_menu_select()
	for btn in arr_btn_bab:
		btn.disabled = (btn != selected_button)

	last_pressed_button = selected_button
	
	# Panggil fungsi berdasarkan tombol yang ditekan
	match index:
		0: on_bab_1_pressed()
		1: on_bab_2_pressed()
		2: on_bab_3_pressed()
		3: on_bab_4_pressed()
		4: on_bab_5_pressed()
		5: on_bab_6_pressed()
		6: on_bab_7_pressed()

func on_button_hover(hovered_button):
	hovered_button.disabled = false

func on_button_exit(exited_button):
	if exited_button != last_pressed_button:
		exited_button.disabled = true

# Fungsi kosong yang bisa kamu isi sendiri
@onready var get_story_bab_desc:Label = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/pnl_desc/desc
var data_story_desc = ["bab_0","bab_1","bab_2","bab_3","bab_4","bab_5","bab_6","bab_7",]
func update_bab_story(code):
	var get_language_bool = AutoloadData.setting_language_is_EN
	var main_desc
	if get_language_bool: main_desc = data_story_en.new()
	elif get_language_bool == false: main_desc = data_story_id.new()
	get_story_bab_desc.text = main_desc.main_data[code]
func on_bab_1_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_1
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(1)
	update_bab_story(data_story_desc[1])
func on_bab_2_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_2
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(2)
	update_bab_story(data_story_desc[2])
func on_bab_3_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_3
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(3)
	update_bab_story(data_story_desc[3])
func on_bab_4_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_4
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(4)
func on_bab_5_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_5
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(5)
func on_bab_6_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_6
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(6)
func on_bab_7_pressed():
	current_bab = ENUM_BAB_SELECT.BAB_7
	set_bab_indicator(current_bab)
	hide_prosedural_select_stage()
	animate_chapter_size(7)

# ----------- PANEL PROSEDURAL STAGE -----------
enum ENUM_BAB_SELECT{BAB_1,BAB_2,BAB_3,BAB_4,BAB_5,BAB_6,BAB_7}
enum ENUM_STAGE{S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12}
func set_bab_indicator(code:ENUM_BAB_SELECT):
	var set_txt
	var img_data = Load_images.new()
	match code:
		0: set_txt = "CHAPTER 1"
		1: set_txt = "CHAPTER 2"
		2: set_txt = "CHAPTER 3"
		3: set_txt = "CHAPTER 4"
		4: set_txt = "CHAPTER 5"
		5: set_txt = "CHAPTER 6"
		6: set_txt = "CHAPTER 7"
	bab_indicator_txt.text = set_txt
	panel_fullstory_header.text = set_txt
	var clear_stage = AutoloadData.story_stage[code]["total"]
	for i in arr_prosedural_main_stage.size():
		arr_prosedural_main_stage[i].disabled = clear_stage == 0 or i >= clear_stage
		var img_star:TextureRect = arr_prosedural_main_stage[i].get_node("star")
		var path = img_data.img_stage_star( AutoloadData.stage_star[current_bab][i] )
		img_star.texture = load(path)
		
	
var current_bab:ENUM_BAB_SELECT = ENUM_BAB_SELECT.BAB_1
var current_stage:ENUM_STAGE = ENUM_STAGE.S1
var current_card_1 = null 
var current_card_2 = null
var current_card_3 = null
@onready var arr_stage := [
	"stage_1", "stage_2", "stage_3", "stage_4", "stage_5", "stage_6", 
	"stage_7", "stage_8", "stage_9", "stage_10", "stage_11", "stage_12"]
@onready var arr_bab = ["bab_1", "bab_2", "bab_3", "bab_4", "bab_5", "bab_6", "bab_7"]
@onready var bab_indicator_txt:Label = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/bab_indicator
@onready var arr_prosedural_main_stage := [
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_1,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_2,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_3,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_4,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_5,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_6,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_7,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_8,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_9,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_10,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_11,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage/ScrollContainer2/prosedural_bab/stage_12]
@onready var prosedural_main_stage:PanelContainer = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_main_stage
@onready var prosedural_select_stage:PanelContainer = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_select_stage
@onready var btn_cardicon_1:Button = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_select_stage/VBoxContainer/ScrollContainer/vbox/main_challanger/VBoxContainer/hero_panel_stage/hero_1
@onready var btn_cardicon_2:Button = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_select_stage/VBoxContainer/ScrollContainer/vbox/main_challanger/VBoxContainer/hero_panel_stage/hero_2
@onready var btn_cardicon_3:Button = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_select_stage/VBoxContainer/ScrollContainer/vbox/main_challanger/VBoxContainer/hero_panel_stage/hero_3
@onready var btn_cls_prosedural_stage:Button = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_select_stage/VBoxContainer/HBoxContainer/btn_cls
@onready var story_header:Label = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/prosedural_bab_story/prosedural_header
@onready var story_main:Label = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/prosedural_bab_story/ScrollContainer/prosedural_story
@onready var story_stage:Label = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/prosedural_bab_story/prosedural_stage
@onready var ui_fullstory:PanelContainer = $ui_fullstory
@onready var panel_fullstory_main:Label = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer2/ScrollContainer/full_panel_story
@onready var panel_fullstory_header:Label = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer/header
@onready var panel_fullstory_stage:Label = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer3/stage
@onready var panel_fullstory_header_1:Label = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer4/header
@onready var panel_fullstory_scrollcontainer:ScrollContainer = $ui_fullstory/VBoxContainer/VBoxContainer/PanelContainer2/ScrollContainer

func hide_prosedural_select_stage():
	prosedural_main_stage.show()
	prosedural_select_stage.hide()
func onready_btn_stage():
	btn_cls_prosedural_stage.connect("pressed", btn_cls_ps)
	for i in arr_prosedural_main_stage.size():
		var btn = arr_prosedural_main_stage[i]
		btn.connect("pressed", on_button_pressed_prosedural_stage.bind(i))

func _on_btn_cls_fullpanel_story_pressed() -> void:
	ui_fullstory.visible = false
func _on_btn_fullstory_pressed() -> void:
	ui_fullstory.visible = true
	panel_fullstory_scrollcontainer.scroll_vertical = 0
func btn_cls_ps():
	SfxManager.play_click()
	lobby_action(ENUM_LOBBY_ACTION.BAB_ALL)
	prosedural_main_stage.show()
	prosedural_select_stage.hide()
var all_current_card = [current_card_1, current_card_2, current_card_3]
func btn_cls_prosedural_story() -> void: 
	lobby_action(ENUM_LOBBY_ACTION.BAB_ALL)
	hide_prosedural_select_stage()
	SfxManager.play_click()
enum ENUM_STORY_TRANSLATE {EN, ID}
var story_translate:ENUM_STORY_TRANSLATE=ENUM_STORY_TRANSLATE.EN
func on_button_pressed_prosedural_stage(stage):
	SfxManager.play_click()
	current_stage = stage
	AutoloadData.current_stage = stage
	AutoloadData.save_data()
	prosedural_main_stage.hide()
	var new_data_battle = Data_battle.new()
	var new_card = Card_data_s1.new()
	var new_bab_story
	match story_translate:
		ENUM_STORY_TRANSLATE.EN: new_bab_story = Data_story_bab_en.new()
		ENUM_STORY_TRANSLATE.ID: new_bab_story = Data_story_bab_id.new()
	var get_stage = arr_stage[stage]
	var get_bab
	AutoloadData.temp_stage=stage
	var all_btnicon = [btn_cardicon_1, btn_cardicon_2, btn_cardicon_3]
	match current_bab:
		ENUM_BAB_SELECT.BAB_1:
			AutoloadData.temp_bab=0
			get_bab = arr_bab[0]
		ENUM_BAB_SELECT.BAB_2:
			AutoloadData.temp_bab=1
			get_bab = arr_bab[1]
		ENUM_BAB_SELECT.BAB_3:
			AutoloadData.temp_bab=2
			get_bab = arr_bab[2]
		ENUM_BAB_SELECT.BAB_4:
			AutoloadData.temp_bab=3
			get_bab = arr_bab[3]
		ENUM_BAB_SELECT.BAB_5:
			AutoloadData.temp_bab=4
			get_bab = arr_bab[4]
		ENUM_BAB_SELECT.BAB_6:
			AutoloadData.temp_bab=5
			get_bab = arr_bab[5]
		ENUM_BAB_SELECT.BAB_7:
			AutoloadData.temp_bab=6
			get_bab = arr_bab[6]
	AutoloadData.save_data()
	var get_header_story = new_bab_story.data_bab_story[get_bab][get_stage]["header"]
	var get_main_story = new_bab_story.data_bab_story[get_bab][get_stage]["story"]
	story_stage.text = get_stage.replace("_", " ")
	story_header.text = get_header_story #
	panel_fullstory_header_1.text = get_header_story
	story_main.text = get_main_story
	panel_fullstory_main.text = get_main_story
	panel_fullstory_stage.text = get_stage.replace("_", " ")
	for i in all_current_card.size():
		var get_cardcode = new_data_battle.data_main_bab[get_bab][get_stage][i]
		all_current_card[i] = get_cardcode
		AutoloadData.cardSet_enemy[i] = get_cardcode
		all_btnicon[i].icon = load(new_card.dict_all_card_s1[get_cardcode]["icon"])
		arr_btn_enemy_deck[i].icon = load(new_card.dict_all_card_s1[get_cardcode]["icon"])
	
	prosedural_select_stage.show()
	lobby_action(ENUM_LOBBY_ACTION.BAB_STORY)

func _on_hero_1_pressed() -> void:
	SfxManager.play_click()
	set_prosedural_card_inspect(all_current_card[0], false)
func _on_hero_2_pressed() -> void:
	SfxManager.play_click()
	set_prosedural_card_inspect(all_current_card[1], false)
func _on_hero_3_pressed() -> void:
	SfxManager.play_click()
	set_prosedural_card_inspect(all_current_card[2], false)

func btncls_prosedural_card_inpect() -> void:
	SfxManager.play_click()
	$ui_prosedural_inspect_00.visible = false
# ----------- BTN ACTION -----------
var last_pressed_panel_action = null  # Menyimpan panel terakhir yang mendapatkan theme
@onready var theme_action = preload("res://Themes/NEW THEME 2/lobby/action_selected.tres") as Theme
@onready var arr_btn_action = [
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/panel_shop/VBoxContainer/shop,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_battle/VBoxContainer/battle,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_quest/VBoxContainer2/quest,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_card/VBoxContainer3/card,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_setting/VBoxContainer4/setting,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_dungeon/VBoxContainer4/dungeon
]
@onready var arr_panel_action=[
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer/panel_shop,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_battle,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_quest,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_card,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_setting,
	$ui_action/VBoxContainer/bar_currency/HBoxContainer/HBoxContainer2/panel_dungeon
]

enum ENUM_LOBBY_ACTION_THEME{SHOP, BATTLE, QUEST, CARD, SETTING, DUNGEON}
func set_lobbyAction_theme(code:ENUM_LOBBY_ACTION_THEME):
	for i in range(arr_panel_action.size()):
		if i == code: arr_panel_action[i].theme = theme_action
		else: arr_panel_action[i].theme = null
func onready_btn_action():
	for i in range(arr_btn_action.size()):
		var btn = arr_btn_action[i]
		if btn is Button:
			btn.connect("pressed", on_button_pressed_action.bind(i))
			btn.connect("mouse_entered", on_button_hover_action.bind(i))
			btn.connect("mouse_exited", on_button_exit_action.bind(i))
func on_button_pressed_action(index):
	SfxManager.play_click()
	update_resources_player()
	# Reset semua panel ke tema default
	for panel in arr_panel_action:
		panel.theme = null

	# Terapkan tema pada panel yang sesuai dengan tombol yang ditekan
	arr_panel_action[index].theme = theme_action
	last_pressed_panel_action = arr_panel_action[index]
	
	# Panggil fungsi berdasarkan tombol yang ditekan
	match index:
		0: on_shop_pressed()
		1: on_battle_pressed()
		2: on_quest_pressed()
		3: on_card_pressed()
		4: on_setting_pressed()
		5: on_gate_pressed()

func on_button_hover_action(index):
	arr_panel_action[index].theme = theme_action
	SfxManager.play_click()

func on_button_exit_action(index):
	if arr_panel_action[index] != last_pressed_panel_action:
		arr_panel_action[index].theme = null  # Hapus tema jika bukan panel terakhir yang ditekan

# Fungsi kosong yang bisa kamu isi sendiri
func on_shop_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()
	AutoloadData.scene_data = "res://scenes/Shop.tscn"
	get_tree().change_scene_to_file("res://scenes/new_loading_screen.tscn")
func on_battle_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()
	lobby_action(ENUM_LOBBY_ACTION.BAB_ALL)
func on_quest_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()
	AutoloadData.scene_data = "res://scenes/Roadmap.tscn"
	get_tree().change_scene_to_file("res://scenes/new_loading_screen.tscn")
func on_card_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()
	card_parent.show()
func on_setting_pressed():
	SfxManager.play_click()
	panel_cls_setting(true)
	hide_prosedural_select_stage()
func on_gate_pressed():
	SfxManager.play_click()
	#hide_prosedural_select_stage()
	#lobby_action(ENUM_LOBBY_ACTION.GATE)
	pass

# ----------- BTN GATE -----------
@onready var arr_btn_gate = [
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer/gate_devil,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer2/gate_dragon,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer3/gate_elf,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer4/gate_goblin,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer5/gate_mecha,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer6/gate_mino,
	$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/main_gate_panel/HBoxContainer/VBoxContainer7/gate_viking
]

func onready_btn_gate():
	for i in range(arr_btn_gate.size()):
		var btn = arr_btn_gate[i]
		if btn is Button:
			btn.connect("pressed", on_main_gate_pressed.bind(btn, i))
			btn.connect("mouse_entered", on_gate_hover.bind(btn))
			btn.connect("mouse_exited", on_gate_exit.bind(btn))
			btn.disabled = true  # Set awal semua tombol disabled

var last_pressed_gate = null  # Menyimpan tombol terakhir yang ditekan

func on_main_gate_pressed(selected_button, index):
	SfxManager.play_click()
	for btn in arr_btn_gate:
		btn.disabled = (btn != selected_button)

	last_pressed_gate = selected_button

	# Panggil fungsi berdasarkan tombol yang ditekan
	match index:
		0: on_gate_devil_pressed()
		1: on_gate_dragon_pressed()
		2: on_gate_elf_pressed()
		3: on_gate_goblin_pressed()
		4: on_gate_mecha_pressed()
		5: on_gate_mino_pressed()
		6: on_gate_viking_pressed()

func on_gate_hover(hovered_button):
	SfxManager.play_click()
	hovered_button.disabled = false

func on_gate_exit(exited_button):
	if exited_button != last_pressed_gate:
		exited_button.disabled = true

# Fungsi kosong yang bisa kamu isi sendiri
func on_gate_devil_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()

func on_gate_dragon_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()

func on_gate_elf_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()

func on_gate_goblin_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()

func on_gate_mecha_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()

func on_gate_mino_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()

func on_gate_viking_pressed():
	SfxManager.play_click()
	hide_prosedural_select_stage()
	
# ----------- PANEL PROSEDURAL INSPECT HERO -----------
@onready var set_skill_0:RichTextLabel = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/prosedural_skill_0
@onready var set_skill_1:RichTextLabel = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer2/VBoxContainer/ScrollContainer/prosedural_skill_1
@onready var set_skill_2:RichTextLabel = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer3/VBoxContainer/ScrollContainer/prosedural_skill_2
@onready var set_skill_3:RichTextLabel = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer4/VBoxContainer/ScrollContainer/prosedural_skill_3
@onready var set_card_img:TextureRect = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/prosedural_main_icon/border
@onready var set_card_name:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/prosedural_name
@onready var set_card_elem_img:TextureRect = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/prosedural_elem_img
@onready var set_card_elem_txt:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/prosedural_elem_txt
@onready var set_card_class_img:TextureRect = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer2/HBoxContainer/prosedural_class_img
@onready var set_card_class_txt:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer2/HBoxContainer/prosedural_class_txt
@onready var set_card_rank_frame:Sprite2D = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/prosedural_main_icon/rank
@onready var panel_prosedural_skill = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer
@onready var panel_prosedural_biodata:VBoxContainer = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story
@onready var btn_switch_skillNbio:Button = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer3/btn_switch_skillNbio
@onready var prosedural_cd1:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer/cd_1
@onready var prosedural_cd2:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer3/VBoxContainer/HBoxContainer/cd_2
@onready var prosedural_cd3:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/PanelContainer4/VBoxContainer/HBoxContainer/cd_3
@onready var prosedural_gender:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/VBoxContainer3/gender
@onready var prosedural_race:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/VBoxContainer3/race
@onready var prosedural_age:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/VBoxContainer3/age
@onready var prosedural_height:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/VBoxContainer3/height
@onready var prosedural_weight:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/VBoxContainer3/weight
@onready var prosedural_story:Label = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer/ScrollContainer/VBoxContainer/character_story

@onready var prosedural_deck_prog_final = {
	0:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_0/atk_prog/over_ap_final,
	1:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_1/def_prog/over__def_final,
	2:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_2/hp_prog/over_hp_final,
	3:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_3/trn_prog/over_trn_final,
	4:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_9/cst_prog/over_cst_final,
	5:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_4/eva_prog/over_eva_final,
	6:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_5/crt_prog/over_crt_final,
	7:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_6/cdm_prog/over_cdm_final,
	8:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_7/cdf_prog/over_cdf_final,
	9:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_8/spd_prog/over_spd_final,}
@onready var prosedural_deck_prog_over = {
	0:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_0/atk_prog/over_ap,
	1:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_1/def_prog/over__def,
	2:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_2/hp_prog/over_hp,
	3:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_3/trn_prog/over_trn,
	4:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_9/cst_prog/over_cst,
	5:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_4/eva_prog/over_eva,
	6:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_5/crt_prog/over_crt,
	7:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_6/cdm_prog/over_cdm,
	8:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_7/cdf_prog/over_cdf,
	9:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_8/spd_prog/over_spd}
@onready var prosedural_deck_prog = {
	0:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_0/atk_prog,
	1:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_1/def_prog,
	2:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_2/hp_prog,
	3:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_3/trn_prog,
	4:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_9/cst_prog,
	5:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_4/eva_prog,
	6:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_5/crt_prog,
	7:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_6/cdm_prog,
	8:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_7/cdf_prog,
	9:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_8/spd_prog}
@onready var prosedura_dekc_prog_txt = {
	0:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_0/atk,
	1:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_1/atk,
	2:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_2/atk,
	3:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_3/atk,
	4:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_9/atk,
	5:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_4/atk,
	6:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_5/atk,
	7:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_6/atk,
	8:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_7/atk,
	9:$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer2/HBoxContainer/PanelContainer2/hbox_prog/vbox_prog_8/atk}

@onready var set_attk = [1000, 2000, 4000, 10000, 20000, 50000]
@onready var set_deff = [100, 200, 300, 500, 700, 3000]
@onready var set_hp = [5000, 10000, 20000, 50000, 100000, 300000]
@onready var set_turn_speed = [20, 30, 50, 80, 120, 200]
@onready var set_cost = [1, 2, 4, 8, 15, 25]

@onready var set_eva = [5, 10, 0, 50, 0, 50, 100, 0, 0]
@onready var set_c_rate = [10, 5, 0, 10, 0, 5, 6, 0, 0]
@onready var set_c_dmg = [200, 200, 150, 150, 150, 150, 200, 300, 150]
@onready var set_c_deff = [20, 1, 30, 1, 1, 30, 20, 1, 20]
@onready var set_spd_atk = [100, 300, 100, 200, 100, 200, 150, 100, 100]

enum ENUM_CUSTOM_RANK {ATTACKER, AGILITY, DEFENDER, UNIVERSAL}
enum ENUM_CUSTOM_RANK_LEVEL {ATTACKER_LV1, ATTACKER_LV2, ATTACKER_LV3, AGILITY_LV1, AGILITY_LV2, AGILITY_LV3, DEFENDER_LV1, DEFENDER_LV2, DEFENDER_LV3,
UNIVERSAL_LV1, UNIVERSAL_LV2, UNIVERSAL_LV3}
enum ELEM{LIGHT, NATURE, WATER, DARK, FIRE}
enum JOB{WARRIOR, ARCHER, DEFENSE, ASSASIN, SUPPORT, MECH, BEAST, MAGE, HEALER}
enum RANK{STAR_1, STAR_2, STAR_3, STAR_4, STAR_5, STAR_6}
enum ENUM_CHARACHTER_TRANSLATE{EN,ID}
var char_translate:ENUM_CHARACHTER_TRANSLATE=ENUM_CHARACHTER_TRANSLATE.EN
var is_panel_skill_show:bool = true
func _on_btn_switch_skill_nbio_pressed() -> void:
	if is_panel_skill_show:
		btn_switch_skillNbio.text = "SHOW SKILL"
		eq_prog(prosedural_deck_prog, prosedural_deck_prog_over, prosedural_deck_prog_final,prosedura_dekc_prog_txt,card_inspect_filter, card_inspect_stat)
	else: btn_switch_skillNbio.text = "SHOW BIODATA"
	SfxManager.play_click()
	panel_prosedural_skill.visible = !is_panel_skill_show
	panel_prosedural_biodata.visible = is_panel_skill_show
	is_panel_skill_show = !is_panel_skill_show
func code_skill_target(code_target):
	var _get_indic_atk
	if code_target == "single": _get_indic_atk = 0
	elif code_target == "aoe": _get_indic_atk = 1
	elif code_target == "single_spell": _get_indic_atk = 2
	elif code_target == "aoe_spell": _get_indic_atk = 3
	elif code_target == "single_heal": _get_indic_atk = 4
	elif code_target == "aoe_heal": _get_indic_atk = 5
	return _get_indic_atk

func eq_prog(dict_prog: Dictionary,dict_over: Dictionary,dict_final: Dictionary,dict_text: Dictionary,_card_inspect_filter: Dictionary,_card_inspect_stat: Dictionary) -> void:
	var tween := create_tween()
	# Reset semua
	for i in range(10):
		if dict_prog.has(i): dict_prog[i].value = 0
		if dict_over.has(i): dict_over[i].value = 0
		if dict_final.has(i): dict_final[i].value = 0
		if dict_text.has(i): dict_text[i].text = '0'

	# Tween semua nilai secara paralel
	for i in range(10):
		var val = _card_inspect_filter[i]
		var target_stat = _card_inspect_stat[i]
		var label_node = dict_text[i]

		tween.parallel().tween_property(dict_prog[i], 'value', val, 0.25)
		tween.parallel().tween_property(dict_over[i], 'value', (val - 100.0) / 10.0, 0.25)
		tween.parallel().tween_property(dict_final[i], 'value', (val - 1100.0) / 50.0, 0.25)

		tween.parallel().tween_method(
			func(t): label_node.text = filter_num_k(t),
			0.0,
			target_stat,
			0.1 )

var card_inspect_stat = {0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
var card_inspect_filter = {0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0}
var local_card_code
@onready var gearset_parent = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_all/hbox/pnl_eq/grid_parent
@onready var gearset_prosed = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_all/hbox/pnl_eq/grid_parent/gear_prosed
@onready var gearset_parent_btn_eq = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq/pnl_eq/hbox/grid_eq
@onready var gearset_parent_btn_acc = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq/pnl_ac/hbox/grid_acc
@onready var pnl_gear_all = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq
@onready var pnl_gear_set = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_all
@onready var pnl_preview_gs_used = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_all/gear_used
@onready var pnl_preview_gs_use = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_all/gear_use
@onready var pnl_preview_gs = {true: pnl_preview_gs_use, false:pnl_preview_gs_used}

# TEMP CURRECT FOR GEARSET
# USED: 
# USE: PREVIEW GEAR
# GS_CODE: wpn, gloves, armor etc.
# CARD_CODE: last card_code
@onready var data_current_gearset = {"used":null, "use":null, "gs_code":null, "card_code":null}
@onready var data_gearset_enabled ={
	"wpn":null, "armor":null, "gloves":null, "helm":null,
	"shoes":null, "trouser":null, "acc_1":null,"acc_2":null,"acc_3":null,"acc_4":null, }
@onready var gearset_indic = {
	"eq_main":$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq/pnl_eq/hbox/vbox_eq/img,
	"eq_desc":$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq/pnl_eq/hbox/vbox_eq/scrol_c/desc,
	"acc_main":$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq/pnl_ac/hbox/vbox_eq2/img,
	"acc_desc":$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq/pnl_ac/hbox/vbox_eq2/scrol_c/desc,
}
var onready_gearset_bool = true
func onready_gearset():
	var _data_eq = Lobby_equipments.new()
	_data_eq.set_onready_gearset(gearset_prosed, gearset_parent, pnl_preview_gs_use, data_current_gearset)
	var _get_arr = _data_eq.set_onready_gearset(gearset_prosed, gearset_parent, pnl_preview_gs_use, data_current_gearset)
	if _get_arr is Dictionary:
		data_gearset_enabled["wpn"]=_get_arr["wpn"]
		data_gearset_enabled["armor"]=_get_arr["armor"]
		data_gearset_enabled["gloves"]=_get_arr["gloves"]
		data_gearset_enabled["helm"]=_get_arr["helm"]
		data_gearset_enabled["shoes"]=_get_arr["shoes"]
		data_gearset_enabled["trouser"]=_get_arr["trouser"]
		data_gearset_enabled["acc"]=_get_arr["acc"]
	
	if onready_gearset_bool:
		_data_eq.set_onready_btn(gearset_parent_btn_eq, gearset_parent_btn_acc, pnl_gear_all, pnl_gear_set, data_gearset_enabled, gearset_parent, data_current_gearset, pnl_preview_gs)
		onready_gearset_bool = false
func gearset_equip() -> void:
	var _data_eq = Lobby_equipments.new()
	_data_eq.player_gear_equip(pnl_preview_gs, data_current_gearset, gearset_parent)
	_data_eq.load_gear_img(data_current_gearset, gearset_parent_btn_eq, gearset_parent_btn_acc)
	_data_eq.eq_prog_player(
			prosedural_deck_prog,
			prosedural_deck_prog_over,
			prosedural_deck_prog_final,
			prosedura_dekc_prog_txt,
			card_inspect_stat,
			eq_prog,
			data_current_gearset["card_code"],
			gearset_indic)
func gearset_remove() -> void:
	var _data_eq = Lobby_equipments.new()
	_data_eq.player_gear_unequip(pnl_preview_gs, data_current_gearset, gearset_parent)
	_data_eq.load_gear_img(data_current_gearset, gearset_parent_btn_eq, gearset_parent_btn_acc)
	_data_eq.eq_prog_player(
			prosedural_deck_prog,
			prosedural_deck_prog_over,
			prosedural_deck_prog_final,
			prosedura_dekc_prog_txt,
			card_inspect_stat,
			eq_prog,
			data_current_gearset["card_code"],
			gearset_indic)
func set_prosedural_card_inspect(card_code, is_card_hero:bool):
	data_current_gearset["card_code"]=card_code
	local_card_code = card_code
	var new_eq_data = Lobby_equipments.new()
	new_eq_data.enbaled_player_gear(
		is_card_hero,
		$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq,
		$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_all,
		$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/btn_switch_story,
		$ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer
	)
	# -------------- GEARSET:START ------------------
	if AutoloadData.player_gear.has(card_code)==false and is_card_hero:
		new_eq_data.new_gear_dict(card_code)
	if is_card_hero: new_eq_data.load_gear_img(data_current_gearset, gearset_parent_btn_eq, gearset_parent_btn_acc)
	# -------------- GEARSET:END ------------------
	
	is_panel_skill_show = true
	panel_prosedural_skill.show()
	btn_switch_skillNbio.text = "SHOW BIODATA"
	panel_prosedural_biodata.hide()
	
	for i in range(10):
		card_inspect_stat[i] = 0
	$ui_prosedural_inspect_00.visible = true
	var new_card = Card_data_s1.new()
	var set_rank = new_card.dict_all_card_s1[card_code]["rank"]
	var set_card_class = new_card.dict_all_card_s1[card_code]["job"]
	var stat = new_card.dict_all_card_s1[card_code]["c_rank_stat"]
	var value = new_card.dict_all_card_s1[card_code]["c_rank_value"]
	var element = new_card.dict_all_card_s1[card_code]["elem"]
	
	# ------------------ PROGRESS -------------------
	var _eva = set_eva[set_card_class]
	var _crit = set_c_rate[set_card_class]
	var _crit_dmg = set_c_dmg[set_card_class]
	var _crit_def = set_c_deff[set_card_class]
	var _spd_atk = set_spd_atk[set_card_class]
	var _atk = set_attk[set_rank]
	var _def = set_deff[set_rank]
	var _hp = set_hp[set_rank]
	var _cost = set_cost[set_rank]
	var _turn = set_turn_speed[set_rank]
	
	# -------------------DEFAULT CUSTOM RANK ----------------------
	if stat == ENUM_CUSTOM_RANK.ATTACKER:
		if value == ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV1:
			_atk+= get_pct(_atk, 20)
			_hp+= get_pct(_hp, 10)
			_def+=get_pct(_def, 10)
		elif value == ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2:
			_atk+=get_pct(_atk,30)
			_hp+=get_pct(_hp,5)
			_def+=get_pct(_def,5)
		elif value == ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV3:
			_atk += get_pct(_atk, 40)
	if stat == ENUM_CUSTOM_RANK.AGILITY:
		if value == ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1:
			_crit += 5
			_crit_dmg += 50
			_turn += 20
		elif value == ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2:
			_crit += 10
			_crit_dmg += 30
			_turn += 10
		elif value == ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV3:
			_crit += 15
	if stat == ENUM_CUSTOM_RANK.DEFENDER:
		if value == ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1:
			_hp += get_pct(_hp, 30)
			_def += 300
			_crit_def += 30
		elif value == ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2:
			_hp += get_pct(_hp, 60)
			_def += 150
			_crit_def += 15
		elif value == ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV3:
			_hp += get_pct(_hp, 100)
	if stat == ENUM_CUSTOM_RANK.UNIVERSAL:
		if value == ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV1:
			_atk += get_pct(_atk, 20)
			_hp += get_pct(_hp, 20)
			_turn += 20
		elif value == ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV2:
			_atk += get_pct(_atk, 25)
			_hp += get_pct(_hp, 25)
			_turn += 25
		elif value == ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV3:
			_atk += get_pct(_atk, 30)
			_hp += get_pct(_hp, 30)
			_turn += 30
	# ---------------------------JOB-------------------------------
	match set_card_class:
		0:
			_atk += get_pct(_atk, 60)
			_hp += get_pct(_hp, 30)
			_def += get_pct(_def, 15)
			_turn += get_pct(_turn, 5)
		1:
			_atk += get_pct(_atk, 40)
			_hp += get_pct(_hp, 5)
			_def += get_pct(_def, 5)
			_turn += get_pct(_turn, 50)
		2:
			_atk += get_pct(_atk, 5)
			_hp += get_pct(_hp, 90)
			_def += get_pct(_def, 150)
			_turn += get_pct(_turn, 5)
		3:
			_atk += get_pct(_atk, 40)
			_hp += get_pct(_hp, 5)
			_def += get_pct(_def, 5)
			_turn += get_pct(_turn, 50)
		4:
			_atk += get_pct(_atk, 5)
			_hp += get_pct(_hp, 100)
			_def += get_pct(_def, 50)
			_turn += get_pct(_turn, 80)
		5:
			_atk += get_pct(_atk, 25)
			_hp += get_pct(_hp, 25)
			_def += get_pct(_def, 25)
			_turn += get_pct(_turn, 25)
		6:
			_atk += get_pct(_atk, 40)
			_hp += get_pct(_hp, 40)
			_def += get_pct(_def, 10)
			_turn += get_pct(_turn, 10)
		7:
			_atk += get_pct(_atk, 85)
			_hp += get_pct(_hp, 5)
			_def += get_pct(_def, 5)
			_turn += get_pct(_turn, 5)
		8:
			_atk += get_pct(_atk, 5)
			_hp += get_pct(_hp, 100)
			_def += get_pct(_def, 100)
			_turn += get_pct(_turn, 5)
	# ----------------------------ELEM---------------------------------
	match element:
		0:
			_def += get_pct(_def, 20)
			_turn += get_pct(_turn, 20)
		1:
			_hp += get_pct(_hp, 20)
			_def += get_pct(_def, 20)
		2:
			_atk += get_pct(_atk, 20)
			_def += get_pct(_def, 20)
		3:
			_atk += get_pct(_atk, 20)
			_turn += get_pct(_turn, 20)
		4:
			_atk += get_pct(_atk, 20)
			_hp += get_pct(_hp, 20)	
	# --------------------------- EQUIPMENTS --------------------------
	card_inspect_stat[0]=_atk
	card_inspect_stat[1]=_def
	card_inspect_stat[2]=_hp
	card_inspect_stat[3]=_turn
	card_inspect_stat[4]=_cost
	card_inspect_stat[5]=_eva
	card_inspect_stat[6]=_crit
	card_inspect_stat[7]=_crit_dmg
	card_inspect_stat[8]=_crit_def
	card_inspect_stat[9]=_spd_atk
	
	card_inspect_filter[0]=set_pct(_atk, 50000)
	card_inspect_filter[1]=set_pct(_def, 3000)
	card_inspect_filter[2]=set_pct(_hp, 300000)
	card_inspect_filter[3]=set_pct(_turn, 200)
	card_inspect_filter[4]=set_pct(_cost, 25)
	card_inspect_filter[5]=set_pct(_eva, 500)
	card_inspect_filter[6]=set_pct(_crit, 100)
	card_inspect_filter[7]=set_pct(_crit_dmg, 1000)
	card_inspect_filter[8]=set_pct(_crit_def, 100)
	card_inspect_filter[9]=set_pct(_spd_atk, 500)
	
	if is_card_hero:
		new_eq_data.eq_prog_player(
			prosedural_deck_prog,
			prosedural_deck_prog_over,
			prosedural_deck_prog_final,
			prosedura_dekc_prog_txt,
			card_inspect_stat,
			eq_prog,
			data_current_gearset["card_code"],
			gearset_indic)
	else:
		eq_prog(
		prosedural_deck_prog, 
		prosedural_deck_prog_over, 
		prosedural_deck_prog_final,
		prosedura_dekc_prog_txt,
		card_inspect_filter,
		card_inspect_stat)
	# ---------------------------- PROGRESS:END --------------------------
	
	var cd_1 = new_card.dict_all_card_s1[card_code]["skill_1_cd"]
	var cd_2 = new_card.dict_all_card_s1[card_code]["skill_2_cd"]
	var cd_3 = new_card.dict_all_card_s1[card_code]["skill_ulti_cd"]
	var gender = new_card.dict_all_card_s1[card_code]["char_gender"]
	var race = new_card.dict_all_card_s1[card_code]["char_race"]
	var age = new_card.dict_all_card_s1[card_code]["char_age"]
	var height = new_card.dict_all_card_s1[card_code]["char_height"]
	var weight = new_card.dict_all_card_s1[card_code]["char_weight"]
	var story
	match char_translate:
		ENUM_CHARACHTER_TRANSLATE.EN: story = new_card.dict_all_card_s1[card_code]["char_story"]
		ENUM_CHARACHTER_TRANSLATE.ID: story = new_card.dict_all_card_s1[card_code]["char_story_id"]
	prosedural_cd1.text = str("COOLDOWN: ",cd_1," TURN")
	prosedural_cd2.text = str("COOLDOWN: ",cd_2," TURN")
	prosedural_cd3.text = str("COOLDOWN: ",cd_3," TURN")
	prosedural_gender.text = gender
	prosedural_race.text = race
	prosedural_age.text = age
	prosedural_height.text = height
	prosedural_weight.text = weight
	prosedural_story.text = story
	
	var set_skill_0_desc = new_card.fullset_desc(
		new_card.dict_all_card_s1[card_code]["skill_code"],
		new_card.dict_all_card_s1[card_code]["pct_req"],
		new_card.dict_all_card_s1[card_code]["skill_lv"],
		new_card.dict_all_card_s1[card_code]["skill_0_dmg"],
		code_skill_target(new_card.dict_all_card_s1[card_code]["skill_0_target"])
	)
	set_skill_0.text = set_skill_0_desc
	var set_skill_1_desc = new_card.fullset_desc(
		new_card.dict_all_card_s1[card_code]["skill_code_1"],
		new_card.dict_all_card_s1[card_code]["pct_req_1"],
		new_card.dict_all_card_s1[card_code]["skill_1_lv"],
		new_card.dict_all_card_s1[card_code]["skill_1_dmg"],
		code_skill_target(new_card.dict_all_card_s1[card_code]["skill_1_target"])
	)
	set_skill_1.text = set_skill_1_desc
	var set_skill_2_desc = new_card.fullset_desc(
		new_card.dict_all_card_s1[card_code]["skill_code_2"],
		new_card.dict_all_card_s1[card_code]["pct_req_2"],
		new_card.dict_all_card_s1[card_code]["skill_2_lv"],
		new_card.dict_all_card_s1[card_code]["skill_2_dmg"],
		code_skill_target(new_card.dict_all_card_s1[card_code]["skill_2_target"])
	)
	set_skill_2.text = set_skill_2_desc
	var set_skill_3_desc = new_card.fullset_desc(
		new_card.dict_all_card_s1[card_code]["skill_code_ulti"],
		new_card.dict_all_card_s1[card_code]["pct_req_ulti"],
		new_card.dict_all_card_s1[card_code]["skill_ulti_lv"],
		new_card.dict_all_card_s1[card_code]["skill_ulti_dmg"],
		code_skill_target(new_card.dict_all_card_s1[card_code]["skill_ulti_target"])
	)
	set_skill_3.text = set_skill_3_desc
	set_card_img.texture = load(new_card.dict_all_card_s1[card_code]["img"])
	set_card_name.text = str(new_card.dict_all_card_s1[card_code]["name"])
	
	var set_card_elem = new_card.dict_all_card_s1[card_code]["elem"]
	if set_card_elem == ELEM.LIGHT:
		set_card_elem_img.texture = load("res://img/Icon Jobs/New icon elements/icn_class_light.png")
		set_card_elem_txt.text = "LIGHT"
	elif set_card_elem == ELEM.NATURE:
		set_card_elem_img.texture = load("res://img/Icon Jobs/New icon elements/icn_class_nature.png")
		set_card_elem_txt.text = "NATURE"
	elif set_card_elem == ELEM.WATER:
		set_card_elem_img.texture = load("res://img/Icon Jobs/New icon elements/icn_class_water.png")
		set_card_elem_txt.text = "WATER"
	elif set_card_elem == ELEM.DARK:
		set_card_elem_img.texture = load("res://img/Icon Jobs/New icon elements/icn_class_dark.png")
		set_card_elem_txt.text = "DARK"
	elif set_card_elem == ELEM.FIRE:
		set_card_elem_img.texture = load("res://img/Icon Jobs/New icon elements/icn_class_fire.png")
		set_card_elem_txt.text = "FIRE"
	
	if set_card_class == JOB.WARRIOR:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_warr.png")
		set_card_class_txt.text = str("WARRIOR")
	elif set_card_class == JOB.ARCHER:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_arch.png")
		set_card_class_txt.text = str("ARCHER")
	elif set_card_class == JOB.DEFENSE:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_deff.png")
		set_card_class_txt.text = str("KNIGHT")
	elif set_card_class == JOB.ASSASIN:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_assa.png")
		set_card_class_txt.text = str("ASSASIN")
	elif set_card_class == JOB.SUPPORT:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_supp.png")
		set_card_class_txt.text = str("SUPPORT")
	elif set_card_class == JOB.MECH:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_mech.png")
		set_card_class_txt.text = str("MECHA")
	elif set_card_class == JOB.BEAST:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_abbys.png")
		set_card_class_txt.text = str("BEAST")
	elif set_card_class == JOB.MAGE:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_wiz.png")
		set_card_class_txt.text = str("MAGE")
	elif set_card_class == JOB.HEALER:
		set_card_class_img.texture = load("res://img/Icon Class/icn_job_heal.png")
		set_card_class_txt.text = str("HEALER")
	
	if set_rank == RANK.STAR_1: set_card_rank_frame.frame = 0
	elif set_rank == RANK.STAR_2: set_card_rank_frame.frame = 1
	elif set_rank == RANK.STAR_3: set_card_rank_frame.frame = 2
	elif set_rank == RANK.STAR_4: set_card_rank_frame.frame = 3
	elif set_rank == RANK.STAR_5: set_card_rank_frame.frame = 4
	elif set_rank == RANK.STAR_6: set_card_rank_frame.frame = 5
# ------------------ UI SETTING ------------------
@onready var arr_btn_setting = [
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer/account,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer/sound,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer/reedem,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer/story_language,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/ScrollContainer/VBoxContainer/community
]
@onready var arr_panel_setting = [
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/account,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/sound,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/story_languages,
	$lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/community
]
@onready var btn_cls_mainSetting = $lobby_setting
@onready var btn_cls_mainSetting_sub = $lobby_setting/PanelContainer/VBoxContainer/btn_cls_setting
var current_setting_select:ENUM_SETTING_SHOW=ENUM_SETTING_SHOW.STORY
enum ENUM_SETTING_SHOW{ACCOUNT,SOUND,REEDEM,STORY,COMMUNITY}
func panel_cls_setting(_bool:bool):
	SfxManager.play_click()
	update_resources_player()
	btn_cls_mainSetting.visible=_bool
	lobby_action(ENUM_LOBBY_ACTION.BAB_ALL)
	if _bool==false: set_lobbyAction_theme(ENUM_LOBBY_ACTION_THEME.BATTLE)
func setting_show_panel(code:ENUM_SETTING_SHOW):
	for i in arr_panel_setting.size():
		arr_panel_setting[i].visible = i==code
		arr_btn_setting[i].disabled = i!=code
		current_setting_select = code
func onready_btn_setting():
	btn_cls_mainSetting.connect("pressed", panel_cls_setting.bind(false))
	btn_cls_mainSetting_sub.connect("pressed", panel_cls_setting.bind(false))
	for i in arr_btn_setting.size():
		var btn = arr_btn_setting[i]
		btn.disabled=!(i==current_setting_select)
		match i:
			0:btn.connect("pressed",setting_account)
			1:btn.connect("pressed",setting_sound)
			2:btn.connect("pressed",setting_reedem)
			3:btn.connect("pressed",setting_story_language)
			4:btn.connect("pressed",setting_community)
		btn.connect("mouse_entered", setting_btn_isdisabled.bind(false, btn, i))
		btn.connect("mouse_exited", setting_btn_isdisabled.bind(true, btn, i))
func setting_btn_isdisabled(_bool:bool, get_btn, index):
	get_btn.disabled=_bool
	if index == current_setting_select: get_btn.disabled=false
func setting_account():
	SfxManager.play_click()
	setting_show_panel(ENUM_SETTING_SHOW.ACCOUNT)
func setting_sound():
	SfxManager.play_click()
	setting_show_panel(ENUM_SETTING_SHOW.SOUND)
func setting_reedem():
	SfxManager.play_click()
	setting_show_panel(ENUM_SETTING_SHOW.REEDEM)
func setting_story_language():
	SfxManager.play_click()
	setting_show_panel(ENUM_SETTING_SHOW.STORY)
func setting_community():
	SfxManager.play_click()
	setting_show_panel(ENUM_SETTING_SHOW.COMMUNITY)


# ------------------- ONREADY SETTING:START ---------------------
@onready var setting_volume_prog:TextureProgressBar = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/sound/vbox/hbox/prog
@onready var btn_community_parent = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/community/vbox_btn
var setting_link_community = [
	'https://web.facebook.com/profile.php?id=61577659532835',
	'https://discord.gg/egAaC6n5',
	'https://paypal.me/rzyas?country.x=ID&locale.x=id_ID',
	'https://sociabuzz.com/rzyas/tribe'
]

func onready_setting():
	# LINK COMMUNITY BTN
	for i in range(btn_community_parent.get_child_count()):
		var btn:Button = btn_community_parent.get_child(i)
		btn.connect("pressed", func():
			OS.shell_open(setting_link_community[i]))

	# STORY TRANSLATE
	match AutoloadData.setting_language_is_EN:
		true:
			story_translate = ENUM_STORY_TRANSLATE.EN
			char_translate = ENUM_CHARACHTER_TRANSLATE.EN
			btn_story_language.text = "ENGLISH"
		false:
			story_translate = ENUM_STORY_TRANSLATE.ID
			char_translate = ENUM_CHARACHTER_TRANSLATE.ID
			btn_story_language.text = "INDONESIA"
	# SETTING VOLUME
	for i in setting_volume_prog.get_node("hbox_volume").get_child_count():
		var btn:Button = setting_volume_prog.get_node("hbox_volume").get_child(i)
		btn.connect("pressed", func():
			AutoloadData.setting_player_db_level = AutoloadData.setting_default_db_level[i]
			SfxManager.play_click()
			AutoloadData.save_data()
			AutoloadData.load_volume_setting() 
			setting_volume_prog.value = i*25 )
	for i in AutoloadData.setting_default_db_level.size():
		if AutoloadData.setting_player_db_level == AutoloadData.setting_default_db_level[i]:
			setting_volume_prog.value = i*25
		
# ------------------- ONREADY SETTING:END ---------------------

# ------------------ UI SETTING STORY ------------------
@onready var btn_story_language:Button = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/story_languages/VBoxContainer2/btn_story_language
func onready_btn_setting_story():
	SfxManager.play_click()
	btn_story_language.connect("pressed",set_story_translate)

func set_story_translate():
	SfxManager.play_click()
	AutoloadData.setting_language_is_EN = !AutoloadData.setting_language_is_EN
	AutoloadData.save_data()
	match AutoloadData.setting_language_is_EN:
		true:
			story_translate = ENUM_STORY_TRANSLATE.EN
			char_translate = ENUM_CHARACHTER_TRANSLATE.EN
			btn_story_language.text = "ENGLISH"
		false:
			story_translate = ENUM_STORY_TRANSLATE.ID
			char_translate = ENUM_CHARACHTER_TRANSLATE.ID
			btn_story_language.text = "INDONESIA"
			
# ------------------ UI FINAL DECK ------------------
@onready var btn_final_deck = $lobby_deck_final
@onready var icon_sort_all ={
	true: load("res://img/UI (new)/Deck/select_all.png"),
	false: load("res://img/UI (new)/Deck/select_all_disabled.png")}
func set_node_visible(_node, _bool:bool):
	var get_indic:Label = _node.get_node("indic")
	get_indic.visible=_bool
# _________________________________________
var sort_star_all_enable:= {"_bool":true}
var sort_star_1_enable: = {"_bool":true}
var sort_star_2_enable: = {"_bool":true}
var sort_star_3_enable: = {"_bool":true}
var sort_star_4_enable: = {"_bool":true}
var sort_star_5_enable: = {"_bool":true}
var sort_star_6_enable: = {"_bool":true}

@onready var icon_sort_star1 = {
	true: load("res://img/UI (new)/Deck/star_1.png"),
	false: load("res://img/UI (new)/Deck/star_1_disabled.png")}
@onready var icon_sort_star2 = {
	true: load("res://img/UI (new)/Deck/star_2.png"),
	false: load("res://img/UI (new)/Deck/star_2_disabled.png")}
@onready var icon_sort_star3 = {
	true: load("res://img/UI (new)/Deck/star_3.png"),
	false: load("res://img/UI (new)/Deck/star_3_disabled.png")}
@onready var icon_sort_star4 = {
	true: load("res://img/UI (new)/Deck/star_4.png"),
	false: load("res://img/UI (new)/Deck/star_4_disabled.png")}
@onready var icon_sort_star5 = {
	true: load("res://img/UI (new)/Deck/star_5.png"),
	false: load("res://img/UI (new)/Deck/star_5_disabled.png")}
@onready var icon_sort_star6 = {
	true: load("res://img/UI (new)/Deck/star_6.png"),
	false: load("res://img/UI (new)/Deck/star_6_disabled.png")}

@onready var btn_sort_starall = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_all
@onready var btn_sort_star1 = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_1
@onready var btn_sort_star2 = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_2
@onready var btn_sort_star3 = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_3
@onready var btn_sort_star4 = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_4
@onready var btn_sort_star5 = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_5
@onready var btn_sort_star6 = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer/HBoxContainer/star_6

func onready_btn_sort_star():
	var all_btn_star = [btn_sort_starall, btn_sort_star1, btn_sort_star2, btn_sort_star3, btn_sort_star4, btn_sort_star5, btn_sort_star6]
	for i in range(all_btn_star.size()):
		all_btn_star[i].connect("pressed", sort_star.bind(i))
		all_btn_star[i].connect("mouse_entered", set_node_visible.bind(all_btn_star[i], true))
		all_btn_star[i].connect("mouse_exited", set_node_visible.bind(all_btn_star[i], false))

func sort_switch(all_bool, all_btn, all_icon):
	var bools = all_bool.slice(1).map(func(e): return e["_bool"])
	if bools.count(false) == bools.size() or bools.count(true) == bools.size():
		var value = bools[0]
		all_bool[0]["_bool"] = value
		var get_icon:TextureRect = all_btn[0].get_node("icon")
		get_icon.texture = all_icon[0][value]

func sort_star(code):
	SfxManager.play_click()
	var all_bool = [sort_star_all_enable, sort_star_1_enable, sort_star_2_enable, sort_star_3_enable, sort_star_4_enable, sort_star_5_enable, sort_star_6_enable]
	var all_btn = [btn_sort_starall, btn_sort_star1, btn_sort_star2, btn_sort_star3, btn_sort_star4, btn_sort_star5, btn_sort_star6]
	var all_icon =[icon_sort_all, icon_sort_star1, icon_sort_star2, icon_sort_star3, icon_sort_star4, icon_sort_star5, icon_sort_star6]
	match code:
		0:
			sort_star_all_enable["_bool"]=!(sort_star_all_enable["_bool"])
			var get_bool = sort_star_all_enable["_bool"]
			for i in range(all_bool.size()):
				all_bool[i]["_bool"] = get_bool
				var get_icon:TextureRect = all_btn[i].get_node("icon")
				get_icon.texture = all_icon[i][get_bool]
		1, 2, 3, 4, 5, 6:
			all_bool[code]["_bool"] = !(all_bool[code]["_bool"])
			var get_bool = all_bool[code]["_bool"]
			var get_icon:TextureRect = all_btn[code].get_node("icon")
			get_icon.texture = all_icon[code][get_bool]
			
	sort_switch(all_bool, all_btn, all_icon)

# _________________________________________
var sort_elem_all_enable: = {"_bool":true}
var sort_elem_light_enable: = {"_bool":true}
var sort_elem_nature_enable: = {"_bool":true}
var sort_elem_water_enable: = {"_bool":true}
var sort_elem_dark_enable: = {"_bool":true}
var sort_elem_fire_enable: = {"_bool":true}

@onready var icon_sort_elem_light = {
	true:load("res://img/Icon Jobs/New icon elements/icn_class_light.png"),
	false:load("res://img/Icon Jobs/New icon elements/elem_bw_light_disabled.png")}
@onready var icon_sort_elem_nature = {
	true:load("res://img/Icon Jobs/New icon elements/icn_class_nature.png"),
	false:load("res://img/Icon Jobs/New icon elements/elem_bw_nature_disabled.png")}
@onready var icon_sort_elem_water = {
	true:load("res://img/Icon Jobs/New icon elements/icn_class_water.png"),
	false:load("res://img/Icon Jobs/New icon elements/elem_bw_water_disabled.png")}
@onready var icon_sort_elem_dark = {
	true:load("res://img/Icon Jobs/New icon elements/icn_class_dark.png"),
	false:load("res://img/Icon Jobs/New icon elements/elem_bw_dark_disabled.png")}
@onready var icon_sort_elem_fire = {
	true:load("res://img/Icon Jobs/New icon elements/icn_class_fire.png"),
	false:load("res://img/Icon Jobs/New icon elements/elem_bw_fire_disabled.png")}

@onready var btn_sort_elem_all = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/elem_all
@onready var btn_sort_elem_light = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/elem_light
@onready var btn_sort_elem_nature = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/elem_nature
@onready var btn_sort_elem_water = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/elem_water
@onready var btn_sort_elem_dark = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/elem_dark
@onready var btn_sort_elem_fire = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer2/HBoxContainer/elem_fire

func onready_btn_sort_elem():
	var all_btn_elem = [btn_sort_elem_all,btn_sort_elem_light,btn_sort_elem_nature,btn_sort_elem_water,btn_sort_elem_dark,btn_sort_elem_fire]
	for i in range(all_btn_elem.size()):
		all_btn_elem[i].connect("pressed", sort_elem.bind(i))
		all_btn_elem[i].connect("mouse_entered", set_node_visible.bind(all_btn_elem[i], true))
		all_btn_elem[i].connect("mouse_exited", set_node_visible.bind(all_btn_elem[i], false))

func sort_elem(code):
	SfxManager.play_click()
	var all_bool = [sort_elem_all_enable, sort_elem_light_enable, sort_elem_nature_enable, sort_elem_water_enable, sort_elem_dark_enable, sort_elem_fire_enable]
	var all_btn = [btn_sort_elem_all,btn_sort_elem_light,btn_sort_elem_nature,btn_sort_elem_water,btn_sort_elem_dark,btn_sort_elem_fire]
	var all_icon = [icon_sort_all,icon_sort_elem_light,icon_sort_elem_nature,icon_sort_elem_water,icon_sort_elem_dark,icon_sort_elem_fire]
	
	match code:
		0:
			sort_elem_all_enable["_bool"]=!(sort_elem_all_enable["_bool"])
			var get_bool = sort_elem_all_enable["_bool"]
			for i in range(all_bool.size()):
				all_bool[i]["_bool"] = get_bool
				var get_icon:TextureRect = all_btn[i].get_node("icon")
				get_icon.texture = all_icon[i][get_bool]
		1, 2, 3, 4, 5:
			all_bool[code]["_bool"] = !(all_bool[code]["_bool"])
			var get_bool = all_bool[code]["_bool"]
			var get_icon:TextureRect = all_btn[code].get_node("icon")
			get_icon.texture = all_icon[code][get_bool]
	sort_switch(all_bool, all_btn, all_icon)
	
# _________________________________________
var sort_class_all_enable: = {"_bool":true}
var sort_class_war_enable: = {"_bool":true}
var sort_class_arc_enable: = {"_bool":true}
var sort_class_def_enable: = {"_bool":true}
var sort_class_assa_enable: = {"_bool":true}
var sort_class_supp_enable: = {"_bool":true}
var sort_class_mech_enable: = {"_bool":true}
var sort_class_beast_enable: = {"_bool":true}
var sort_class_wiz_enable: = {"_bool":true}
var sort_class_heal_enable: = {"_bool":true}

@onready var icon_sort_class_war = {
	true: load("res://img/Icon Class/icn_job_warr.png"),
	false: load("res://img/Icon Class/class_bw_war_disabled.png")}
@onready var icon_sort_class_arc = {
	true: load("res://img/Icon Class/icn_job_arch.png"),
	false: load("res://img/Icon Class/class_bw_arc_disabled.png")}
@onready var icon_sort_class_def = {
	true: load("res://img/Icon Class/icn_job_deff.png"),
	false: load("res://img/Icon Class/class_bw_def_disabled.png")}
@onready var icon_sort_class_assa = {
	true: load("res://img/Icon Class/icn_job_assa.png"),
	false: load("res://img/Icon Class/class_bw_assa_disabled.png")}
@onready var icon_sort_class_supp = {
	true: load("res://img/Icon Class/icn_job_supp.png"),
	false: load("res://img/Icon Class/class_bw_supp_disabled.png")}
@onready var icon_sort_class_mech = {
	true: load("res://img/Icon Class/icn_job_mech.png"),
	false: load("res://img/Icon Class/class_bw_mech_disabled.png")}
@onready var icon_sort_class_beast = {
	true: load("res://img/Icon Class/icn_job_abbys.png"),
	false: load("res://img/Icon Class/class_bw_beast_disabled.png")}
@onready var icon_sort_class_wiz = {
	true: load("res://img/Icon Class/icn_job_wiz.png"),
	false: load("res://img/Icon Class/class_bw_wiz_disabled.png")}
@onready var icon_sort_class_heal = {
	true: load("res://img/Icon Class/icn_job_heal.png"),
	false: load("res://img/Icon Class/class_bw_heal_disabled.png")}

@onready var btn_sort_class_all = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_all
@onready var btn_sort_class_war = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_war
@onready var btn_sort_class_arc = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_arch
@onready var btn_sort_class_def = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_defender
@onready var btn_sort_class_assa = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_assa
@onready var btn_sort_class_supp = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_supp
@onready var btn_sort_class_mech = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_mech
@onready var btn_sort_class_beast = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_beast
@onready var btn_sort_class_wiz = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_mage
@onready var btn_sort_class_heal = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/PanelContainer3/HBoxContainer/class_heal

func onready_btn_sort_class():
	var all_btn = [btn_sort_class_all, btn_sort_class_war, btn_sort_class_arc, btn_sort_class_def, btn_sort_class_assa, btn_sort_class_supp, btn_sort_class_mech, btn_sort_class_beast, btn_sort_class_wiz, btn_sort_class_heal]
	for i in range(all_btn.size()):
		all_btn[i].connect("pressed", sort_class.bind(i))
		all_btn[i].connect("mouse_entered", set_node_visible.bind(all_btn[i], true))
		all_btn[i].connect("mouse_exited", set_node_visible.bind(all_btn[i], false))

func sort_class(code):
	SfxManager.play_click()
	var all_bool = [sort_class_all_enable, sort_class_war_enable, sort_class_arc_enable, sort_class_def_enable, sort_class_assa_enable, sort_class_supp_enable, sort_class_mech_enable, sort_class_beast_enable, sort_class_wiz_enable, sort_class_heal_enable]
	var all_btn = [btn_sort_class_all, btn_sort_class_war, btn_sort_class_arc, btn_sort_class_def, btn_sort_class_assa, btn_sort_class_supp, btn_sort_class_mech, btn_sort_class_beast, btn_sort_class_wiz, btn_sort_class_heal]
	var all_icon = [icon_sort_all,icon_sort_class_war, icon_sort_class_arc, icon_sort_class_def, icon_sort_class_assa, icon_sort_class_supp, icon_sort_class_mech, icon_sort_class_beast, icon_sort_class_wiz, icon_sort_class_heal]
	match code:
		0:
			sort_class_all_enable["_bool"]=!(sort_class_all_enable["_bool"])
			var get_bool = sort_class_all_enable["_bool"]
			for i in range(all_bool.size()):
				all_bool[i]["_bool"] = get_bool
				var get_icon:TextureRect = all_btn[i].get_node("icon")
				get_icon.texture = all_icon[i][get_bool]
		1, 2, 3, 4, 5,6,7,8,9,10:
			all_bool[code]["_bool"] = !(all_bool[code]["_bool"])
			var get_bool = all_bool[code]["_bool"]
			var get_icon:TextureRect = all_btn[code].get_node("icon")
			get_icon.texture = all_icon[code][get_bool]
	sort_switch(all_bool, all_btn, all_icon)
# ____________________FINAL DECK ANIM_____________________
@onready var panel_final_deck = $lobby_deck_final/PanelContainer
@onready var panel_main_sort = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort
@onready var btn_final_attack:Button = $lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/btn_attack
@onready var btn_isEditDeck:Button = $lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/btn_isEditDeck

var is_edit_deck:bool = true
var is_edit_deck_txt = {
	true: "EDIT DECK",
	false: "SAVE DECK"
}

func onready_anim_deck():
	btn_isEditDeck.connect("pressed", _on_btn_isEditDeck_pressed)

func _on_btn_isEditDeck_pressed():
	anim_sort_deck(is_edit_deck)
	is_edit_deck = !is_edit_deck
	btn_isEditDeck.text = is_edit_deck_txt[is_edit_deck]

func anim_sort_deck(_bool: bool):
	btn_isEditDeck.disabled = true
	var end_y := 900 if _bool else 500
	panel_main_sort.visible = false
	btn_final_attack.visible = false  # langsung false saat anim mulai

	var tween := create_tween()
	tween.tween_property(panel_final_deck, "custom_minimum_size:y", end_y, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.connect("finished", func():
		if _bool:
			panel_main_sort.visible = true
		else:
			# hanya true saat selesai save
			btn_final_attack.visible = true
		btn_isEditDeck.disabled = false
	)
# ____________________DECK SET ENEMY_____________________
@onready var panel_main_deck = $lobby_deck_final
@onready var btn_enable_deck = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer2/prosedural_select_stage/VBoxContainer/ScrollContainer/vbox/main_challanger/VBoxContainer/btn_start_battle
@onready var btn_disabled_deck = $lobby_deck_final/PanelContainer/VBoxContainer/btn_cls_setup
@onready var btn_disabled_deck_bg = $lobby_deck_final
@onready var arr_btn_enemy_deck = [
	$lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/deck_enem_0,
	$lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/deck_enem_1,
	$lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/deck_enem_2]
func deck_setup_isEnabled(_bool:bool):
	SfxManager.play_click()
	panel_main_deck.visible = _bool
func onready_btn_enemy_deck():
	btn_enable_deck.connect("pressed", deck_setup_isEnabled.bind(true))
	btn_disabled_deck.connect("pressed", deck_setup_isEnabled.bind(false))
	btn_disabled_deck_bg.connect("pressed", deck_setup_isEnabled.bind(false))
func _on_deck_enem_0_pressed() -> void:
	SfxManager.play_click()
	set_prosedural_card_inspect(AutoloadData.cardSet_enemy[0], false)
func _on_deck_enem_1_pressed() -> void:
	SfxManager.play_click()
	set_prosedural_card_inspect(AutoloadData.cardSet_enemy[1], false)
func _on_deck_enem_2_pressed() -> void:
	SfxManager.play_click()
	set_prosedural_card_inspect(AutoloadData.cardSet_enemy[2], false)
# _________________________________________

# ___________________PROSEDURAL DECK LIST______________________
var current_deck_select = "" # KETIKAA HERO DI DECK FINAL DITEKAN MAKA KODE DICT SEPERTI s1_000 akan muncul
@onready var prosedural_deck_gen = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/PanelContainer2/ScrollContainer/main_grid/prosedural_list_deck
@onready var prosedural_deck_parent = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/PanelContainer2/ScrollContainer/main_grid

@onready var setDeck_icon_current:TextureRect = $lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/PanelContainer2/hero_current_selected
@onready var btn_setDeck_cls_main = $lobby_deck_final/set_deck_hero
@onready var btn_setDeck_cls = $lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/btn_cls
@onready var setDeck_icon = [
	$lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/hero_slot_1,
	$lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/hero_slot_2,
	$lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer/HBoxContainer/hero_slot_3]
@onready var btn_setDeck = [
	$lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer2/HBoxContainer/btn_select_hero_1,
	$lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer2/HBoxContainer/btn_select_hero_2,
	$lobby_deck_final/set_deck_hero/PanelContainer/VBoxContainer/PanelContainer2/HBoxContainer/btn_select_hero_3]
@onready var btn_get_deck_hero = [
	$lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/HBoxContainer/deck_hero_0,
	$lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/HBoxContainer/deck_hero_1,
	$lobby_deck_final/PanelContainer/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer3/VBoxContainer/HBoxContainer/deck_hero_2]

func _on_deck_hero_0_pressed() -> void:
	set_prosedural_card_inspect(AutoloadData.cardSet_player[0], true)
func _on_deck_hero_1_pressed() -> void:
	set_prosedural_card_inspect(AutoloadData.cardSet_player[1], true)
func _on_deck_hero_2_pressed() -> void:
	set_prosedural_card_inspect(AutoloadData.cardSet_player[2], true)

func onready_btn_pickDeck():
	var new_data = Card_data_s1.new()
	var all_icon = {
		0:load(new_data.dict_all_card_s1[AutoloadData.cardSet_player[0]]["icon"]),
		1:load(new_data.dict_all_card_s1[AutoloadData.cardSet_player[1]]["icon"]),
		2:load(new_data.dict_all_card_s1[AutoloadData.cardSet_player[2]]["icon"])}
	
	for i in range(btn_get_deck_hero.size()):
		btn_get_deck_hero[i].icon = all_icon[i]
	
	for i in range(btn_setDeck.size()):
		btn_setDeck[i].connect("pressed", changes_deck.bind(i))
	btn_setDeck_cls_main.connect("pressed", func(): btn_setDeck_cls_main.hide())
	btn_setDeck_cls.connect("pressed", func(): btn_setDeck_cls_main.hide())
		
func changes_deck(code):
	SfxManager.play_click()
	var new_data = Card_data_s1.new()
	var get_icon = load(new_data.dict_all_card_s1[current_deck_select]["icon"])
	setDeck_icon[code].texture = get_icon
	btn_get_deck_hero[code].icon = get_icon
	AutoloadData.cardSet_player[code] = current_deck_select
	AutoloadData.save_data()
	btn_setDeck_cls_main.hide()

func pick_deck(code):
	btn_setDeck_cls_main.show()
	var new_data = Card_data_s1.new()
	var get_icon_current = load(new_data.dict_all_card_s1[code]["icon"])
	var get_icon_1 = load(new_data.dict_all_card_s1[AutoloadData.cardSet_player[0]]["icon"])
	var get_icon_2 = load(new_data.dict_all_card_s1[AutoloadData.cardSet_player[1]]["icon"])
	var get_icon_3 = load(new_data.dict_all_card_s1[AutoloadData.cardSet_player[2]]["icon"])
	setDeck_icon_current.texture = get_icon_current
	
	var all_icon = [get_icon_1, get_icon_2, get_icon_3]
	for i in range(setDeck_icon.size()):
		setDeck_icon[i].texture = all_icon[i]
		btn_setDeck[i].disabled = code in AutoloadData.cardSet_player

func onready_prosedural_deck():
	var card_total = AutoloadData.player_cardCollection.size()
	for i in range(card_total):
		var get_code = AutoloadData.player_cardCollection[i]
		prosedural_deck(get_code)
func prosedural_deck_isenabled(_bool:bool, _node):
	_node.visible = _bool
	
func prosedural_deck_current(code):
	current_deck_select = code
	pick_deck(code)

func get_pct(value, pct):
	return (value * pct) / 100
func set_pct(value_ask, target_to_pct):
	if target_to_pct == 0:
		return 0
	return int((float(value_ask) / target_to_pct) * 100)

func prosedural_deck(code):
	var new_data = Card_data_s1.new()
	
	var new_card:Button = prosedural_deck_gen.duplicate()
	var card_icon = load(new_data.dict_all_card_s1[code]["icon"])
	var label_name:Label = new_card.get_node("indic/VBoxContainer/card_name")
	var label_class:Label = new_card.get_node("indic/VBoxContainer/card_class")
	var sprite_star:Sprite2D = new_card.get_node("indic/VBoxContainer/PanelContainer/card_star")
	var card_name = new_data.dict_all_card_s1[code]["name"]
	var card_rank = new_data.dict_all_card_s1[code]["rank"]
	var card_class = new_data.dict_all_card_s1[code]["job"]
	var get_indic = new_card.get_node("indic")
	
	var set_class_name
	match card_class:
		0:set_class_name="WARRIOR"
		1:set_class_name="ARCHER"
		2:set_class_name="DEFENDER"
		3:set_class_name="ASSASIN"
		4:set_class_name="SUPPORT"
		5:set_class_name="MECHA"
		6:set_class_name="BEAST"
		7:set_class_name="MAGE"
		8:set_class_name="HEALER"
	
	new_card.connect("mouse_entered", prosedural_deck_isenabled.bind(true, get_indic))
	new_card.connect("mouse_exited", prosedural_deck_isenabled.bind(false, get_indic))
	#new_card.connect("pressed", func(): current_deck_select = code)
	new_card.connect("pressed", prosedural_deck_current.bind(code))
	
	label_class.text = set_class_name
	new_card.icon = card_icon
	label_name.text = card_name
	sprite_star.frame = card_rank
	new_card.show()
	prosedural_deck_parent.add_child(new_card)
	
# ___________________PROSEDURAL DECK LIST FILTER______________________
@onready var theme_pnlCon_enabled = preload("res://Themes/NEW THEME 2/deck/panelContainer_enabled.tres")
@onready var theme_pnlCon_disabled = preload("res://Themes/NEW THEME 2/deck/panelContainer_disabled.tres")
@onready var arr_panel_filter = [
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_obtained,
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_star,
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_element,
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_class]
@onready var btn_filter = [
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_obtained/btn_fiterobtained,
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_star/btn_filter_star,
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_element/btn_filter_element,
	$lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/filter/panel_filter_class/btn_filter_class]

var deck_filter_obtained = {"_bool":false}
var deck_filter_star = {"_bool":false}
var deck_filter_element = {"_bool":false}
var deck_filter_class = {"_bool":false}

func onready_filter_deck():
	for i in range(btn_filter.size()):
		btn_filter[i].connect("pressed", filter_deck.bind(i))
func filter_deck(code):
	var all_bool = [deck_filter_obtained, deck_filter_star, deck_filter_element, deck_filter_class]
	for i in range(all_bool.size()):
		all_bool[i]["_bool"] = (code==i)
		if all_bool[i]["_bool"]==true: arr_panel_filter[i].theme = theme_pnlCon_enabled
		elif all_bool[i]["_bool"]==false: arr_panel_filter[i].theme = theme_pnlCon_disabled
# ---------------------------------------------------------------------------------

# ---------------------------------------FILER CARD------------------------------------------
@onready var btn_deck_sort:Button = $lobby_deck_final/PanelContainer/VBoxContainer/main_panel_deck_sort/VBoxContainer/HBoxContainer/btn_deck_sort
var arr_filter_card = []
func filter_deck_card(code):
	var new_data = Card_data_s1.new()
	
	var card_star = new_data.dict_all_card_s1[code]["rank"] # 0-5
	var card_elem = new_data.dict_all_card_s1[code]["elem"] # 0-4
	var card_class = new_data.dict_all_card_s1[code]["job"] # 0-8
	
	var _sort_star = [sort_star_1_enable, sort_star_2_enable, sort_star_3_enable, sort_star_4_enable, sort_star_5_enable, sort_star_6_enable]
	var _sort_elem = [sort_elem_light_enable ,sort_elem_nature_enable ,sort_elem_water_enable , sort_elem_dark_enable , sort_elem_fire_enable]
	var _sort_class = [sort_class_war_enable,sort_class_arc_enable,sort_class_def_enable,sort_class_assa_enable,sort_class_supp_enable,sort_class_mech_enable,
		sort_class_beast_enable,sort_class_wiz_enable,sort_class_heal_enable]
		
	var star_confirm = _sort_star[card_star]["_bool"]
	var elem_confirm = _sort_elem[card_elem]["_bool"]
	var class_confirm = _sort_class[card_class]["_bool"]
	
	if star_confirm==true and elem_confirm==true and class_confirm==true:
		arr_filter_card.append(code)
		
func new_deck_filter():
	btn_deck_sort.disabled = true
	var new_data = Card_data_s1.new()
	arr_filter_card.clear()
	for i in range(1, prosedural_deck_parent.get_child_count()):
		var child = prosedural_deck_parent.get_child(i)
		child.queue_free()
		
	var all_card = AutoloadData.player_cardCollection.duplicate()
	for i in range(all_card.size()):
		filter_deck_card(all_card[i])
	
	var filter = [deck_filter_obtained ,deck_filter_star ,deck_filter_element ,deck_filter_class]
	
	if filter[0]["_bool"]==true:pass
	elif filter[1]["_bool"]:
		var arr_star = [ [],[],[],[],[],[] ]
		for i in range(arr_filter_card.size()):
			var get_star = new_data.dict_all_card_s1[arr_filter_card[i]]["rank"]
			match get_star:
				0:arr_star[0].append(arr_filter_card[i])
				1:arr_star[1].append(arr_filter_card[i])
				2:arr_star[2].append(arr_filter_card[i])
				3:arr_star[3].append(arr_filter_card[i])
				4:arr_star[4].append(arr_filter_card[i])
				5:arr_star[5].append(arr_filter_card[i])
		var new_arr = []
		for i in arr_star:
			new_arr += i
		arr_filter_card.clear()
		arr_filter_card = new_arr.duplicate()
	elif filter[2]["_bool"]:
		var arr_elem = [ [],[],[],[],[] ]
		for i in range(arr_filter_card.size()):
			var get_elem = new_data.dict_all_card_s1[arr_filter_card[i]]["elem"]
			match get_elem:
				0:arr_elem[0].append(arr_filter_card[i])
				1:arr_elem[1].append(arr_filter_card[i])
				2:arr_elem[2].append(arr_filter_card[i])
				3:arr_elem[3].append(arr_filter_card[i])
				4:arr_elem[4].append(arr_filter_card[i])
		var new_arr = []
		for i in arr_elem:
			new_arr += i
		arr_filter_card.clear()
		arr_filter_card = new_arr.duplicate()
	elif filter[3]["_bool"]:
		var arr_class = [ [],[],[],[],[],[],[],[],[] ]
		for i in range(arr_filter_card.size()):
			var get_elem = new_data.dict_all_card_s1[arr_filter_card[i]]["job"]
			match get_elem:
				0:arr_class[0].append(arr_filter_card[i])
				1:arr_class[1].append(arr_filter_card[i])
				2:arr_class[2].append(arr_filter_card[i])
				3:arr_class[3].append(arr_filter_card[i])
				4:arr_class[4].append(arr_filter_card[i])
				5:arr_class[5].append(arr_filter_card[i])
				6:arr_class[6].append(arr_filter_card[i])
				7:arr_class[7].append(arr_filter_card[i])
				8:arr_class[8].append(arr_filter_card[i])
		var new_arr = []
		for i in arr_class:
			new_arr += i
		arr_filter_card.clear()
		arr_filter_card = new_arr.duplicate()
	
	for i in arr_filter_card:
		prosedural_deck(i)
		await get_tree().create_timer(.03).timeout
	btn_deck_sort.disabled = false
	
func _on_btn_deck_sort_pressed() -> void:
	new_deck_filter()
# ------------------------------------------------------------------------------

# ------------------------------- MOVES SCENE -------------------------------------
func _on_btn_attack_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main_loading_screen.tscn")
	AutoloadData.scene_data = "res://scenes/Battle_scene.tscn"
	get_tree().change_scene_to_file("res://scenes/new_loading_screen.tscn")
	#NewLoadingScreen.goto_scene_battle()
# ------------------------------------------------------------------------------

# ------------------------------- REDEEM -------------------------------------
@onready var label_redeem_gen:Label = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer/redeem_gen_id
@onready var btn_redeem_gen:Button = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/HBoxContainer/btn_redeem_gen
@onready var btn_redeem_copy:Button = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/HBoxContainer/btn_redeem_copy
@onready var type_redeem_code:LineEdit = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/VBoxContainer/type_redeem_code
@onready var btn_redeem_enter_code:Button = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/VBoxContainer/Button2

@onready var label_redeem_status_code:Label = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/status
@onready var label_redeem_id:Label = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/id
@onready var label_redeem_pwd:Label = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/pwd
@onready var label_redeem_used:Label = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/used

func autoload_redeem_history():
	var get_loop_assign = AutoloadData.redeem_assign_history.size()
	if get_loop_assign != 0:
		for i in range(get_loop_assign):
			new_prosedural_assign_later(true, i)
			
	var get_loop = AutoloadData.redeem_code_history.size()
	if get_loop !=0:
		for i in range(get_loop):
			var get_id = AutoloadData.redeem_code_history[i]
			var get_pwd = AutoloadData.redeem_pwd_history[i]
			new_redeem_history(get_id, get_pwd)
	redeem_history_set_loop_num()

func onready_redeem():
	btn_redeem_gen.connect("pressed", set_redeem_code_id)
	btn_redeem_copy.connect("pressed", func():DisplayServer.clipboard_set(str(label_redeem_gen.text)))
	btn_redeem_enter_code.connect("pressed",get_redeem_code_pwd)
func set_redeem_code_id():
	var set_redeem_id = RedeemCodeGenerator.generate_id()
	label_redeem_id.text = str("ID:-")
	label_redeem_pwd.text = str("CODE:-")
	label_redeem_status_code.text = "STATUS CODE: WAITING INPUT"
	label_redeem_used.text = ("USED:-")
	label_redeem_gen.text = set_redeem_id
	print(str(
		"PW 1: ",RedeemCodeGenerator.generate_passwords(set_redeem_id)[0],
		"PW 2: ",RedeemCodeGenerator.generate_passwords(set_redeem_id)[1]
	))
var redeem_fail_count:int = 0
var redeem_fail_bool = false
func get_redeem_code_pwd():
	var get_confirm = RedeemCodeGenerator.confirm_password(str(label_redeem_gen.text), str(type_redeem_code.text))
	label_redeem_id.text = str("ID: ",label_redeem_gen.text)
	label_redeem_pwd.text = str("CODE: ",type_redeem_code.text)
	if get_confirm:
		label_redeem_status_code.text = "STATUS CODE: APPROVED"
		var code_confirm = str(label_redeem_gen.text)
		var pwd_confirm = str(type_redeem_code.text)
		if code_confirm in AutoloadData.redeem_code_history:
			label_redeem_used.text = ("USED: SORY, CODE ALREADY USED !")
			set_notification(ENUM_SET_NOTIF.ORANGE, "Expired code")
		else:
			label_redeem_gen.text = ""
			type_redeem_code.text = ""
			autoload_player_super_ticket()
			AutoloadData.redeem_code_history.append(code_confirm)
			AutoloadData.redeem_pwd_history.append(pwd_confirm)
			new_redeem_history(code_confirm, pwd_confirm)
			if AutoloadData.redeem_assign_history.has(code_confirm):
				var get_node_to_del = parent_new_redeem_hitory.get_node(code_confirm)
				var _get_index = AutoloadData.redeem_assign_history.find(code_confirm)
				get_node_to_del.queue_free()
				AutoloadData.redeem_assign_history.remove_at(_get_index)
			AutoloadData.save_data()
			label_redeem_used.text = ("USED: 1000x Super Ticked CLAIMED !")
			set_notification(ENUM_SET_NOTIF.BLUE, "1000x Super Ticket")
			redeem_history_set_loop_num()
	else:
		redeem_fail_count+=1
		const max_fail = 7
		var limit_fail = clamp(redeem_fail_count,0, max_fail)
		var set_notice =""
		match limit_fail:
			max_fail:
				set_notice ="Get free code in Community setting"
				redeem_fail_count=0
				redeem_fail_bool = true
			_: set_notice = "Redeem ERROR !"
		label_redeem_status_code.text = "STATUS CODE: ERROR"
		label_redeem_used.text = ("USED:-")
		set_notification(ENUM_SET_NOTIF.RED, set_notice)
		
@onready var panel_history_redeem = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/panel_history
@onready var parent_new_redeem_hitory = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/panel_history/VBoxContainer/VBoxContainer/ScrollContainer/parent_redeem_history
@onready var prosedural_new_redeem_history:PanelContainer = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/panel_history/VBoxContainer/VBoxContainer/ScrollContainer/parent_redeem_history/prosedural_history
@onready var prosedural_new_redeem_assign:PanelContainer = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/reedem/VBoxContainer/PanelContainer2/VBoxContainer/panel_history/VBoxContainer/VBoxContainer/ScrollContainer/parent_redeem_history/prosedural_assign_later

func new_redeem_history(id, code):
	var new_history:PanelContainer = prosedural_new_redeem_history.duplicate()
	var _parent = new_history.get_node("_parent")
	#var get_num:Label = _parent.get_node("num")
	var get_id:Button = _parent.get_node("btn_id_copy")
	var get_pwd:Button = _parent.get_node("btn_pwd_copy")
	var set_id = str("ID: ",id)
	var set_pwd = str("PWD: ",code)
	#get_num.text = str(num)
	get_id.text = set_id
	get_pwd.text = set_pwd
	get_id.connect("pressed", func():
		DisplayServer.clipboard_set(id)
		SfxManager.play_click()
		set_notification(ENUM_SET_NOTIF.BLUE, "copied"))
	get_pwd.connect("pressed", func():
		SfxManager.play_click()
		DisplayServer.clipboard_set(code)
		set_notification(ENUM_SET_NOTIF.BLUE, "copied"))
	new_history.show()
	parent_new_redeem_hitory.add_child(new_history)

func redeem_history_set_loop_num():
	await get_tree().create_timer(.05).timeout
	var index = 1
	for i in range(2, parent_new_redeem_hitory.get_child_count()):
		parent_new_redeem_hitory.get_child(i).get_child(0).get_child(0).text = str(index)
		index += 1

func scroll_redeem_panel(scroll_to_top: bool):
	var scroll_container: ScrollContainer = arr_panel_setting[2]
	var target_position: int = 0
	if not scroll_to_top:
		target_position = int(round(scroll_container.get_v_scroll_bar().max_value))
	var tween = create_tween()
	tween.tween_method(func(val): scroll_container.scroll_vertical = int(round(val)),scroll_container.scroll_vertical,target_position,0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func new_prosedural_assign_later(for_looping:bool, _index):
	var new_id
	if for_looping:
		new_id = AutoloadData.redeem_assign_history[_index]
	else:
		new_id = RedeemCodeGenerator.generate_id()
		AutoloadData.redeem_assign_history.append(new_id) # hanya tambah saat data baru

	var new_assign_later = prosedural_new_redeem_assign.duplicate()
	new_assign_later.name = new_id
	# ----------------------
	var parent = new_assign_later.get_node("_parent")
	var get_btn_copy:Button = parent.get_node("btn_id_copy")
	var get_btn_assign:Button = parent.get_node("btn_assign")
	var get_btn_del:Button = parent.get_node("btn_del")

	get_btn_copy.text = new_id

	# Debug dan connect untuk btn_copy
	#print("DEBUG: btn_copy current connections: ", get_btn_copy.pressed.get_connections().size())
	if get_btn_copy.pressed.get_connections().size() == 0:
		#print("DEBUG: Connecting btn_copy 'pressed' signal...")
		get_btn_copy.pressed.connect(func():
			#print("DEBUG: Copy button pressed for ID: ", new_id)
			SfxManager.play_click()
			DisplayServer.clipboard_set(new_id)
			set_notification(ENUM_SET_NOTIF.BLUE, "copied"))
	else:
		print("DEBUG: btn_copy already has connections, skipping...")

	# Debug dan connect untuk btn_assign
	#print("DEBUG: btn_assign current connections: ", get_btn_assign.pressed.get_connections().size())
	if get_btn_assign.pressed.get_connections().size() == 0:
		#print("DEBUG: Connecting btn_assign 'pressed' signal...")
		get_btn_assign.pressed.connect(func():
			print("DEBUG: Assign button pressed for ID: ", new_id)
			SfxManager.play_click()
			label_redeem_gen.text = new_id
			scroll_redeem_panel(true))
	else:
		print("DEBUG: btn_assign already has connections, skipping...")

	# Debug dan connect untuk btn_del
	#print("DEBUG: btn_del current connections: ", get_btn_del.pressed.get_connections().size())
	if get_btn_del.pressed.get_connections().size() == 0:
		#print("DEBUG: Connecting btn_del 'pressed' signal...")
		get_btn_del.pressed.connect(func():
			#print("DEBUG: Delete button pressed for ID: ", new_id)
			var _get_index = AutoloadData.redeem_assign_history.find(new_id)
			#print("DEBUG: Found index: ", _get_index)
			
			if _get_index != -1:
				AutoloadData.redeem_assign_history.remove_at(_get_index)
				#print("DEBUG: Removed ID from history at index: ", _get_index)
				await AutoloadData.save_data()
				new_assign_later.queue_free()
				redeem_history_set_loop_num()
				#print("DEBUG: Delete operation completed")
			else:
				print("DEBUG: ID not found in history: ", new_id))
	else:
		print("DEBUG: btn_del already has connections, skipping...")
	
	AutoloadData.save_data()
	new_assign_later.show()
	parent_new_redeem_hitory.add_child(new_assign_later)
	redeem_history_set_loop_num()
	
	var get_pwd = RedeemCodeGenerator.generate_passwords(new_id)
	print(str(
		"PW 1: ", get_pwd[0], "\n",
		"PW 2: ", get_pwd[1],
	))
	
var is_redeem_history_open = false
func redeem_show_history():
	if panel_history_redeem == null: return
	var target_y := 0 if is_redeem_history_open else 500
	var target_size := Vector2(panel_history_redeem.custom_minimum_size.x,target_y)
	var tween = create_tween()
	tween.tween_property(panel_history_redeem,"custom_minimum_size",target_size,0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	is_redeem_history_open = !is_redeem_history_open
	
func _on_btn_show_history_pressed() -> void:
	redeem_show_history()
func _on_btn_save_id_pressed() -> void:
	new_prosedural_assign_later(false, 0)
	scroll_redeem_panel(false)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
func _on_button_pressed() -> void: # BUTTON RESET DATA
	AutoloadData.reset_data()
	update_resources_player()
# ------------------------------------------------------------------------------
@onready var prosedural_notification_txt = $prosedural_notification
@onready var theme_notif_red = preload("res://Themes/NEW THEME 2/lobby/notif_label_red.tres")
@onready var arr_theme_notif = [
	preload("res://Themes/NEW THEME 2/lobby/notif_label_red.tres"),
	preload("res://Themes/NEW THEME 2/lobby/notif_label_orange.tres"),
	preload("res://Themes/NEW THEME 2/lobby/notif_label_blue.tres") ]
func set_notification(notif_type:ENUM_SET_NOTIF, txt: String):
	SfxManager.play_popup()
	# Duplikat node label notifikasi
	var notif:Label = prosedural_notification_txt.duplicate()
	var _set_time = 1
	if redeem_fail_bool:
		redeem_fail_bool = false
		_set_time = 7
	notif.theme = arr_theme_notif[notif_type]
	notif.text = txt
	notif.visible = true
	add_child(notif)

	# Posisi awal dan akhir
	var start_pos = notif.position
	var end_pos = start_pos + Vector2(0, -120)

	# Tween animasi
	var tween = create_tween()
	tween.tween_property(notif, "position", end_pos, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_interval(float(_set_time)) # Diam selama 1 detik
	tween.tween_property(notif, "modulate:a", 0.0, 0.5).set_trans(Tween.TRANS_LINEAR)

	# Hapus setelah selesai
	tween.tween_callback(Callable(notif, "queue_free"))
	
# -----------------------------------CARD BTN MAIN-------------------------------------------
@onready var card_parent = $lobby_card
@onready var arr_pnl_btn_card = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_mycard,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_cardlist,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_inventory,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_gacha]
@onready var arr_btn_main_card = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_mycard/btn_mycard,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_cardlist/btn_cardlist,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_inventory/btn_inventory,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer/pnl_gacha/btn_gacha]

@onready var main_parent_card:Button = $lobby_card
@onready var btn_cls_card:Button = $lobby_card/PanelContainer/VBoxContainer/btn_cls
@onready var theme_pnl_btn_main:Theme = preload("res://Themes/NEW THEME 2/lobby/PNL_BTN_BLUE.tres")

func show_card(_bool:bool): $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox.visible = _bool
func show_inventory(_bool:bool): $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory.visible = _bool

func _set_pnl_theme(_index):
	current_btn_card_seledted = _index
	for i in range(arr_pnl_btn_card.size()):
		if i==_index:
			arr_pnl_btn_card[i].theme = theme_pnl_btn_main
			arr_btn_main_card[i].disabled = false
		else:
			arr_pnl_btn_card[i].theme = null
			arr_btn_main_card[i].disabled = true
var current_btn_card_seledted = 0
func onready_btn_card():
	main_parent_card.connect("pressed", func():
		SfxManager.play_click()
		main_parent_card.hide())
	btn_cls_card.connect("pressed", func():
		SfxManager.play_click()
		update_resources_player()
		main_parent_card.hide())
	for i in range(arr_btn_main_card.size()):
		var btn:Button = arr_btn_main_card[i]
		btn.connect("pressed", _set_pnl_theme.bind(i))
		btn.connect("mouse_entered", func(): btn.disabled = false)
		btn.connect("mouse_exited", func(): btn.disabled = i!=current_btn_card_seledted)
		match i:
			0: arr_btn_main_card[i].connect("pressed", on_mycard_pressed)
			1: arr_btn_main_card[i].connect("pressed", on_cardlist_pressed)
			2: arr_btn_main_card[i].connect("pressed", on_inventory_pressed)
			3: arr_btn_main_card[i].connect("pressed", on_gacha_pressed)

var cm_current_btn = 0
var local_card_inspect_bool = true
func on_mycard_pressed():
	SfxManager.play_click()
	local_card_inspect_bool = true
	show_card(true)
	show_inventory(false)
	cm_menu_card = ENUM_CARD_MENU.MY_CARD
	if cm_current_btn != ENUM_CARD_MENU.MY_CARD:
		cm_filter_main()
		cm_current_btn = cm_menu_card
func on_cardlist_pressed():
	SfxManager.play_click()
	local_card_inspect_bool = false
	show_card(true)
	show_inventory(false)
	cm_menu_card = ENUM_CARD_MENU.ALL_CARD
	if cm_current_btn != ENUM_CARD_MENU.ALL_CARD:
		cm_filter_main()
		cm_current_btn = cm_menu_card
func on_inventory_pressed():
	SfxManager.play_click()
	show_card(false)
	show_inventory(true)
func on_gacha_pressed():
	SfxManager.play_click()
	show_card(false)
	show_inventory(false)

# -----------------------------------CARD MANAGER BTN-------------------------------------------
@onready var new_load_img = Load_images.new()
@onready var cm_theme_btn_switch = preload("res://Themes/THEME V3/PNL_FOR_SWITCH_BLUE.tres")
@onready var cm_theme_pnl_switch_off = preload("res://Themes/THEME V3/PNL_FOR_SWITCH_OFF.tres")
@onready var cm_btn_sort:Button = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/btn_sort
@onready var cm_btn_star = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_all,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_1,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_2,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_3,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_4,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_5,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_sar/hbox/star_6]
@onready var cm_btn_elem = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_elem/hbox/elem_all,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_elem/hbox/elem_light,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_elem/hbox/elem_nature,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_elem/hbox/elem_water,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_elem/hbox/elem_dark,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_elem/hbox/elem_fire]
@onready var cm_btn_class = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_all,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_war,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_arc,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_def,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_assa,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_supp,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_mech,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_beast,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_mage,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_sort/pnl_class/hbox/class_heal]
@onready var cm_btn_filter = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_obtain/btn_obtain,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_star/btn_star,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_elem/btn_elem,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_class/btn_class]
@onready var cm_pnl_filter = [
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_obtain,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_star,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_elem,
	$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/pnl_switch/hbox/pnl_class]

var cm_bool_star:Dictionary = {0:true, 1:true, 2:true, 3:true, 4:true, 5:true, 6:true}
var cm_bool_elem:Dictionary = {0:true, 1:true, 2:true, 3:true, 4:true, 5:true}
var cm_bool_class:Dictionary = {0:true, 1:true, 2:true, 3:true, 4:true, 5:true, 6:true, 7:true, 8:true, 9:true}
var cm_bool_filter:Dictionary = {0:true, 1:false, 2:false, 3:false}

func _on_cm_filter_select(code):
	for i in range(4):
		cm_bool_filter[i] = (code==i)
		var pnl_container:PanelContainer = cm_pnl_filter[i]
		if cm_bool_filter[i]: pnl_container.theme = cm_theme_btn_switch
		else: pnl_container.theme = cm_theme_pnl_switch_off
func _cm_check_allfalse(dict: Dictionary):
	var keys = dict.keys()
	keys.erase(0)  # Buang key pertama (key 0)
	var true_count = 0
	for key in keys:
		if dict[key] == true:
			true_count += 1
	var total = keys.size()
	if true_count == total:
		return false
	elif true_count == 0:
		return true
	else: return null
func onready_btn_cardManager():
	for i in range(cm_btn_star.size()):
		var btn:Button = cm_btn_star[i]
		btn.connect("pressed", func():
			SfxManager.play_click()
			if i!=0:
				cm_bool_star[i] = !cm_bool_star[i]
				btn.icon = new_load_img.img_star[i][cm_bool_star[i]]
				if _cm_check_allfalse(cm_bool_star):
					cm_bool_star[0]=false
					cm_btn_star[0].icon = new_load_img.img_star[0][cm_bool_star[0]]
				elif _cm_check_allfalse(cm_bool_star) == false:
					cm_bool_star[0]=true
					cm_btn_star[0].icon = new_load_img.img_star[0][cm_bool_star[0]]
			else:
				cm_bool_star[0]=!cm_bool_star[0]
				for ii in range(cm_bool_star.size()):
					cm_bool_star[ii]=cm_bool_star[0]
					cm_btn_star[ii].icon = new_load_img.img_star[ii][cm_bool_star[ii]])
		var indic = cm_btn_star[i].get_node("indic")
		btn.connect("mouse_entered", func(): indic.show())
		btn.connect("mouse_exited", func(): indic.hide())
	for i in range(cm_btn_elem.size()):
		var btn:Button = cm_btn_elem[i]
		btn.connect("pressed", func():
			SfxManager.play_click()
			if i!=0:
				cm_bool_elem[i] = !cm_bool_elem[i]
				btn.icon = new_load_img.img_elemen[i][cm_bool_elem[i]]
				if _cm_check_allfalse(cm_bool_elem):
					cm_bool_elem[0]=false
					cm_btn_elem[0].icon = new_load_img.img_elemen[0][cm_bool_elem[0]]
				elif _cm_check_allfalse(cm_bool_elem) == false:
					cm_bool_elem[0]=true
					cm_btn_elem[0].icon = new_load_img.img_elemen[0][cm_bool_elem[0]]
			else:
				cm_bool_elem[i]=!cm_bool_elem[i]
				for ii in range(cm_bool_elem.size()):
					cm_bool_elem[ii]=cm_bool_elem[0]
					cm_btn_elem[ii].icon = new_load_img.img_elemen[ii][cm_bool_elem[ii]])
		var indic = cm_btn_elem[i].get_node("indic")
		btn.connect("mouse_entered", func(): indic.show())
		btn.connect("mouse_exited", func(): indic.hide())
	for i in range(cm_btn_class.size()):
		var btn:Button = cm_btn_class[i]
		btn.connect("pressed", func():
			SfxManager.play_click()
			if i !=0:
				cm_bool_class[i] = !cm_bool_class[i]
				btn.icon = new_load_img.img_class[i][cm_bool_class[i]]
				if _cm_check_allfalse(cm_bool_class):
					cm_bool_class[0]=false
					cm_btn_class[0].icon = new_load_img.img_class[0][cm_bool_class[0]]
				elif _cm_check_allfalse(cm_bool_class)==false:
					cm_bool_class[0]=true
					cm_btn_class[0].icon = new_load_img.img_class[0][cm_bool_class[0]]
			else:
				cm_bool_class[i]=!cm_bool_class[i]
				for ii in range(cm_bool_class.size()):
					cm_bool_class[ii]=cm_bool_class[0]
					cm_btn_class[ii].icon = new_load_img.img_class[ii][cm_bool_class[ii]])
		var indic = cm_btn_class[i].get_node("indic")
		btn.connect("mouse_entered", func(): indic.show())
		btn.connect("mouse_exited", func(): indic.hide())
	for i in range(cm_btn_filter.size()):
		var btn:Button = cm_btn_filter[i]
		btn.connect("pressed", func():
			SfxManager.play_click()
			_on_cm_filter_select(i))
	cm_btn_sort.connect("pressed", cm_filter_main)
# ---------------------------------- CARD MANAGER FILTER ----------------------------------------
var cm_arr_main:Array = []
func cm_filter_raw(code):
	var new_data = Card_data_s1.new()
	var get_star = new_data.dict_all_card_s1[code]["rank"]+1
	var get_elem = new_data.dict_all_card_s1[code]["elem"]+1
	var _get_class = new_data.dict_all_card_s1[code]["job"]+1
	
	var confirm_star = false
	if cm_bool_star[get_star]:confirm_star = true
	var confirm_elem = false
	if cm_bool_elem[get_elem]:confirm_elem = true
	var confirm_class = false
	if cm_bool_class[_get_class]:confirm_class = true
	
	if confirm_class and confirm_elem and confirm_star: cm_arr_main.append(code)

@onready var cm_parent_prosedural_card = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_main/VBoxContainer2/VBoxContainer/grid_parent
@onready var cm_main_prosedural_card = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_main/VBoxContainer2/VBoxContainer/grid_parent/prosedural_card
@onready var cm_page:Label = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/vbox/hbox_main/VBoxContainer2/VBoxContainer/PanelContainer/hbox/PanelContainer/page_indic
@onready var cm_pnl_loading = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/pnl_cm_loading
@onready var cm_pnl_btn_parent = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_btn/VBoxContainer
enum ENUM_CARD_MENU{MY_CARD, ALL_CARD}
var cm_menu_card:ENUM_CARD_MENU = ENUM_CARD_MENU.MY_CARD
var cm_total_card = 0
var cm_total_page = 1
var cm_current_page = 1
func cm_filter_main():
	cm_total_card = 0
	cm_total_page = 1
	cm_current_page = 1
	
	cm_pnl_loading.show()
	cm_pnl_btn_parent.hide()
	cm_btn_sort.disabled = true
	
	var children = cm_parent_prosedural_card.get_children()

	for i in range(1, children.size()): # Mulai dari index ke-1, jadi anak pertama aman
		cm_parent_prosedural_card.remove_child(children[i])
		children[i].queue_free()
	
	var new_data = Card_data_s1.new()
	cm_arr_main.clear()
	var new_arr_card:Array = []
	if cm_menu_card == ENUM_CARD_MENU.MY_CARD: new_arr_card = AutoloadData.player_cardCollection.duplicate()
	elif cm_menu_card == ENUM_CARD_MENU.ALL_CARD: new_arr_card = AutoloadData.system_cardCollection.duplicate()
	
	for i in new_arr_card: cm_filter_raw(i)
	if cm_arr_main.is_empty() == false:
		new_arr_card = cm_arr_main.duplicate()
		cm_arr_main.clear()
		var get_filter
		for i in range(cm_bool_filter.size()):
			if cm_bool_filter[i]: get_filter = i
		
		match get_filter:
			1:
				var star_1:Array = []
				var star_2:Array = []
				var star_3:Array = []
				var star_4:Array = []
				var star_5:Array = []
				var star_6:Array = []
				for i in new_arr_card:
					var _get_star = new_data.dict_all_card_s1[i]["rank"]
					match _get_star:
						0: star_1.append(i)
						1: star_2.append(i)
						2: star_3.append(i)
						3: star_4.append(i)
						4: star_5.append(i)
						5: star_6.append(i)
				new_arr_card.clear()
				new_arr_card.append_array(star_1)
				new_arr_card.append_array(star_2)
				new_arr_card.append_array(star_3)
				new_arr_card.append_array(star_4)
				new_arr_card.append_array(star_5)
				new_arr_card.append_array(star_6)
			2:
				var elem_light:Array = []
				var elem_nature:Array = []
				var elem_water:Array = []
				var elem_dark:Array = []
				var elem_fire:Array = []
				for i in new_arr_card:
					var _get_elem = new_data.dict_all_card_s1[i]["elem"]
					match _get_elem:
						0: elem_light.append(i)
						1: elem_nature.append(i)
						2: elem_water.append(i)
						3: elem_dark.append(i)
						4: elem_fire.append(i)
				new_arr_card.clear()
				new_arr_card.append_array(elem_light)
				new_arr_card.append_array(elem_nature)
				new_arr_card.append_array(elem_water)
				new_arr_card.append_array(elem_dark)
				new_arr_card.append_array(elem_fire)
			3:
				var class_warrior:Array = []
				var class_arc:Array = []
				var class_defender:Array = []
				var class_assa:Array = []
				var class_supp:Array = []
				var class_mecha:Array = []
				var class_beast:Array = []
				var class_wizard:Array = []
				var class_healer:Array = []
				for i in new_arr_card:
					var _get_class = new_data.dict_all_card_s1[i]["job"]
					match _get_class:
						0:class_warrior.append(i)
						1:class_arc.append(i)
						2:class_defender.append(i)
						3:class_assa.append(i)
						4:class_supp.append(i)
						5:class_mecha.append(i)
						6:class_beast.append(i)
						7:class_wizard.append(i)
						8:class_healer.append(i)
				new_arr_card.clear()
				new_arr_card.append_array(class_warrior)
				new_arr_card.append_array(class_arc)
				new_arr_card.append_array(class_defender)
				new_arr_card.append_array(class_assa)
				new_arr_card.append_array(class_supp)
				new_arr_card.append_array(class_mecha)
				new_arr_card.append_array(class_beast)
				new_arr_card.append_array(class_wizard)
				new_arr_card.append_array(class_healer)
					
		cm_total_card = new_arr_card.size()
		var card_num = 0
		var page_count = 0
		for i in new_arr_card:
			card_num += 1
			page_count += 1
			if page_count == 33:
				page_count = 0
				cm_total_page += 1
			var new_card:Button = cm_main_prosedural_card.duplicate()
			
			var add_string 
			if card_num <10: add_string = "00"
			elif card_num <99: add_string = "0"
			new_card.name = str("card_",add_string,card_num)
			
			if card_num >36:new_card.hide()
			else: new_card.show()
			
			new_card.icon = load(new_data.dict_all_card_s1[i]["icon"])
			var indic:PanelContainer = new_card.get_node("indic")
			var get_sprite_star:Sprite2D = new_card.get_node("indic/VBoxContainer/PanelContainer/card_star")
			var get_txt_name:Label = new_card.get_node("indic/VBoxContainer/card_name")
			var get_txt_class:Label = new_card.get_node("indic/VBoxContainer/card_class")
			get_sprite_star.frame = new_data.dict_all_card_s1[i]["rank"]
			get_txt_name.text = new_data.dict_all_card_s1[i]["name"]
			var get_class_card = new_data.dict_all_card_s1[i]["job"]
			var arr_class = ["WARRIOR", "ARCHER", "KNIGHT", "ASSASIN", "SUPPORT", "MECHA", "BEAST", "WIZARD", "HEALER"]
			get_txt_class.text = arr_class[get_class_card]
			new_card.connect("mouse_entered", func():indic.show())
			new_card.connect("mouse_exited", func():indic.hide())
			new_card.connect("pressed", set_prosedural_card_inspect.bind(i, local_card_inspect_bool))
			cm_parent_prosedural_card.add_child(new_card)
			await get_tree().create_timer(.01).timeout
	cm_pnl_loading.hide()
	cm_pnl_btn_parent.show()
	cm_btn_sort.disabled = false
	cm_page.text = str(cm_current_page)
	
func cm_update_card_visibility():
	var start_index = (cm_current_page - 1) * 36 + 1
	var end_index = min(cm_current_page * 36, cm_total_card)

	for i in range(1, cm_total_card + 1):
		var card_name = "card_%03d" % i
		var card_node = cm_parent_prosedural_card.get_node_or_null(card_name)
		if card_node:
			if i >= start_index and i <= end_index:
				card_node.show()
			else:
				card_node.hide()

func cm_next_page():
	if cm_current_page < cm_total_page:
		cm_current_page += 1
		cm_page.text = str(cm_current_page)
		cm_update_card_visibility()

func cm_previous_page():
	if cm_current_page > 1:
		cm_current_page -= 1
		cm_page.text = str(cm_current_page)
		cm_update_card_visibility()
func _on_btn_prev_pressed() -> void:
	cm_previous_page()
	SfxManager.play_click()
func _on_btn_next_pressed() -> void:
	cm_next_page()
	SfxManager.play_click()
# -------------------------------------------------------------------------------------------------
# ----------------------------------- BTN CHAPER ANIM:START -------------------------------------------
@onready var bg_story:TextureRect = $ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/bg_story
@onready var btn_chapter = {
	1:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer/bab_1,
	2:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer2/bab_2,
	3:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer3/bab_3,
	4:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer4/bab_4,
	5:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer5/bab_5,
	6:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer6/bab_6,
	7:$ui_currency2/VBoxContainer/HBoxContainer/VBoxContainer/PanelContainer/ScrollContainer/main_bab/VBoxContainer7/bab_7}
var code_stage = 1
func get_random_int(min_val: int, max_val: int) -> int:
	return randi_range(min_val, max_val)
func animate_chapter_size(selected: int) -> void:
	var tween = get_tree().create_tween()
	var rng_img = get_random_int(1, 14)
	var new_img = Load_images.new()
	
	if code_stage != selected: 
		var img = new_img.img_bab[selected][rng_img]
		if img == null: bg_story.texture = null
		else: bg_story.texture = load(img)
	code_stage = selected
	
	# Set parallel mode untuk menjalankan semua tween secara bersamaan
	tween.set_parallel(true)
	
	for i in btn_chapter.keys():
		var target_size = Vector2(200, 200)
		if i == selected:
			target_size = Vector2(350, 350)
		
		var node = btn_chapter[i]
		tween.tween_property(node, "custom_minimum_size", target_size, 0.2)
	
	# Set parallel mode kembali ke false setelah selesai (opsional)
	tween.set_parallel(false)
# ----------------------------------- BTN CHAPER ANIM:END -------------------------------------------

#------------------------------------- TIME CHECKER: START ---------------------------------------------
@onready var time_label: Label = $lobby_setting/PanelContainer/VBoxContainer/HBoxContainer/PanelContainer2/ScrollContainer2/VBoxContainer/account/HBoxContainer/time_label


#------------------------------------- TIME CHECKER: END ---------------------------------------------
#------------------------------------- INVENTORY BACKPACK: START ---------------------------------------------
@onready var inven_dict = {
	"name":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/PanelContainer/inven_preview/name,
	"icon":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/PanelContainer/inven_preview/pnlc/icon,
	"type":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/PanelContainer/inven_preview/type,
	"desc":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/PanelContainer/inven_preview/scroll_con/desc,
	"own":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/PanelContainer/inven_preview/own,
	"prosed":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_backpack/ScrollContainer/grid_parent/inven_gen,
	"parent":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_backpack/ScrollContainer/grid_parent,
	
}
func load_all_inven():
	var parent = inven_dict["parent"]
	var child_count = parent.get_child_count()

	# Hapus semua anak kecuali yang pertama (indeks 0)
	for i in range(child_count - 1, 0, -1):
		var child = parent.get_child(i)
		child.queue_free()
	var new_data = Lobby_inventory.new()
	new_data.load_all_inven(inven_dict["name"], inven_dict["icon"], inven_dict["type"], inven_dict["desc"], inven_dict["own"], inven_dict["prosed"], inven_dict["parent"])

@onready var _inven_btn = {
	1:{
		"_bool":false,
		"id_node":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/menu/main_menu/vbox/backpack,
		"action": load_all_inven,
		"item_content":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_backpack
	},
	2:{
		"_bool":false,
		"id_node":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/menu/main_menu/vbox/eq,
		"action": "",
		"item_content" : $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq
	},
	3:{
		"_bool":false,
		"id_node":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/menu/main_menu/vbox/chest,
		"action": "",
		"item_content" : $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_chest
	},"preview":$lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/PanelContainer, }
func onready_btn_inven():
	var inven_data = Lobby_inventory.new()
	inven_data.inven_btn_switch(_inven_btn)
#------------------------------------- INVENTORY BACKPACK: END ---------------------------------------------
#------------------------------------- INVENTORY EQUIPMENTS: START ---------------------------------------------
@onready var inven_eq_parent = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/pnlc_btn/hflow
@onready var _inven_eq_gear_bool = {}
@onready var _inven_eq_grade_bool = {}
@onready var _inven_eq_btn = {}
@onready var inven_eq_grid_parent = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/scrollc/grid_eq
@onready var inven_eq_prosed = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/scrollc/grid_eq/eq_prosed
@onready var inven_eq_btn_handle:Button = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/pnlc_btn/hflow/select_all
var inven_eq_btn_handle_bool = true
@onready var inven_eq_btn_slide:Button = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/PanelContainer/hbox/page_curr
@onready var inven_eq_btn_prev:Button = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/PanelContainer/hbox/prev
@onready var inven_eq_btn_next:Button = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/PanelContainer/hbox/next
@onready var inven_eq_btn_filter:Button = $lobby_card/PanelContainer/VBoxContainer/HBoxContainer/panel_menu/Inventory/content/item_eq/pnlc_btn/hflow/inven_eq_filter

@onready var inspect_eq_pnl = $ui_gear_inspect

func onready_inven_eq_btn():
	var eq_data = Lobby_equipments.new()
	# Handle all btn
	inven_eq_btn_handle.connect("pressed", func():
		inven_eq_btn_handle_bool = eq_data.handle_all_btn(inven_eq_btn_handle_bool, _inven_eq_btn, _inven_eq_gear_bool, _inven_eq_grade_bool)["_bool"]
		inven_eq_btn_handle.icon = load(eq_data.btn_handle[inven_eq_btn_handle_bool]))
	# Inisialisasi bool gear (1–11) dan grade (12–16)
	for i in range(11): _inven_eq_gear_bool[i + 1] = true
	for i in range(5): _inven_eq_grade_bool[i + 12] = true
	# Ambil semua tombol dari parent dan simpan di dict
	var num = 1
	for child in inven_eq_parent.get_children():
		_inven_eq_btn[num] = child
		num += 1
	# Pastikan jumlah tombol cukup
	if _inven_eq_btn.size() < 16:
		push_warning("Jumlah tombol di inven_eq_parent kurang dari 16!")
	# Kirim data ke sistem equipment
	eq_data.set_btn_filter(_inven_eq_btn, _inven_eq_gear_bool, _inven_eq_grade_bool)

var _inven_eq_page_curr = 0
var _inven_eq_page_total = 0
var _inven_eq_page_max = 0
var _inven_eq_item_reminder = 0

func _inven_eq_btn_disabled(_bool: bool) -> void:
	if _bool:
		# Disable sementara hanya jika tombol tersedia
		if !inven_eq_btn_prev.disabled:
			inven_eq_btn_prev.disabled = true
		if !inven_eq_btn_next.disabled:
			inven_eq_btn_next.disabled = true
	else:
		# Enable kembali hanya jika memang ada halaman sebelumnya/selanjutnya
		inven_eq_btn_prev.disabled = (_inven_eq_page_curr <=0)
		inven_eq_btn_next.disabled = (_inven_eq_page_curr+1 >= _inven_eq_page_total)

	inven_eq_btn_filter.disabled = _bool

var _inven_eq_arr:Array = []
var inven_eq_data = Lobby_equipments.new()
@onready var pnl_loading:PanelContainer = $pnl_loading
func _on_inven_eq_filter_pressed() -> void:
	SfxManager.play_click()
	for i in range(inven_eq_grid_parent.get_child_count() - 1, 0, -1):
		inven_eq_grid_parent.get_child(i).queue_free()
		
	_inven_eq_arr.clear()
	_inven_eq_arr =  inven_eq_data.sort_equipments(_inven_eq_gear_bool, _inven_eq_grade_bool)
	if _inven_eq_arr.is_empty():
		inven_eq_btn_next.disabled = true
		inven_eq_btn_prev.disabled = true
		return
	
	var slide_data := inven_eq_data.slide_manager(_inven_eq_arr.size())

	_inven_eq_page_total = slide_data["total_slide"]
	_inven_eq_item_reminder = slide_data["total_slide_reminder"]
	_inven_eq_page_max = slide_data["max_item"]
	_inven_eq_page_curr = 0
	
	inven_eq_btn_slide.text = str("Page: ",_inven_eq_page_curr+1)
	
	var loop_total:int=0
	if _inven_eq_page_total == 1: loop_total = _inven_eq_item_reminder
	else: loop_total = _inven_eq_page_max
	
	_inven_eq_btn_disabled(true)
	pnl_loading.show()
	for i in range(0, loop_total):
		inven_eq_data.new_equipment(inven_eq_prosed, inven_eq_grid_parent, _inven_eq_arr[i], inspect_eq_pnl, inven_eq_enhance_btn["pnl_ask"], self, inven_eq_enhance_btn["pnl_upgrade"], inven_eq_grid_parent, gearset_parent)
		SfxManager.play_count()
		await get_tree().create_timer(.02).timeout
	_inven_eq_btn_disabled(false)
	pnl_loading.hide()

func _on_prev_pressed() -> void:
	SfxManager.play_click()
	var sim_prev = _inven_eq_page_curr - 1
	if sim_prev < 0 or _inven_eq_arr.is_empty():
		return
	
	# Update current page dengan clamp yang benar
	_inven_eq_page_curr = clamp(sim_prev, 0, _inven_eq_page_total - 1)
	inven_eq_btn_slide.text = str("Page: ", _inven_eq_page_curr + 1)
	
	# Bersihkan isi sebelumnya
	for i in range(inven_eq_grid_parent.get_child_count() - 1, 0, -1):
		inven_eq_grid_parent.get_child(i).queue_free()
	
	# Hitung posisi awal item
	var start_index = _inven_eq_page_curr * _inven_eq_page_max
	
	# Hitung berapa banyak item yang ditampilkan di halaman ini
	var items_to_show = _inven_eq_page_max
	if _inven_eq_page_curr == _inven_eq_page_total - 1:
		items_to_show = _inven_eq_item_reminder if _inven_eq_item_reminder > 0 else _inven_eq_page_max
	
	_inven_eq_btn_disabled(true)
	# Tampilkan item
	pnl_loading.show()
	for i in range(start_index, start_index + items_to_show):
		if i < _inven_eq_arr.size():
			inven_eq_data.new_equipment(inven_eq_prosed, inven_eq_grid_parent, _inven_eq_arr[i], inspect_eq_pnl, inven_eq_enhance_btn["pnl_ask"], self, inven_eq_enhance_btn["pnl_upgrade"], inven_eq_grid_parent, gearset_parent)
			SfxManager.play_count()
			await get_tree().create_timer(.02).timeout
	_inven_eq_btn_disabled(false)
	pnl_loading.hide()

func _on_next_pressed() -> void:
	SfxManager.play_click()
	var sim_next = _inven_eq_page_curr + 1
	if sim_next >= _inven_eq_page_total or _inven_eq_arr.is_empty():
		return
	
	# Update current page
	_inven_eq_page_curr = clamp(sim_next, 0, _inven_eq_page_total - 1)
	inven_eq_btn_slide.text = str("Page: ", _inven_eq_page_curr + 1)

	# Bersihkan isi sebelumnya
	for i in range(inven_eq_grid_parent.get_child_count() - 1, 0, -1):
		inven_eq_grid_parent.get_child(i).queue_free()

	# Hitung posisi awal item
	var start_index = _inven_eq_page_curr * _inven_eq_page_max

	# Hitung berapa banyak item yang ditampilkan di halaman ini
	var items_to_show = _inven_eq_page_max
	if _inven_eq_page_curr == _inven_eq_page_total - 1:
		items_to_show = _inven_eq_item_reminder if _inven_eq_item_reminder > 0 else _inven_eq_page_max

	_inven_eq_btn_disabled(true)
	# Tampilkan item
	pnl_loading.show()
	for i in range(start_index, start_index + items_to_show):
		if i < _inven_eq_arr.size():
			inven_eq_data.new_equipment(inven_eq_prosed, inven_eq_grid_parent, _inven_eq_arr[i], inspect_eq_pnl, inven_eq_enhance_btn["pnl_ask"], self, inven_eq_enhance_btn["pnl_upgrade"], inven_eq_grid_parent, gearset_parent)
			SfxManager.play_count()
			await get_tree().create_timer(.02).timeout
	_inven_eq_btn_disabled(false)
	pnl_loading.hide()

#------------------------------------- INVENTORY EQUIPMENTS: END ---------------------------------------------

#------------------------------------- INVENTORY EQUIPMENTS: ENHANCE ---------------------------------------------
@onready var inven_eq_enhance_btn = {
	"pnl_upgrade":$ui_enhance_gear,
	"pnl_ask":$prosed_ask
}

var enhance_data = Lobby_Enhance.new()
func enhance_play_spell(node: TextureRect) -> void:
	node.visible = true
	node.rotation_degrees = 0.0
	node.modulate.a = 50.0 / 255.0  # Reset alpha ke 50 (dalam format 0.0 - 1.0)

	var _tween_enhance = create_tween()
	_tween_enhance.set_parallel(true)

	# Rotasi 360 derajat selama 3 detik
	_tween_enhance.tween_property(node, "rotation_degrees", 360.0, 3.0).set_trans(Tween.TRANS_LINEAR)

	# Tween alpha dari 50 → 255 dalam 0.5 detik pertama
	_tween_enhance.tween_property(node, "modulate:a", 255.0 / 255.0, 2.5).from(50.0 / 255.0).set_trans(Tween.TRANS_LINEAR)

	# Setelah 2.5 detik, tween alpha dari 255 → 0 selama 0.5 detik (fade out perlahan)
	var fade_out_tween = create_tween()
	fade_out_tween.tween_property(node, "modulate:a", 0.0, 0.5).set_delay(2.5).set_trans(Tween.TRANS_LINEAR)

	await fade_out_tween.finished
	node.hide()
func enhance_play_prog(progress_bar: TextureProgressBar) -> void:
	# Reset progress bar value to 0
	progress_bar.value = 0

	# Data konfigurasi
	var data = {
		"stats": [
			$ui_enhance_gear/pnlc/hbox/stat_1/stat_afater,
			$ui_enhance_gear/pnlc/hbox/stat_2/stat_afater,
			$ui_enhance_gear/pnlc/hbox/stat_3/stat_afater
		],
		"targets": [33, 66, 100],
		"duration": 0.2,
		"wait": 0.8
	}

	# Semua stat invisible di awal
	for stat in data["stats"]:
		stat.visible = false

	# Tween
	var tween = create_tween()
	tween.set_loops(1)

	for i in data["targets"].size():
		var target_value = data["targets"][i]
		var stat_node = data["stats"][i]

		# Tween progress bar
		tween.tween_property(progress_bar, "value", target_value, data["duration"])
		# Callback untuk show stat_after setelah tween selesai
		tween.tween_callback(Callable(stat_node, "show"))
		# Tunggu sebelum lanjut
		tween.tween_interval(data["wait"])
func enhance_play_smith(texture_rect: TextureRect) -> void:
	# Set initial color
	texture_rect.modulate = Color("#313131")
	
	# Initial and target colors
	var dark_color = Color("#313131")
	var bright_color = Color("#c6c6c6")
	
	# Create a new Tween object
	var tween = create_tween()
	tween.set_loops(1)  # Only run once (the full sequence)
	
	# First flash sequence
	tween.tween_property(texture_rect, "modulate", bright_color, 0.2)
	tween.tween_property(texture_rect, "modulate", dark_color, 0.0)
	tween.tween_callback(SfxManager.play_random_enhance)
	tween.tween_callback(SfxManager.play_enhance_spell)
	tween.tween_interval(0.8)
	
	# Second flash sequence
	tween.tween_property(texture_rect, "modulate", bright_color, 0.2)
	tween.tween_property(texture_rect, "modulate", dark_color, 0.0)
	tween.tween_callback(SfxManager.play_random_enhance)
	tween.tween_interval(0.8)
	
	# Third flash sequence
	tween.tween_property(texture_rect, "modulate", bright_color, 0.2)
	tween.tween_property(texture_rect, "modulate", dark_color, 0.0)
	tween.tween_callback(SfxManager.play_random_enhance)
func _on_enhance_upgrade_pressed() -> void:
	add_player_exp_level(randi_range(100, 500))
	SfxManager.play_click()
	$ui_enhance_gear/enhance_upgrade.disabled=true
	enhance_play_spell($ui_enhance_gear/spell)
	enhance_play_smith($ui_enhance_gear/old_man)
	enhance_play_prog($ui_enhance_gear/prog_enhance)
	await get_tree().create_timer(3).timeout
	$ui_enhance_gear/enhance_upgrade2.disabled=false
	AutoloadData.roadmap_total_enhance+=1
	AutoloadData.save_data()
func _on_enhance_upgrade_2_pressed() -> void:
	SfxManager.play_click()
	$ui_enhance_gear.hide()

func _on_btn_switch_story_pressed() -> void:
	SfxManager.play_click()
	var new_eq_data = Lobby_equipments.new()
	var _pnl_story:PanelContainer = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/PanelContainer
	var _pnl_gear_eq:HBoxContainer = $ui_prosedural_inspect_00/VBoxContainer/HBoxContainer/PanelContainer/panel_story/pnl_gear_eq
	var story_visivle = !_pnl_story.visible
	var eq_visible = !_pnl_gear_eq.visible
	_pnl_story.visible = story_visivle
	_pnl_gear_eq.visible = eq_visible
	if pnl_gear_set.visible==true:
		pnl_gear_set.hide()
		_pnl_story.hide()
		_pnl_gear_eq.show()
	if _pnl_gear_eq.visible == true:
		new_eq_data.eq_prog_player(
			prosedural_deck_prog,
			prosedural_deck_prog_over,
			prosedural_deck_prog_final,
			prosedura_dekc_prog_txt,
			card_inspect_stat,
			eq_prog,
			data_current_gearset["card_code"],
			gearset_indic)
	else:
		eq_prog(
		prosedural_deck_prog, 
		prosedural_deck_prog_over, 
		prosedural_deck_prog_final,
		prosedura_dekc_prog_txt,
		card_inspect_filter,
		card_inspect_stat)
