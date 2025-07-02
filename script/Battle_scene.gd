extends Node2D

class_name Battle_scene
const BASE_CARD = preload("res://scenes/Base_card.tscn")
var new_card_s1 = Card_data_s1.new()

func get_random_int(rand_min: int, rand_max: int) -> int:
	return randi_range(rand_min, rand_max)

var arr_skill = []
var instant_heal:int = 0
var instant_heal_bool:bool = true

func func_coba():
	btn_attack_disabled(false)
var btn_battle_infocard:Button
var btn_battle_infovs:Button
var btn_battle_infoelem:Button

# --------------------------------- BATTLE REWARD: START -------------------------------------
@onready var fr_prosed = $Camera2D/panel_reward/VBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/grid_reward_parent/prosedural_reward
@onready var fr_parent = $Camera2D/panel_reward/VBoxContainer/PanelContainer/VBoxContainer/ScrollContainer/grid_reward_parent
@onready var fr_indic:PanelContainer = $Camera2D/panel_reward_indic

enum ENUM_REWARD_TYPE {CURRENCY}
enum ENUM_REWARD {MONEY, EXP, TICKET}

var fr_exp_total:int = 0
var fr_money_total:int = 0
var fr_ticket_total:int = 0

func fr_get_player_currency(value:ENUM_REWARD):
	var _currency
	if value == ENUM_REWARD.MONEY: _currency = str("own: ",filter_num_k(AutoloadData.player_money))
	elif value == ENUM_REWARD.EXP: _currency = str("own: ",filter_num_k(AutoloadData.player_exp))
	elif value == ENUM_REWARD.TICKET: _currency = str("own: ",filter_num_k(AutoloadData.player_super_ticket))
	return _currency

# FINAL REWARD GENERATOR (CURRECNCY)
func fr_gen(rwd_type:ENUM_REWARD_TYPE, rwd_main:ENUM_REWARD, rwd_total:int):
	var reward_data = Load_reward.new()
	var tween:Tween = create_tween()
	
	match rwd_type:
		ENUM_REWARD_TYPE.CURRENCY:
			var check_exist = false
			var node_to_check = ""
			node_to_check = reward_data.currency[rwd_main]["id"]
			check_exist = fr_parent.has_node(node_to_check)
			if not check_exist:
				# Kode untuk membuat node baru
				var new_reward:PanelContainer = fr_prosed.duplicate()
				var get_icon:TextureRect = new_reward.get_node("vbox/icon")
				var get_grade:Label = new_reward.get_node("vbox/grade")
				var get_item_name:Label = new_reward.get_node("vbox/item_name")
				var get_total:Label = new_reward.get_node("vbox/icon/total")
				var get_btn:Button = new_reward.get_node("vbox/icon/btn") 
				
				get_btn.connect("pressed", func():
					fr_indic.get_node("vbox/hbox/icon").texture = reward_data.currency[rwd_main]["icon"]
					fr_indic.get_node("vbox/hbox/vbox/name").text = reward_data.currency[rwd_main]["name"]
					fr_indic.get_node("vbox/hbox/vbox/type").text = reward_data.currency[rwd_main]["type"]
					fr_indic.get_node("vbox/hbox/vbox/grade").text = str("GRADE: ",reward_data.currency[rwd_main]["grade"])
					fr_indic.get_node("vbox/hbox/vbox/grade").add_theme_color_override("font_color", reward_data.currency[rwd_main]["color"])
					fr_indic.get_node("vbox/scrol_con/desc").text = reward_data.currency[rwd_main]["desc"]
					fr_indic.get_node("vbox/own").text = fr_get_player_currency(rwd_main)
					fr_indic.visible = !fr_indic.visible)
			
				new_reward.name = reward_data.currency[rwd_main]["id"]
				match rwd_main:
					ENUM_REWARD.EXP:fr_exp_total += rwd_total
					ENUM_REWARD.MONEY:fr_money_total += rwd_total
					ENUM_REWARD.TICKET:fr_ticket_total += rwd_total
					
				get_icon.texture = reward_data.currency[rwd_main]["icon"]
				get_grade.text = str("GRADE: ",reward_data.currency[rwd_main]["grade"])
				get_grade.add_theme_color_override("font_color", reward_data.currency[rwd_main]["color"])
				get_item_name.text = reward_data.currency[rwd_main]["name"]
				fr_parent.add_child(new_reward)
				new_reward.show()
				
				match rwd_main:
					ENUM_REWARD.EXP:
						tween.tween_method(func(value): get_total.text = filter_num_k(value), 0, fr_exp_total, .3)
						await tween.finished
						score_exp_main += fr_exp_total
					ENUM_REWARD.MONEY:
						tween.tween_method(func(value): get_total.text = filter_num_k(value), 0, fr_money_total, .3)
						await tween.finished
						current_score += fr_money_total
					ENUM_REWARD.TICKET:
						tween.tween_method(func (value): get_total.text = filter_num_k(value), 0, fr_ticket_total, .3)
						pass
				
			else:
				var old_reward = fr_parent.get_node(reward_data.currency[rwd_main]["id"])
				var _score_temp = 0
				
				var get_total:Label = old_reward.get_node("vbox/icon/total")
				match rwd_main:
					ENUM_REWARD.EXP:
						_score_temp = fr_exp_total
						fr_exp_total += rwd_total
						tween.tween_method(func(value): get_total.text = filter_num_k(value), _score_temp, fr_exp_total, .3)
						await tween.finished
						score_exp_main += rwd_total
					ENUM_REWARD.MONEY:
						_score_temp = fr_money_total
						fr_money_total += rwd_total
						tween.tween_method(func(value): get_total.text = filter_num_k(value), _score_temp, fr_money_total, .3)
						await tween.finished
						current_score += rwd_total
					ENUM_REWARD.TICKET:
						_score_temp = fr_ticket_total
						fr_ticket_total += rwd_total
						tween.tween_method(func(value): get_total.text = filter_num_k(value), _score_temp, fr_ticket_total, .3)
						await tween.finished
func fr_eq_stat_code(code, value):
	match code:
		"atk_flat":return str("Attack +",value)
		"atk_pct":return str("Attack(%) +",value,"%")
		"def_flat":return str("Defense +",value)
		"def_pct":return str("Defense(%) +",value,"%")
		"hp_flat":return str("Health: +",value)
		"hp_pct":return str("Health(%) +",value,"%")
		"turn_flat":return str("Turn Speed +",value)
		"turn_pct":return str("Turn Speed(%) +",value,"%")
		"crit_rate":return str("Critical Hit(%) +",value,"%")
		"crit_dmg":return str("Critical Damage(%) +",value,"%")
		"spd_flat":return str("Speed Attack +",value)
		"eva_flat":return str("Evation +",value)
		"crit_def":return str("Critical Defense(%) +",value,"%")
func fr_gen_eq(loop_code): # FINAL REWARD: CEHST EQ
	var reward_data = Load_reward.new()
	var rng_eq_main = randi_range(1, 1000)
	var eq_tier
	if rng_eq_main == 1: eq_tier = 6
	elif rng_eq_main <= 10: eq_tier = 5
	elif rng_eq_main <= 20: eq_tier = 4
	elif rng_eq_main <= 30: eq_tier = 3
	elif rng_eq_main <= 100: eq_tier = 2
	else: eq_tier = 1
	
	var new_eq = reward_data.eq_chest(eq_tier, loop_code) # NOTE NEW EQ -----------------------------------
	await get_tree().process_frame
	var new_reward:PanelContainer = fr_prosed.duplicate()
	var get_icon:TextureRect = new_reward.get_node("vbox/icon")
	var get_grade:Label = new_reward.get_node("vbox/grade")
	var get_item_name:Label = new_reward.get_node("vbox/item_name")
	var get_total:Label = new_reward.get_node("vbox/icon/total")
	var get_btn:Button = new_reward.get_node("vbox/icon/btn")
	get_total.hide()
	
	var main_desc = str(
		new_eq["desc"],"\n\n",
		"Gearset: ",new_eq["id_uniq"],"\n",
		"(","[color=",new_eq["stat_1"]["stat_color"],"]",new_eq["stat_1"]["stat_grade"],"[/color]",") ","Stat: ",fr_eq_stat_code(new_eq["stat_1"]["stat_code"],new_eq["stat_1"]["stat_main"]),"\n",
		"(","[color=",new_eq["stat_2"]["stat_color"],"]",new_eq["stat_2"]["stat_grade"],"[/color]",") ","Stat: ",fr_eq_stat_code(new_eq["stat_2"]["stat_code"], new_eq["stat_2"]["stat_main"]),"\n",
		"(","[color=",new_eq["stat_3"]["stat_color"],"]",new_eq["stat_3"]["stat_grade"],"[/color]",") ","Stat: ",fr_eq_stat_code(new_eq["stat_3"]["stat_code"], new_eq["stat_3"]["stat_main"]),"\n",
	)
	
	get_btn.connect("pressed", func():
		fr_indic.get_node("vbox/hbox/icon").texture = new_eq["icon"]
		fr_indic.get_node("vbox/hbox/vbox/name").text = str(new_eq["name"])
		fr_indic.get_node("vbox/hbox/vbox/type").text = new_eq["type"]
		fr_indic.get_node("vbox/hbox/vbox/grade").text = str("GRADE: ",new_eq["grade_txt"])
		fr_indic.get_node("vbox/hbox/vbox/grade").add_theme_color_override("font_color", new_eq["grade_color"])
		fr_indic.get_node("vbox/scrol_con/desc").text = main_desc
		fr_indic.get_node("vbox/own").text = str(new_eq["desc_uniq"])
		fr_indic.visible = !fr_indic.visible )
	#get_btn.connect("mouse_exited", func(): fr_indic.hide())
	
	get_icon.texture = new_eq["icon"]
	get_grade.text = str("GRAED: ",new_eq["grade_txt"])
	get_grade.add_theme_color_override("font_color", new_eq["grade_color"])
	get_item_name.text = str(new_eq["name"])
	fr_parent.add_child(new_reward)
	new_reward.show()
			
func fr_main(is_win:bool):
	await fr_money_tween(0, current_score)
	await fr_exp_tween(0, score_exp_main)
	
	# reward eq
	var rng_rwd_eq = randi_range(1, 100)
	if rng_rwd_eq <=30:
		var rng_count = randi_range(1, 100)
		var main_count
		if rng_count == 1: main_count = 5
		elif rng_count <= 10: main_count = 4
		elif rng_count <= 20: main_count = 3
		elif rng_count <= 30: main_count = 3
		elif rng_count <= 50: main_count = 2
		else: main_count = 1
		for i in range(main_count): # LOOP MAKE REWARD ON FINAL REWARD------------------------------------
			fr_gen_eq(i)
	if is_win:
		var rng_count = randi_range(5, 10)
		var rng_ticket = randi_range(1, 100)
		var rng_ticket_count = randi_range(1, 3)
		for i in range(rng_count):
			var rng_money = get_pct(current_score, randi_range(10, 20))
			var rng_exp = get_pct(score_exp_main, randi_range(5, 10))
	
			await fr_gen(ENUM_REWARD_TYPE.CURRENCY, ENUM_REWARD.MONEY, rng_money)
			await fr_gen(ENUM_REWARD_TYPE.CURRENCY, ENUM_REWARD.EXP, rng_exp)
		rng_ticket = 7
		if rng_ticket == 7:
			for i in range(rng_ticket_count):
				var rng = randi_range(1, 10)
				await fr_gen(ENUM_REWARD_TYPE.CURRENCY, ENUM_REWARD.TICKET, rng)
	else:
		var rng_money = get_pct(current_score, randi_range(5, 10))
		var rng_exp = get_pct(score_exp_main, randi_range(1, 5))
		await fr_gen(ENUM_REWARD_TYPE.CURRENCY, ENUM_REWARD.MONEY, rng_money)
		await fr_gen(ENUM_REWARD_TYPE.CURRENCY, ENUM_REWARD.EXP, rng_exp)
	await fr_money_tween(0, current_score)
	await fr_exp_tween(0, score_exp_main)

func fr_save_score():
	AutoloadData.player_money += current_score
	AutoloadData.player_exp += score_exp_main
	AutoloadData.player_super_ticket += fr_ticket_total
	AutoloadData.roadmap_gold += current_score
	AutoloadData.roadmap_mana += score_exp_main
	AutoloadData.save_data()
		
func fr_exp_tween(value, new_value):
	var tween:Tween = create_tween()
	tween.tween_method(fr_exp_txt, value, new_value, .3)
	await tween.finished
func fr_exp_txt(value):
	$Camera2D/panel_reward/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer/fr_exp.text = filter_num_k(value)
	SfxManager.play_exp()
	
func fr_money_tween(value, new_value):
	var tween:Tween = create_tween()
	tween.tween_method(fr_money_txt, value, new_value, .3)
	await tween.finished
func fr_money_txt(value):
	$Camera2D/panel_reward/VBoxContainer/PanelContainer2/VBoxContainer/HBoxContainer2/fr_money.text = filter_num_k(value)
	SfxManager.play_money()
# --------------------------------- BATTLE REWARD: END-------------------------------------

var battle_round_main:Label
var battle_round_total:Label
var punishment_total:Label
var main_time_cooldown:Label
var score_bonus:Label
var exp_score:Label
var exp_herosurvived:Label
# FINAL STATISTIC
@onready var fs_header:Label=$Camera2D/final_statistic/VBoxContainer/HBoxContainer/header

@onready var fs0_icon:TextureRect=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/fs0_icon
@onready var fs0_name:Label=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/fs0_name
@onready var fs0_dmg_d:Label=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_dmg_d
@onready var fs0_dmg_d_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_dmg_d_prog
@onready var fs0_dmg_t:Label=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_dmg_t
@onready var fs0_dmg_t_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_dmg_t_prog
@onready var fs0_heal_r:Label=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_heal_r
@onready var fs0_heal_r_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_heal_r_prog
@onready var fs0_recov:Label=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_recov
@onready var fs0_recov_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer/VBoxContainer/fs0_recov_prog

@onready var fs1_icon:TextureRect=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/fs1_icon
@onready var fs1_name:Label=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/fs1_name
@onready var fs1_dmg_d:Label=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_dmg_d
@onready var fs1_dmg_d_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_dmg_d_prog
@onready var fs1_dmg_t:Label=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_dmg_t
@onready var fs1_dmg_t_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_dmg_t_prog
@onready var fs1_heal_r:Label=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_heal_r
@onready var fs1_heal_r_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_heal_r_prog
@onready var fs1_recov:Label=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_recov
@onready var fs1_recov_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer/VBoxContainer/fs1_recov_prog

@onready var fs2_icon:TextureRect=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/fs2_icon
@onready var fs2_name:Label=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/fs2_name
@onready var fs2_dmg_d:Label=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_dmg_d
@onready var fs2_dmg_d_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_dmg_d_prog
@onready var fs2_dmg_t:Label=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_dmg_t
@onready var fs2_dmg_t_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_dmg_t_prog
@onready var fs2_heal_r:Label=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_heal_r
@onready var fs2_heal_r_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_heal_r_prog
@onready var fs2_recov:Label=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_recov
@onready var fs2_recov_prog:TextureProgressBar=$Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer/VBoxContainer/fs2_recov_prog

@onready var fs0:PanelContainer=$Camera2D/final_statistic/VBoxContainer/fs0
@onready var fs1:PanelContainer=$Camera2D/final_statistic/VBoxContainer/fs1
@onready var fs2:PanelContainer=$Camera2D/final_statistic/VBoxContainer/fs2

@onready var fs0_elem:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/VBoxContainer/fs0_elem
@onready var fs0_class:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/VBoxContainer/fs0_class
@onready var fs1_elem:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/VBoxContainer/fs1_elem
@onready var fs1_class:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/VBoxContainer/fs1_class
@onready var fs2_elem:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/VBoxContainer/fs2_elem
@onready var fs2_class:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/VBoxContainer/fs2_class

@onready var fs0_leaderboard_0:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/VBoxContainer2/fs0_stat0
@onready var fs0_leaderboard_1:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/VBoxContainer2/fs0_stat1
@onready var fs0_leaderboard_2:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/VBoxContainer2/fs0_stat2
@onready var fs0_leaderboard_3:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/VBoxContainer2/fs0_stat3
@onready var fs1_leaderboard_0:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/VBoxContainer2/fs1_stat0
@onready var fs1_leaderboard_1:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/VBoxContainer2/fs1_stat1
@onready var fs1_leaderboard_2:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/VBoxContainer2/fs1_stat2
@onready var fs1_leaderboard_3:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/VBoxContainer2/fs1_stat3
@onready var fs2_leaderboard_0:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/VBoxContainer2/fs2_stat0
@onready var fs2_leaderboard_1:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/VBoxContainer2/fs2_stat1
@onready var fs2_leaderboard_2:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/VBoxContainer2/fs2_stat2
@onready var fs2_leaderboard_3:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/VBoxContainer2/fs2_stat3

@onready var fs0_leaderboard_dead:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs0/VBoxContainer/HBoxContainer2/fs0_icon/fs0_isdead
@onready var fs1_leaderboard_dead:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs1/VBoxContainer/HBoxContainer2/fs1_icon/fs1_isdead
@onready var fs2_leaderboard_dead:TextureRect = $Camera2D/final_statistic/VBoxContainer/fs2/VBoxContainer/HBoxContainer2/fs2_icon/fs2_isdead

var fs_data_elem=[
	"res://img/Icon Jobs/New icon elements/icn_class_light.png",
	"res://img/Icon Jobs/New icon elements/icn_class_nature.png",
	"res://img/Icon Jobs/New icon elements/icn_class_water.png",
	"res://img/Icon Jobs/New icon elements/icn_class_dark.png",
	"res://img/Icon Jobs/New icon elements/icn_class_fire.png" ]
var fs_data_class=[
	"res://img/Icon Class/icn_job_warr.png",
	"res://img/Icon Class/icn_job_arch.png",
	"res://img/Icon Class/icn_job_deff.png",
	"res://img/Icon Class/icn_job_assa.png",
	"res://img/Icon Class/icn_job_supp.png",
	"res://img/Icon Class/icn_job_mech.png",
	"res://img/Icon Class/icn_job_abbys.png",
	"res://img/Icon Class/icn_job_wiz.png",
	"res://img/Icon Class/icn_job_heal.png" ]

func set_pct(total: int, angka_utama: int) -> int:
	if total == 0:
		return 0 # Hindari pembagian oleh nol
	return int((angka_utama * 100.0) / total)
func set_pct_float(total: int, angka_utama: int):
	if total == 0:
		return 0.0 # Atau nilai default lain yang kamu mau
	return (angka_utama * 100.0) / total

func tween_stat(method: Callable, start: float, end: float, duration: float) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_method(method, start, end, duration)
	await tween.finished

#var fs_elem_data = []
var fs_bool:bool = true
func fs_change() -> void:
	fs_bool=!fs_bool
	set_fs(fs_bool)
func set_fs(_bool:bool):
	fs0.visible=false
	fs1.visible=false
	fs2.visible=false
	fs0_dmg_d_prog.value= 0
	fs0_dmg_t_prog.value= 0
	fs0_recov_prog.value= 0
	fs0_heal_r_prog.value= 0
	fs1_dmg_d_prog.value = 0
	fs1_dmg_t_prog.value = 0
	fs1_recov_prog.value = 0
	fs1_heal_r_prog.value = 0
	fs2_dmg_d_prog.value = 0
	fs2_dmg_t_prog.value = 0
	fs2_recov_prog.value = 0
	fs2_heal_r_prog.value = 0
	
	var all_ally = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	var all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var get_data = Card_data_s1.new()
	var total_dmg_dealth:int=0
	var total_dmg_taken:int=0
	var total_healing:int=0
	var total_heal_recived:int=0
	var fs_icons = [fs0_icon, fs1_icon, fs2_icon]
	var fs_names = [fs0_name, fs1_name, fs2_name]
	var fs_elem = [fs0_elem, fs1_elem, fs2_elem]
	var fs_class = [fs0_class, fs1_class, fs2_class]
	var fs_leaderboard = [
		[fs0_leaderboard_0, fs0_leaderboard_1, fs0_leaderboard_2, fs0_leaderboard_3],
		[fs1_leaderboard_0, fs1_leaderboard_1, fs1_leaderboard_2, fs1_leaderboard_3],
		[fs2_leaderboard_0, fs2_leaderboard_1, fs2_leaderboard_2, fs2_leaderboard_3]
	]
	var fs_dead = [fs0_leaderboard_dead, fs1_leaderboard_dead, fs2_leaderboard_dead]
	
	var arr_card = all_ally if _bool else all_enem
	fs_header.text = "ALLY" if _bool else "ENEMY"

	for value in arr_card:
		total_dmg_dealth += abs(value.dmg_dealt)
		total_dmg_taken += abs(value.dmg_taken)
		total_healing += abs(value.total_heal)
		total_heal_recived += abs(value.total_heal_recived)
	print("Total Damage Dealt:", total_dmg_dealth)
	print("Total Damage Taken:", total_dmg_taken)
	print("Total Healing:", total_healing)
	print("Total Heal Received:", total_heal_recived)

	var mvp_0:int=0
	var mvp_1:int=0
	var mvp_2:int=0
	var arr_mvp = [mvp_0, mvp_1, mvp_2]
	for i in range(3):
		var unit = arr_card[i % arr_card.size()]
		var card_data = get_data.dict_all_card_s1[unit.card_code]
		fs_icons[i].texture = load(card_data["icon"])
		fs_names[i].text = str(card_data["name"])
		fs_elem[i].texture = load(fs_data_elem[arr_card[i]._hero_elemen])
		fs_class[i].texture = load(fs_data_class[arr_card[i]._hero_job])
		arr_mvp[i]+= abs(set_pct_float(total_dmg_dealth, arr_card[i].dmg_dealt))
		arr_mvp[i]+= abs(set_pct_float(total_dmg_taken, arr_card[i].dmg_taken))
		arr_mvp[i]+= abs(set_pct_float(total_healing, arr_card[i].total_heal))
		var get_killcount = arr_card[i].elim_card_count
		var limit_killcount = clamp(get_killcount, 0, 3)
		for value in range(3):fs_leaderboard[i][value+1].visible=false
		if limit_killcount !=0: for value in range(limit_killcount): fs_leaderboard[i][value+1].visible=true
		fs_dead[i].visible=arr_card[i].get_health == 0
		
	var mvp_main = arr_mvp.find(arr_mvp.max())
	for value in range(3): fs_leaderboard[value][0].visible = value==mvp_main
	
	var set_time = .1
	fs0.visible=true
	await tween_stat(fs0_tween_dmgd, 0, arr_card[0].dmg_dealt, set_time)
	await tween_stat(fs0_tween_dmgdp, 0, set_pct_float(total_dmg_dealth, arr_card[0].dmg_dealt), set_time)
	await tween_stat(fs0_tween_dmgt, 0, arr_card[0].dmg_taken, set_time)
	await tween_stat(fs0_tween_dmgtp, 0, set_pct_float(total_dmg_taken, arr_card[0].dmg_taken), set_time)
	await tween_stat(fs0_tween_healt, 0, arr_card[0].total_heal_recived, set_time)
	await tween_stat(fs0_tween_healtp, 0, set_pct_float(total_heal_recived, arr_card[0].total_heal_recived), set_time)
	await tween_stat(fs0_tween_healr, 0, arr_card[0].total_heal, set_time)
	await tween_stat(fs0_tween_healrp, 0, set_pct_float(total_healing, arr_card[0].total_heal), set_time)
	fs1.visible=true
	await tween_stat(fs1_tween_dmgd, 0, arr_card[1].dmg_dealt, set_time)
	await tween_stat(fs1_tween_dmgdp, 0, set_pct_float(total_dmg_dealth, arr_card[1].dmg_dealt), set_time)
	await tween_stat(fs1_tween_dmgt, 0, arr_card[1].dmg_taken, set_time)
	await tween_stat(fs1_tween_dmgtp, 0, set_pct_float(total_dmg_taken, arr_card[1].dmg_taken), set_time)
	await tween_stat(fs1_tween_healt, 0, arr_card[1].total_heal_recived, set_time)
	await tween_stat(fs1_tween_healtp, 0, set_pct_float(total_heal_recived, arr_card[1].total_heal_recived), set_time)
	await tween_stat(fs1_tween_healr, 0, arr_card[1].total_heal, set_time)
	await tween_stat(fs1_tween_healrp, 0, set_pct_float(total_healing, arr_card[1].total_heal), set_time)
	fs2.visible=true
	await tween_stat(fs2_tween_dmgd, 0, arr_card[2].dmg_dealt, set_time)
	await tween_stat(fs2_tween_dmgdp, 0, set_pct_float(total_dmg_dealth, arr_card[2].dmg_dealt), set_time)
	await tween_stat(fs2_tween_dmgt, 0, arr_card[2].dmg_taken, set_time)
	await tween_stat(fs2_tween_dmgtp, 0, set_pct_float(total_dmg_taken, arr_card[2].dmg_taken), set_time)
	await tween_stat(fs2_tween_healt, 0, arr_card[2].total_heal_recived, set_time)
	await tween_stat(fs2_tween_healtp, 0, set_pct_float(total_heal_recived, arr_card[2].total_heal_recived), set_time)
	await tween_stat(fs2_tween_healr, 0, arr_card[2].total_heal, set_time)
	await tween_stat(fs2_tween_healrp, 0, set_pct_float(total_healing, arr_card[2].total_heal), set_time)

func fs0_tween_dmgd(value): fs0_dmg_d.text=str("DAMAGE DEALT: ",filter_num_k(abs(value)))
func fs0_tween_dmgdp(value):
	fs0_dmg_d_prog.value=abs(value)
	if value !=0:SfxManager.play_score()
func fs0_tween_dmgt(value): fs0_dmg_t.text=str("DAMAGE TAKEN: ", filter_num_k(abs(value)))
func fs0_tween_dmgtp(value):
	fs0_dmg_t_prog.value=abs(value)
	if value !=0:SfxManager.play_score()       
func fs0_tween_healt(value): fs0_heal_r.text=str("HEAL RECIVED: ", filter_num_k(abs(value)))
func fs0_tween_healtp(value):
	fs0_heal_r_prog.value=abs(value)
	if value !=0:SfxManager.play_score()
func fs0_tween_healr(value): fs0_recov.text=str("RECOVERY: ", filter_num_k(abs(value)))
func fs0_tween_healrp(value):
	fs0_recov_prog.value=abs(value)
	if value !=0:SfxManager.play_score()

func fs1_tween_dmgd(value): fs1_dmg_d.text = str("DAMAGE DEALT: ", filter_num_k(abs(value)))
func fs1_tween_dmgdp(value):
	fs1_dmg_d_prog.value = abs(value)
	if value !=0:SfxManager.play_score()
func fs1_tween_dmgt(value): fs1_dmg_t.text = str("DAMAGE TAKEN: ", filter_num_k(abs(value)))
func fs1_tween_dmgtp(value):
	fs1_dmg_t_prog.value = abs(value)
	if value !=0:SfxManager.play_score()
func fs1_tween_healt(value): fs1_heal_r.text = str("HEAL RECIVED: ", filter_num_k(abs(value)))
func fs1_tween_healtp(value):
	fs1_heal_r_prog.value = abs(value)
	if value !=0:SfxManager.play_score()
func fs1_tween_healr(value): fs1_recov.text = str("RECOVERY: ", filter_num_k(abs(value)))
func fs1_tween_healrp(value):
	fs1_recov_prog.value = abs(value)
	if value !=0:SfxManager.play_score()

func fs2_tween_dmgd(value): fs2_dmg_d.text = str("DAMAGE DEALT: ", filter_num_k(abs(value)))
func fs2_tween_dmgdp(value):
	fs2_dmg_d_prog.value = abs(value)
	if value !=0:SfxManager.play_score()
func fs2_tween_dmgt(value): fs2_dmg_t.text = str("DAMAGE TAKEN: ", filter_num_k(abs(value)))
func fs2_tween_dmgtp(value):
	fs2_dmg_t_prog.value = abs(value)
	if value !=0:SfxManager.play_score()
func fs2_tween_healt(value): fs2_heal_r.text = str("HEAL RECIVED: ", filter_num_k(abs(value)))
func fs2_tween_healtp(value):
	fs2_heal_r_prog.value = abs(value)
	if value !=0:SfxManager.play_score()
func fs2_tween_healr(value): fs2_recov.text = str("RECOVERY: ", filter_num_k(abs(value)))
func fs2_tween_healrp(value):
	fs2_recov_prog.value = abs(value)
	if value !=0:SfxManager.play_score()

# REWAWRD SET
func var_onready():
	exp_herosurvived = get_node("%exp_hero_survived")
	exp_score = get_node("%exp_score")
	score_bonus = get_node("%score_bonus")
	main_time_cooldown= get_node("%main_time_cooldown")
	main_score = get_node("%main_score")
	btn_battle_infocard = get_node("%battle_info_card_info")
	btn_battle_infovs = get_node("%battle_info_vs")
	btn_battle_infoelem = get_node("%battle_info_elem")
	battle_round_main = get_node("%battle_round_main")
	battle_round_total = get_node("%battle_round_total")
	punishment_total = get_node("%punishment")
	
func connect_onready():
	btn_battle_infocard.connect("mouse_entered", hoverin_battle_infocard)
	btn_battle_infovs.connect("mouse_entered", hoverin_battle_infovs)
	btn_battle_infoelem.connect("mouse_entered", hoverin_battle_infoelem)
	btn_battle_infocard.connect("mouse_exited", hoverout_battle_infocard)
	btn_battle_infovs.connect("mouse_exited", hoverout_battle_infovs)
	btn_battle_infoelem.connect("mouse_exited", hoverout_battle_infoelem)
	
func hoverin_battle_infocard():
	btn_battle_infocard.disabled = false
	SfxManager.play_turn_select()
func hoverout_battle_infocard():
	btn_battle_infocard.disabled = true
	battleinfo_active_btn(btn_battleinfo_ispressed)
func hoverin_battle_infovs():
	btn_battle_infovs.disabled = false
	SfxManager.play_turn_select()
func hoverout_battle_infovs():
	btn_battle_infovs.disabled = true
	battleinfo_active_btn(btn_battleinfo_ispressed)
func hoverin_battle_infoelem():
	btn_battle_infoelem.disabled = false
	SfxManager.play_turn_select()
func hoverout_battle_infoelem():
	btn_battle_infoelem.disabled = true
	battleinfo_active_btn(btn_battleinfo_ispressed)

func _ready():
	var_onready()
	connect_onready()
	disable_btn_select_enemy(false)
	#SfxManager.play_random_bgm_battle()
	SfxManager.lw_onready_bgm(SfxManager.ENUM_BGM.BATTLE)
	#for i in 3:
		#set_custom_time(.3)
		#generate_random_enemy_card()
		#set_custom_time(.3)
		#generate_random_hero_card()
	for i in range(3):
		generate_fixed_card(CHAR_TYPE.HERO, AutoloadData.cardSet_player[i])
		generate_fixed_card(CHAR_TYPE.ENEMY, AutoloadData.cardSet_enemy[i])
	turn_icon_availabel = true

func _input(event):
	if event.is_action_pressed("serang"): # space
		# generate_random_enemy_card()
		pass
	if event.is_action_pressed("survive_10"): # z
		#generate_random_hero_card()
		pass

# BATTLE SCORE
var exp_herosurvived_temp:int=0
var tween_exp_herosurvived:Tween
func tween_exherosurvived_check():
	var allhero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	var _exp_temp:int=0
	for value in allhero:
		if value.get_health !=0:
			match value.get_cost:
				1: _exp_temp+=100
				2: _exp_temp+=150
				4: _exp_temp+=300
				8: _exp_temp+=500
				15: _exp_temp+=1000
				25: _exp_temp+=3000
	if exp_herosurvived_temp != _exp_temp:
		tween_exp_herosurvived = get_tree().create_tween()
		tween_exp_herosurvived.tween_method(tween_exp_herosurvived_txt, exp_herosurvived_temp, _exp_temp, 1.0)
		exp_herosurvived_temp = _exp_temp
		
func tween_exp_herosurvived_txt(value):
	exp_herosurvived.text=filter_num_k(value)
	SfxManager.play_score()
				
var score_exp_main:int=0
func tween_exp_score(_bool:bool):
	var all_enem = [arr_enemy_pos[0],arr_enemy_pos[1],arr_enemy_pos[2]]
	var final_exp:int=0
	for value in all_enem: final_exp+=value.get_cost
	final_exp*=100
	var tween = get_tree().create_tween()
	if _bool:
		tween.tween_method(tween_exp_txt, 0, final_exp, 1.0)
		score_exp_main=final_exp
	elif _bool==false:
		var score_temp = int(score_exp_main/4.0)
		tween.tween_method(tween_exp_txt, score_exp_main, score_temp, 1.0)
		score_exp_main/=4
func tween_exp_txt(value):
	exp_score.text=filter_num_k(value)
	SfxManager.play_score()

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

var main_score
var current_score:int = 0
var after_score:int = 500
var bonus_main:int=0

var time_bonus_temp:int = 0
func add_score_bonus():
	var rng_0 = get_random_int(1, 100)
	var rng_1 = get_random_int(1, 100)
	var rng_2 = get_random_int(1, 100)
	var arr_total_bonus = [rng_0, rng_1, rng_2]
	var bonus: int = 0
	if arr_total_bonus[0] == arr_total_bonus[1] and arr_total_bonus[1] == arr_total_bonus[2]:bonus = 100
	elif arr_total_bonus == [4, 8, 7] or arr_total_bonus == [2, 7, 25]:bonus = 50
	elif arr_total_bonus[0] == arr_total_bonus[1] or arr_total_bonus[1] == arr_total_bonus[2] or arr_total_bonus[0] == arr_total_bonus[2]:bonus = 20
	else: bonus = 1
	var all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var multiple_bonus:int=0
	for value in all_enem: multiple_bonus+=value.get_cost
	var rng_div = get_random_int(50, 200)
	var final_bonus = (multiple_bonus*rng_div)*bonus
	tween_time_reward_isincressed(true, final_bonus)
	time_bonus_temp = final_bonus

func check_reward():
	if _tween_time_bool and _tween_time.is_running():
		_tween_time.kill()
		main_time_cooldown.text="0.00"
		tween_time_reward_isincressed(false, time_bonus_temp)
		tween_score(current_score+time_bonus_temp, 1.0)
		current_score+=time_bonus_temp
		time_bonus_temp = 0
		_tween_time_bool = false

var _tween_time:Tween
var _tween_time_bool=false
func tween_time():
	_tween_time_bool = true
	_tween_time = get_tree().create_tween()
	var rng_time = float(get_random_int(5, 20))
	_tween_time.tween_method(tween_time_txt, rng_time, 0, float(rng_time))
	add_score_bonus()
	
	await _tween_time.finished
	_tween_time_bool = false
	tween_time_reward_isincressed(false, time_bonus_temp)
	time_bonus_temp = 0
func tween_time_txt(value):
	var _value = snapped(value, 0.01)
	main_time_cooldown.text=str(_value)
	SfxManager.play_clock()
	
var _tween_time_reward:Tween
func tween_time_reward_isincressed(_bool:bool, value):
	if _tween_time_reward and _tween_time_reward.is_running():
		_tween_time_reward.kill()
		score_bonus.text ="0"
	_tween_time_reward = get_tree().create_tween()
	if _bool: _tween_time_reward.tween_method(tween_time_reward_txt, 0, value, 1.0)
	elif _bool == false: _tween_time_reward.tween_method(tween_time_reward_txt, value, 0, 1.0)
func tween_time_reward_txt(value):
	score_bonus.text=filter_num_k(value)
	SfxManager.play_score()

func tween_score(new_score:int, duration:float):
	var tween = create_tween()
	tween.tween_method(set_score, current_score, new_score, duration)
func set_score(value):
	current_score = value
	main_score.text = filter_num_k(current_score)
	SfxManager.play_score()

# END OFF BATTLE SCORE
var btn_battleinfo_ispressed = 1
func battleinfo_active_btn(code):
	var limit_code = clamp(code, 0, 2)
	var arr_btn_battleinfo =[btn_battle_infocard, btn_battle_infovs, btn_battle_infoelem]
	arr_btn_battleinfo[limit_code].disabled = false

func battle_info_btn_main(code:int):
	SfxManager.play_item_open()
	var limit_code = clamp(code, 0, 2)
	var arr_container = [
		$panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer,
		$panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer2,
		$panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer3]
	var arr_btn_battleinfo =[btn_battle_infocard, btn_battle_infovs, btn_battle_infoelem]
	
	for value in range(3):
		if value == limit_code:
			arr_container[value].visible = true
			arr_btn_battleinfo[value].disabled = false
			btn_battleinfo_ispressed = value
		else:
			arr_container[value].visible = false
			arr_btn_battleinfo[value].disabled = true

var caster_activated_select = false
var battle_started = false
func set_info_battle_caster(caster):
	var new_data = Card_data_s1.new()
	var get_icon = new_data.dict_all_card_s1[caster.card_code]["icon"]
	var _get_card_name = new_data.dict_all_card_s1[caster.card_code]["name"]
	var get_rank = new_data.dict_all_card_s1[caster.card_code]["rank"]
	var get_caster_icon:TextureRect = get_node("%battle_info_caster_icon")
	var get_caster_name:Label = get_node("%battle_info_caster_txt")
	var get_caster_rank:Label = get_node("%battle_info_caster_tier_rank")
	if caster.card_type_confirm == "hero":
		get_caster_icon.texture = load(get_icon)
		get_caster_name.text = str(_get_card_name)
		match get_rank:
			0: get_caster_rank.text = str("1")
			1: get_caster_rank.text = str("2")
			2: get_caster_rank.text = str("3")
			3: get_caster_rank.text = str("4")
			4: get_caster_rank.text = str("5")
			5: get_caster_rank.text = str("6")
	elif caster.card_type_confirm == "enemy":
		var default_icon = "res://img/Hero/icon/[START]_0.png"
		get_caster_icon.texture = load(default_icon)
		get_caster_name.text = str("<NAME>")
		get_caster_rank.text = str("?")
enum ENUM_BATTLE_INFO{HER_POS_0=0, HER_POS_1, HER_POS_2, ENEM_POS_0, ENEM_POS_1, ENEM_POS_2, ALLY_AOE, ENEM_AOE, SINGLE_ALLY, SINGLE_ENEM}
func info_battle_reset():
	var panel_red = preload("res://Themes/NEW THEME 2/Battle_info/panel_sub_red.tres")
	var get_panel:PanelContainer = get_node("%battle_info_target_panel")
	get_panel.theme = panel_red
	var get_header:Label = get_node("%battle_info_target_header")
	get_header.text = str("<TARGET>")
	var link_icon = "res://img/Hero/icon/[START]_0.png"
	var get_icon:TextureRect = get_node("%battle_info_target_icon")
	get_icon.texture = load(str(link_icon))
	var get_tier:Label = get_node("%battle_info_target_tier_rank")
	get_tier.text = str("-")
	var _get_card_name:Label = get_node("%battle_info_target_txt")
	_get_card_name.text = str("<NAME>")
func set_info_battle_target(code:ENUM_BATTLE_INFO):
	var panel_blue = preload("res://Themes/NEW THEME 2/Battle_info/panel_sub_blue.tres")
	var panel_red = preload("res://Themes/NEW THEME 2/Battle_info/panel_sub_red.tres")
	var target_pick
	var get_icon
	var _get_card_name
	var get_rank
	
	var case_main = false
	var case_aoe_elly = false
	var case_aoe_enem = false
	var case_single_ally = false
	var case_single_enem = false
	
	# NOTE: SOOM UPDATE
	if battle_started and caster_activated_select:
		if code in [ENUM_BATTLE_INFO.HER_POS_0, ENUM_BATTLE_INFO.HER_POS_1, ENUM_BATTLE_INFO.HER_POS_2, ENUM_BATTLE_INFO.ENEM_POS_0, ENUM_BATTLE_INFO.ENEM_POS_1, ENUM_BATTLE_INFO.ENEM_POS_2]:
			var new_data = Card_data_s1.new()
			var _allcard = [arr_hero_pos[0],arr_hero_pos[1],arr_hero_pos[2],arr_enemy_pos[0],arr_enemy_pos[1],arr_enemy_pos[2]]
			target_pick = _allcard[code]
			get_icon = new_data.dict_all_card_s1[target_pick.card_code]["icon"]
			_get_card_name = new_data.dict_all_card_s1[target_pick.card_code]["name"]
			get_rank = new_data.dict_all_card_s1[target_pick.card_code]["rank"]
			case_main = true
		elif code in [ENUM_BATTLE_INFO.ALLY_AOE, ENUM_BATTLE_INFO.ENEM_AOE]:
			if code == ENUM_BATTLE_INFO.ALLY_AOE:
				target_pick = ENUM_BATTLE_INFO.ALLY_AOE
				case_aoe_elly = true
			elif code == ENUM_BATTLE_INFO.ENEM_AOE:
				target_pick = ENUM_BATTLE_INFO.ENEM_AOE
				case_aoe_enem = true
		elif code in [ENUM_BATTLE_INFO.SINGLE_ALLY, ENUM_BATTLE_INFO.SINGLE_ENEM]:
			if code == ENUM_BATTLE_INFO.SINGLE_ALLY:
				target_pick = ENUM_BATTLE_INFO.SINGLE_ALLY
				case_single_ally = true
			elif code == ENUM_BATTLE_INFO.SINGLE_ENEM:
				target_pick = ENUM_BATTLE_INFO.SINGLE_ENEM
				case_single_enem = true
	var get_caster_icon:TextureRect = get_node("%battle_info_target_icon")
	var get_caster_name:Label = get_node("%battle_info_target_txt")
	var get_caster_rank:Label = get_node("%battle_info_target_tier_rank")
	var get_target_panel:PanelContainer = get_node("%battle_info_target_panel")
	var get_target_header:Label = get_node("%battle_info_target_header")
	
	var get_icon_allhero = str("res://img/Hero/icon/ALL_HERO.png")
	var get_icon_allenem = str("res://img/Hero/icon/ALL_ENEM.png")
	if case_main:
		get_caster_icon.texture = load(get_icon)
		get_caster_name.text = str(_get_card_name) 
		if target_pick.card_type_confirm == "hero":
			get_target_panel.theme = panel_blue
			get_target_header.text = str("ALLY")
			battle_info_isindicator_support(true)
		elif target_pick.card_type_confirm == "enemy":
			get_target_panel.theme = panel_red
			get_target_header.text = str("ENEMY")
			battle_info_isindicator_support(false)
		match get_rank:
			0: get_caster_rank.text = str("1")
			1: get_caster_rank.text = str("2")
			2: get_caster_rank.text = str("3")
			3: get_caster_rank.text = str("4")
			4: get_caster_rank.text = str("5")
			5: get_caster_rank.text = str("6")
	elif case_aoe_elly:
		get_caster_icon.texture = load(get_icon_allhero)
		get_caster_name.text = str("ALL ALLY")
		get_target_panel.theme = panel_blue
		get_target_header.text = str("ALLY")
		get_caster_rank.text = str("-")
		battle_info_isindicator_support(true)
	elif case_aoe_enem:
		get_caster_icon.texture = load(get_icon_allenem)
		get_caster_name.text = str("ALL ENEMY")
		get_target_panel.theme = panel_red
		get_target_header.text = str("ENEMY")
		get_caster_rank.text = str("-")
		battle_info_isindicator_support(false)
	elif case_single_ally:
		print("MASUK ALLY")
		get_caster_icon.texture = load("res://img/Hero/icon/[START]_0.png")
		get_caster_name.text = str("RANDOM ALLY")
		get_target_panel.theme = panel_blue
		get_target_header.text = str("ALLY")
		get_caster_rank.text = str("-")
		battle_info_isindicator_support(true)
	elif case_single_enem:
		print("MASUK ENEM")
		get_caster_icon.texture = load("res://img/Hero/icon/[START]_0.png")
		get_caster_name.text = str("RANDOM ENEMY")
		get_target_panel.theme = panel_red
		get_target_header.text = str("ENEMY")
		get_caster_rank.text = str("-")
		battle_info_isindicator_support(false)
		
func battle_info_isindicator_support(_bool:bool):
	if battle_started:
		var icon_indic:TextureRect = get_node("%battle_info_indic")
		if _bool: icon_indic.texture = load("res://img/UI/battle_info/battle_info_support.png")
		else: icon_indic.texture = load("res://img/UI/battle_info/battle_info_attack.png")
func battle_info_skill_confirm(caster):
	if battle_started:
		var current_card = arr_turn[turn_begin_main]
		if caster == current_card:
			var get_skill_header:Label = get_node("%battle_info_skill_confirm")
			match caster.skill_confirm:
				"skill_0": get_skill_header.text = str("BASIC SKILL")
				"skill_1": get_skill_header.text = str("SKILL 1")
				"skill_2": get_skill_header.text = str("SKILL 2")
				"skill_ulti": get_skill_header.text = str("ULTIMATE SKILL")

func hover_out_allcard():
	var _allcard = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in _allcard:value.hover_reset()

func enable_allbtn_select():
	disable_btn_select_enemy(false)
	disable_btn_select_hero(false)
	
enum ENUM_SKILL_CONFRIM{BUFF_SINGLE, BUFF_AOE, DEBUFF_SINGLE, DEBUFF_AOE, HEAL_SINGLE, HEAL_AOE, FOCUS_SINGLE, FOCUS_AOE}
var indocator_skill_conrifm_activated = false
var indicator_skill_confirm_temp = ""
var indikator_skill_temp:int = 99
func disable_indicator_skill_confirm():
	var all_card = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in all_card: value.enable_skill_confirm(false, ENUM_SKILL_CONFRIM.BUFF_SINGLE)
func battle_info_skill_check_attack(_bool:bool, code_skill:int, caster:Node2D):
	var main_state
	if _bool: main_state=ENUM_BATTLE_INFO.SINGLE_ENEM
	else: main_state=ENUM_BATTLE_INFO.SINGLE_ALLY
	match code_skill:
		1: if caster.skill_1_cd !=0: set_info_battle_target(main_state)
		2: if caster.skill_2_cd !=0: set_info_battle_target(main_state)
		3: if caster.skill_ulti_cd !=0: set_info_battle_target(main_state)
func indicator_skill_confrim(_skill_code:int, _node:Node2D):
	var get_all_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	var get_all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	
	if _node.card_type_confirm == "hero" and arr_turn[turn_begin_main] == _node:
		match _skill_code:
			0: indicator_skill_confirm_temp = _node.skill_0_target
			1: indicator_skill_confirm_temp = _node.skill_1_target
			2: indicator_skill_confirm_temp = _node.skill_2_target
			3: indicator_skill_confirm_temp = _node.skill_ulti_target
		if indicator_skill_confirm_temp == _node.indicator_skill_confirm_temp and indikator_skill_temp == _skill_code:
			indocator_skill_conrifm_activated = !indocator_skill_conrifm_activated
			_node.indicator_skill_confirm_temp = ""
			disable_indicator_skill_confirm()
			disable_btn_select_enemy(false)
			disable_btn_select_hero(false)
		else:
			indikator_skill_temp = _skill_code
			var main_code = ""
			match _skill_code:
				0: main_code = _node.skill_0_target
				1: main_code = _node.skill_1_target
				2: main_code = _node.skill_2_target
				3: main_code = _node.skill_ulti_target
			_node.indicator_skill_confirm_temp = main_code
			match main_code:
				"single":
					enable_allbtn_select()
					disable_indicator_skill_confirm()
					disable_btn_select_hero(true)
					set_info_battle_target(ENUM_BATTLE_INFO.SINGLE_ENEM)
					battle_info_skill_check_attack(true, _skill_code, _node)
					match _skill_code:
						0: 
							if _node.skill_0_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_SINGLE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_SINGLE)
						1: 
							if _node.skill_1_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_SINGLE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_SINGLE)
						2: 
							if _node.skill_2_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_SINGLE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_SINGLE)
						3: 
							if _node.skill_3_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_SINGLE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_SINGLE)
				"aoe":
					enable_allbtn_select()
					disable_indicator_skill_confirm()
					disable_btn_select_enemy(true)
					disable_btn_select_hero(true)
					set_info_battle_target(ENUM_BATTLE_INFO.ENEM_AOE)
					battle_info_skill_check_attack(true, _skill_code, _node)
					match _skill_code:
						0:
							if _node.skill_0_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_AOE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_AOE)
						1:
							if _node.skill_1_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_AOE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_AOE)
						2:
							if _node.skill_2_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_AOE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_AOE)
						3:
							if _node.skill_3_debuff_confirm:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.DEBUFF_AOE)
							else:for value in get_all_enem: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.FOCUS_AOE)
				"single_spell":
					enable_allbtn_select()
					disable_indicator_skill_confirm()
					disable_btn_select_enemy(true)
					for value in get_all_hero: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.BUFF_SINGLE)
					set_info_battle_target(ENUM_BATTLE_INFO.SINGLE_ALLY)
					battle_info_skill_check_attack(true, _skill_code, _node)
				"aoe_spell":
					enable_allbtn_select()
					disable_indicator_skill_confirm()
					disable_btn_select_hero(true)
					disable_btn_select_enemy(true)
					for value in get_all_hero: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.BUFF_AOE)
					set_info_battle_target(ENUM_BATTLE_INFO.ALLY_AOE)
					battle_info_skill_check_attack(true, _skill_code, _node)
				"single_heal":
					enable_allbtn_select()
					disable_indicator_skill_confirm()
					disable_btn_select_enemy(true)
					for value in get_all_hero: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.HEAL_SINGLE)
					set_info_battle_target(ENUM_BATTLE_INFO.SINGLE_ALLY)
					battle_info_skill_check_attack(true, _skill_code, _node)
				"aoe_heal":
					enable_allbtn_select()
					disable_indicator_skill_confirm()
					disable_btn_select_hero(true)
					disable_btn_select_enemy(true)
					for value in get_all_hero: value.enable_skill_confirm(true, ENUM_SKILL_CONFRIM.HEAL_AOE)
					set_info_battle_target(ENUM_BATTLE_INFO.ALLY_AOE)
					battle_info_skill_check_attack(true, _skill_code, _node)
	else: print("not your turn")

var temp_caster_slot # player akan di isi disni
var temp_caster_skill # code skill caster
var temp_enemy_slot  # enemy akan di isi disini
var temp_enemy_skill # code skill enemy

func set_elem_pairs():
	var get_hero = [arr_hero_pos[0],arr_hero_pos[1],arr_hero_pos[2]]
	var get_enem = [arr_enemy_pos[0],arr_enemy_pos[1],arr_enemy_pos[2]]
	var get_anim_hero:AnimatedSprite2D = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer3/elem_pairs_hero
	var get_anim_enem:AnimatedSprite2D = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer3/elem_pairs_enemy
	var get_label_hero:Label = get_node("%bonus_stat_elem_hero")
	var get_label_enem:Label = get_node("%bonus_stat_elem_enem")
	
	var hero_light=0
	var hero_nature=0
	var hero_water=0
	var hero_dark=0
	var hero_fire=0
	
	var enem_light=0
	var enem_nature=0
	var enem_water=0
	var enem_dark=0
	var enem_fire=0
	
	var hero_label:String=""
	var enem_label:String=""
	
	for value in get_hero:
		if value._hero_elemen == ELEM.LIGHT: hero_light+=1
		elif value._hero_elemen == ELEM.NATURE: hero_nature+=1
		elif value._hero_elemen == ELEM.WATER: hero_water+=1
		elif value._hero_elemen == ELEM.DARK: hero_dark+=1
		elif value._hero_elemen == ELEM.FIRE: hero_fire+=1
	for value in get_enem:
		if value._hero_elemen == ELEM.LIGHT: enem_light+=1
		elif value._hero_elemen == ELEM.NATURE: enem_nature+=1
		elif value._hero_elemen == ELEM.WATER: enem_water+=1
		elif value._hero_elemen == ELEM.DARK: enem_dark+=1
		elif value._hero_elemen == ELEM.FIRE: enem_fire+=1
	
	var total_hero = [hero_light,hero_nature,hero_water,hero_dark,hero_fire]
	var total_enem = [enem_light,enem_nature,enem_water,enem_dark,enem_fire]
	for value in range(5):
		if total_hero[value] == 3:
			for _value in get_hero: _value.stat_elem_pairs(10)
			hero_label+=str("+10% Attack & Defense\n(all unit)\n")
			match value:
				0:
					for count in get_hero: count.stat_elem_light(10)
					hero_label+=str("Turn Speed: +10%\nSpeed attack: +10%\n(all light)\n")
					get_anim_hero.play("light_3")
				1:
					for count in get_hero: count.stat_elem_nature(10)
					hero_label+=str("attack: +10%\nhealth: +10%\n(all nature)")
					get_anim_hero.play("nature_3")
				2:
					for count in get_hero: count.stat_elem_water(10)
					hero_label+=str("health: +10%\ncritical defense: +10%\n(all water)")
					get_anim_hero.play("water_3")
				3:
					for count in get_hero: count.stat_elem_dark(10)
					hero_label+=str("critical rate: +10%\nevation: +10%\n(all dark)")
					get_anim_hero.play("dark_3")
				4:
					for count in get_hero: count.stat_elem_fire(10)
					hero_label+=str("critical rate: +10%\ncritical damage: +100%\n(all fire)")
					get_anim_hero.play("fire_3")
		elif total_hero[value] == 2:
			for _value in get_hero: _value.stat_elem_pairs(5)
			hero_label+=str("5% Attack & Defense\n(all unit)\n")
			match value:
				0:
					for count in get_hero: count.stat_elem_light(5)
					hero_label+=str("Turn Speed: +5%\nSpeed attack: +5%\n(all light)")
					get_anim_hero.play("light_2")
				1:
					for count in get_hero: count.stat_elem_nature(5)
					hero_label+=str("attack: +5%\nhealth: +5%\n(all nature)")
					get_anim_hero.play("nature_2")
				2:
					for count in get_hero: count.stat_elem_water(5)
					hero_label+=str("health: +5%\ncritical defense: +5%\n(all water)")
					get_anim_hero.play("water_2")
				3:
					for count in get_hero: count.stat_elem_dark(5)
					hero_label+=str("critical rate: +5%\nevation: +5%\n(all dark)")
					get_anim_hero.play("dark_2")
				4:
					for count in get_hero: count.stat_elem_fire(5)
					hero_label+=str("critical rate: +5%\ncritical damage: +50%\n(all fire)")
					get_anim_hero.play("fire_2")
					
		if total_enem[value] == 3:
			for _value in get_enem: _value.stat_elem_pairs(10)
			enem_label+=str("10% Attack & Defense\n(All card)\n")
			match value:
				0:
					for count in get_enem: count.stat_elem_light(10)
					enem_label+=str("Turn Speed: +10%\nSpeed attack: +10%\n(all light)")
					get_anim_enem.play("light_3")
				1:
					for count in get_enem: count.stat_elem_nature(10)
					enem_label+=str("attack: +10%\nhealth: +10%\n(all nature)")
					get_anim_enem.play("nature_3")
				2:
					for count in get_enem: count.stat_elem_water(10)
					enem_label+=str("health: +10%\ncritical defense: +10%\n(all water)")
					get_anim_enem.play("water_3")
				3:
					for count in get_enem: count.stat_elem_dark(10)
					enem_label+=str("critical rate: +10%\nevation: +10%\n(all dark)")
					get_anim_enem.play("dark_3")
				4:
					for count in get_enem: count.stat_elem_fire(10)
					enem_label+=str("critical rate: +10%\ncritical damage: +100%\n(all fire)")
					get_anim_enem.play("fire_3")
		elif total_enem[value] == 2:
			for _value in get_enem: _value.stat_elem_pairs(5)
			enem_label+=str("20% Attack & Defense\n(all unit)\n")
			match value:
				0:
					for count in get_enem: count.stat_elem_light(5)
					enem_label+=str("Turn Speed: +5%\nSpeed attack: +5%\n(all light)")
					get_anim_enem.play("light_2")
				1:
					for count in get_enem: count.stat_elem_nature(5)
					enem_label+=str("attack: +5%\nhealth: +5%\n(all nature)")
					get_anim_enem.play("nature_2")
				2:
					for count in get_enem: count.stat_elem_water(5)
					enem_label+=str("health: +5%\ncritical defense: +5%\n(all water)")
					get_anim_enem.play("water_2")
				3:
					for count in get_enem: count.stat_elem_dark(5)
					enem_label+=str("critical rate: +5%\nevation: +5%\n(all dark)")
					get_anim_enem.play("dark_2")
				4:
					for count in get_enem: count.stat_elem_fire(20)
					enem_label+=str("critical rate: +5%\ncritical damage: +50%\n(all fire)")
					get_anim_enem.play("fire_2")
					
	get_label_hero.text=str(hero_label)
	get_label_enem.text=str(enem_label)

func limit_hp_card(caster):
	if caster.get_health > caster._heatlh_limit:
		var hp_to_rm = caster._heatlh_limit - caster.get_health
		caster.stat_health(hp_to_rm)
# SIGNAL BATTLE START
var btn_turn = false
func _btn_set_turn():
	battle_started = true
	var get_btn_battle_start:Button = get_node("%Battle_start")
	get_btn_battle_start.disabled = true
	var get_btn_anim:AnimatedSprite2D = $PanelContainer/VBoxContainer/Battle_start/anim_btn_fire_0
	get_btn_anim.stop()
	get_btn_anim.visible = false
	disable_btn_select_enemy(true)
	disable_btn_select_hero(true)
	for value in range(3):
		arr_enemy_pos[value].skill_cd_started()
		arr_enemy_pos[value]._default_stat_started()
		arr_hero_pos[value].skill_cd_started()
		arr_hero_pos[value]._default_stat_started()
		#if value == 3:
	var all_card = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var all_skill = [arr_hero_skill[0], arr_hero_skill[1], arr_hero_skill[2], arr_enemy_skill[0], arr_enemy_skill[1], arr_enemy_skill[2]]
	for _value in range(6): load_skill(0, all_card[_value], all_skill[_value])
	
	btn_turn = true
	set_turn()
	turn_begin()
	set_elem_pairs()
	tween_exp_score(true)
	
func get_arr_index(array: Array, value):
	var index = array.find(value)
	return index
	
func btn_attack_disabled(_bool:bool):
	var btn_attack:Button = get_node("%Attack")
	btn_attack.disabled = _bool
func enable_icon_target_onenemy(_bool:bool, _code: int):
	if _bool: for i in range(3): arr_enemy_pos[i].enable_icon_turn(i == _code, ENUM_ICON_TURN.ATTACKED)
	elif _bool == false: for value in range(3): arr_enemy_pos[value].enable_icon_turn(_bool, ENUM_ICON_TURN.ATTACKED)

var turn_begin_main = 0
func turn_action_reset():
	var all_action = arr_turn.all(func(value): return value.turn_action)
	if all_action:
		for value in arr_turn:
			value.turn_action = false
			if value.get_health == 0: value.turn_action = true
			elif value.skill_amimir_inflict: value.turn_action = true
			elif value.skill_stun_inflict: value.turn_action = true
		turn_begin_main+=1
		turn_bm_reset()
	set_turn()

var new_turn_total_hp_ally:int = 0
var new_turn_total_hp_ally_over:int = 0
var new_turn_bool = false
func new_turn():
	var data_topunish = [1,5,10,15]
	battle_round_main_count+=1
	battle_round_main.text=str(battle_round_main_count)
	if battle_round_main_count in data_topunish or battle_round_main_count>20:
		if new_turn_bool==false:
			new_turn_bool=true
			var all_hero = [arr_hero_pos[0],arr_hero_pos[1],arr_hero_pos[2]]
			for value in all_hero:
				new_turn_total_hp_ally+=value._default_hp
		if battle_round_main_count>20:
			await get_tree().create_timer(2).timeout
			var all_hero = [arr_hero_pos[0],arr_hero_pos[1],arr_hero_pos[2]]
			var punishment_temp = get_pct(new_turn_total_hp_ally, 200)
			punishment_tween(punishment_temp, 1.0)
			for value in all_hero:
				value.stat_health(-punishment)
				value.anim_attack(0)
				value.set_fdmg(punishment, 1)
				value.fdmg()
			SfxManager.play_explosion()
			await get_tree().create_timer(2).timeout
		else:
			var punishment_temp
			var all_hero = [arr_hero_pos[0],arr_hero_pos[1],arr_hero_pos[2]]
			match battle_round_main_count:
				1:punishment_temp = get_pct(new_turn_total_hp_ally, 5)
				5:punishment_temp = get_pct(new_turn_total_hp_ally, 10)
				10:punishment_temp = get_pct(new_turn_total_hp_ally, 20)
				15:punishment_temp = get_pct(new_turn_total_hp_ally, 90)
			punishment_tween(punishment_temp, 1.0)
			var to_punish = [5,10,15]
			if battle_round_main_count in to_punish:
				await get_tree().create_timer(2).timeout
				for value in all_hero:
					value.stat_health(-punishment)
					value.anim_attack(0)
					value.set_fdmg(punishment, 1)
					value.fdmg()
				SfxManager.play_explosion()
				await get_tree().create_timer(2).timeout
		if battle_round_main_count>=battle_round_total_count:
			if battle_round_main_count>20: battle_round_total_count+=1
			else: battle_round_total_count+=5
			battle_round_total.text=str(battle_round_total_count)

func punishment_tween(new_value:int, time:float):
	var tween :=get_tree().create_tween()
	var main_sim = punishment+new_value
	tween.tween_method(punishment_txt, punishment, main_sim, time)
	punishment=new_value
func punishment_txt(value:int):
	punishment_total.text = str(filter_num_k(value))
	SfxManager.play_score()

var battle_round_main_count:int = 0
var battle_round_total_count:int = 5
var punishment:int = 0
func turn_bm_reset():
	if turn_begin_main >5: turn_begin_main= 0
	new_turn()
func turn_check():
	var arr_blacklist = []
	var arr_whitelist = []
	## RESET ALL TURN (NEXT ROUND)
	turn_action_reset()
	for value in range(arr_turn.size()):
		if !arr_blacklist.has(value):
			if arr_turn[value].get_health == 0: arr_blacklist.append(value)
			elif arr_turn[value].skill_amimir_inflict: arr_blacklist.append(value)
			elif arr_turn[value].skill_stun_inflict: arr_blacklist.append(value)
			elif arr_turn[value].turn_action:arr_blacklist.append(value)
			else: arr_whitelist.append(value)
	if arr_blacklist.size()>=6:
		print("RESET")
		arr_blacklist.clear()
		arr_whitelist.clear()
		for value in arr_turn:
			value.turn_action = false
			if value.get_health == 0: value.turn_action = true
			elif value.skill_amimir_inflict: value.turn_action = true
			elif value.skill_stun_inflict: value.turn_action = true
		var infi_stop = 0
		while arr_turn[turn_begin_main].get_health == 0 and infi_stop<10:
			turn_begin_main+=1
			infi_stop+=1
			turn_bm_reset()
		set_turn()
		for value in range(arr_turn.size()):
			if !arr_blacklist.has(value):
				if arr_turn[value].get_health == 0:arr_blacklist.append(value)
				elif arr_turn[value].skill_amimir_inflict:arr_blacklist.append(value)
				elif arr_turn[value].skill_stun_inflict:arr_blacklist.append(value)
				elif arr_turn[value].turn_action:arr_blacklist.append(value)
	print(str("BLACK: ",arr_blacklist))
	print(str("WHITE: ",arr_whitelist))
	set_turn_icon(arr_whitelist, arr_blacklist)
	if !arr_whitelist.is_empty(): turn_begin_main = arr_whitelist[0]
	
	var arr_count = [1, 2, 3, 4, 5, 6]
	
	for value in arr_whitelist:
		for count in range(7):
			var rng = get_random_int(1, 6)
			arr_turn[value].update_turn_count(rng)
			await get_tree().create_timer(.01).timeout
		arr_turn[value].update_turn_count(arr_count[0])
		arr_count.remove_at(0)

	for value in arr_blacklist:
		arr_turn[value].update_turn_count("W")
	for value in arr_turn:
		if value.get_health == 0:value.update_turn_count(0)
	turn_action_reset()
	
var arr_turn_hov = []
var arr_turn_hov_herotype = []
var arr_turn_hov_code
func set_turn_icon(arr_white:Array, arr_black:Array):
	# SET ICON
	var arr_all_icon=[
		$container_turn/HBoxContainer/turn_0,
		$container_turn/HBoxContainer/turn_1,
		$container_turn/HBoxContainer/turn_2,
		$container_turn/HBoxContainer/turn_3,
		$container_turn/HBoxContainer/turn_4,
		$container_turn/HBoxContainer/turn_5,
	]
	var arr_all_icon_desc = [
		$container_turn/HBoxContainer/char_stat_0,
		$container_turn/HBoxContainer/char_stat_1,
		$container_turn/HBoxContainer/char_stat_2,
		$container_turn/HBoxContainer/char_stat_3,
		$container_turn/HBoxContainer/char_stat_4,
		$container_turn/HBoxContainer/char_stat_5,
	]
	var get_card_s1 = Card_data_s1.new()
	var main_arr = []
	var temp_arr_black = []
	if !arr_white.is_empty(): for value in arr_white: main_arr.append(value)
	if !arr_black.is_empty():
		for value in arr_black: temp_arr_black.append(value)
		for value in temp_arr_black.size():
			var temp = temp_arr_black[value]
			if arr_turn[temp_arr_black[value]].get_health == 0:
				temp_arr_black.remove_at(value)
				temp_arr_black.append(temp)
		for value in temp_arr_black: main_arr.append(value)
	
	if main_arr.size() < 6:
		for value in range(6): if !main_arr.has(value): main_arr.append(value)
		for value in main_arr:
			var temp = value
			if arr_turn[value].get_health == 0:
				main_arr.remove_at(value)
				main_arr.append(temp)
	
	arr_turn_hov.clear()
	arr_turn_hov_herotype.clear()
	for value in range(6):
		var code = arr_turn[main_arr[value]].card_code
		var hero_type = arr_turn[main_arr[value]].card_type_confirm
		arr_turn_hov.append(code)
		arr_turn_hov_herotype.append(hero_type)
		arr_all_icon[value].texture = load(get_card_s1.dict_all_card_s1[code]["icon"])
		arr_all_icon_desc[value].text = str(arr_turn[main_arr[value]].card_type_confirm)

#  ----------- TURN COLLITION -----------
var turn_icon_availabel = false
func disable_all_turn_hov():
	var _allcard = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in _allcard: value.is_active_col(false)
	var all_icon = [
		$container_turn/HBoxContainer/turn_0,
		$container_turn/HBoxContainer/turn_1,
		$container_turn/HBoxContainer/turn_2,
		$container_turn/HBoxContainer/turn_3,
		$container_turn/HBoxContainer/turn_4,
		$container_turn/HBoxContainer/turn_5,
	]
	for value in all_icon.size():
		all_icon[value].scale = Vector2(1,1)
func turn_col_select(code):
	SfxManager.play_turn_select()
	var all_icon = [
		$container_turn/HBoxContainer/turn_0,
		$container_turn/HBoxContainer/turn_1,
		$container_turn/HBoxContainer/turn_2,
		$container_turn/HBoxContainer/turn_3,
		$container_turn/HBoxContainer/turn_4,
		$container_turn/HBoxContainer/turn_5,
	]
	all_icon[code].scale = Vector2(1.2, 1.2)
	if arr_turn_hov.is_empty() or arr_turn_hov_herotype.is_empty():
		print("Battle has not begin")
	else:
		if turn_icon_availabel:
			var _allcard = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
			for value in _allcard: 
				if value.card_code == arr_turn_hov[code] and value.card_type_confirm == arr_turn_hov_herotype[code]: value.is_active_col(true)
		else: print("Card not ready")
func turn_0_colen() -> void:
	arr_turn_hov_code = 0
	turn_col_select(arr_turn_hov_code)
	$container_turn/HBoxContainer/turn_0/container.visible = true
func turn_0_colex() -> void:
	disable_all_turn_hov()
	$container_turn/HBoxContainer/turn_0/container.visible = false
func turn_01_colen() -> void:
	arr_turn_hov_code = 1
	turn_col_select(arr_turn_hov_code)
	$container_turn/HBoxContainer/turn_1/container.visible = true
func turn_01_colex() -> void:
	disable_all_turn_hov()
	$container_turn/HBoxContainer/turn_1/container.visible = false
func turn_02_colen() -> void:
	arr_turn_hov_code = 2
	turn_col_select(arr_turn_hov_code)
func turn_02_colex() -> void:disable_all_turn_hov()
func turn_03_colen() -> void:
	arr_turn_hov_code = 3
	turn_col_select(arr_turn_hov_code)
func turn_03_colex() -> void:disable_all_turn_hov()
func turn_04_colen() -> void:
	arr_turn_hov_code = 4
	turn_col_select(arr_turn_hov_code)
func turn_04_colex() -> void:disable_all_turn_hov()
func turn_05_colen() -> void:
	arr_turn_hov_code = 5
	turn_col_select(arr_turn_hov_code)
func turn_05_colex() -> void:disable_all_turn_hov()
	
var arr_turn = [] # FIRST INDEX WHO HERO OR ENEMY WITH HIGHEST TURN SPEED AND LAST INDEX IS HERO OR ENEMY WHO HAVE LOWEST TURN SPEED. HERO FISRT WHEN HAVE EQUAL VALUE
var arr_turn_code = [0, 0, 0, 0, 0, 0] # REPLACE WHEN CALL FUNC set_turn()
func set_turn():
	var arr_temp = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var arr_temp_code = [arr_hero_skill[0], arr_hero_skill[1], arr_hero_skill[2], arr_enemy_skill[0], arr_enemy_skill[1], arr_enemy_skill[2]]
	
	# RESET TO RECALCULATE
	arr_turn.clear()
	arr_turn_code.clear()
	arr_turn_code = [0, 0, 0, 0, 0, 0]
	arr_turn = []
	
	if arr_hero_pos.size() == 3 and arr_enemy_pos.size() == 3:
		for value in arr_temp:
			if arr_turn.size() == 0:
				arr_turn.append(value)
			elif arr_turn.size() > 0 and value.get_speed > arr_turn[0].get_speed:
				arr_turn.insert(0, value)
			elif arr_turn.size() > 1 and value.get_speed > arr_turn[1].get_speed:
				arr_turn.insert(1, value)
			elif arr_turn.size() > 2 and value.get_speed > arr_turn[2].get_speed:
				arr_turn.insert(2, value)
			elif arr_turn.size() > 3 and value.get_speed > arr_turn[3].get_speed:
				arr_turn.insert(3, value)
			elif arr_turn.size() > 4 and value.get_speed > arr_turn[4].get_speed:
				arr_turn.insert(4, value)
			else:
				arr_turn.append(value)
		
		# SET CODE SAME AS INDEX HERO
		var index_temp = 0
		for value in arr_temp:
			arr_turn_code[get_arr_index(arr_turn, value)] = arr_temp_code[index_temp]
			index_temp += 1
			
	else:
		if arr_hero_pos != 3 and arr_enemy_pos != 3:
			print("Slot hero dan enemy belum penuh")
		elif arr_hero_pos != 3:
			print("Hero slot belum penuh")
		elif arr_enemy_pos != 3:
			print("Enemy slot belum penuh")

# Return card node.name, hero or enemy
func get_card_name(_node):
	var node_name = _node.name.to_lower()
	if "hero" in node_name: return "hero"
	elif "enemy" in node_name: return "enemy"
	else: print("func get_card_name error")
func get_card_border(caster, code):caster.mainFrame_change(code)

func select_all_enem(_bool:bool):
	var all_enem = [arr_enemy_pos[0],arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in all_enem:
		value.enable_anim_turn_begin(_bool, ENUM_SELECT_HERO.ENEMY)
		
func select_single_enem(_bool:bool, _enem):
	var all_enem = [arr_enemy_pos[0],arr_enemy_pos[1], arr_enemy_pos[2]]
	var count = 0
	if _bool:
		for value in all_enem:
			value.enable_anim_turn_begin(count == _enem, ENUM_SELECT_HERO.ENEMY)
			count += 1
	elif _bool == false: for value in all_enem: value.enable_anim_turn_begin(false, ENUM_SELECT_HERO.ENEMY)

enum ENUM_ICON_TURN{ATTACKER, ATTACKED, HEAL, BUFF}
enum ENUM_SELECT_HERO {HERO, ENEMY}
func turn_begin():
	if battle_done == false:
		turn_check()
		tween_exherosurvived_check()
		check_turn_has_end()
		arr_turn[turn_begin_main].enable_anim_turn_begin(true, ENUM_SELECT_HERO.HERO)
		arr_turn[turn_begin_main].enable_icon_turn(true, ENUM_ICON_TURN.ATTACKER) # Activated icon attack, terget, etc.
		hover_out_allcard()
		arr_turn[turn_begin_main].hover_start()
		if get_card_name(arr_turn[turn_begin_main]) == "hero":
			SfxManager.play_isheroturn(true)
			disable_btn_select_enemy(false)
			btn_attack_disabled(false)
			btn_atk_hero_turn = arr_turn[turn_begin_main]
			btn_atk_hero_code = arr_turn_code[turn_begin_main]
			tween_time()
		elif get_card_name(arr_turn[turn_begin_main]) == "enemy":
			SfxManager.play_isheroturn(false)
			arr_turn[turn_begin_main].enable_anim_turn_begin(true, ENUM_SELECT_HERO.HERO)
			arr_turn[turn_begin_main].disable_all_skill_confirm(true)
			btn_attack_disabled(true)
			disable_btn_select_enemy(true)
			btn_atkd_hero_turn = arr_hero_pos[ai_select_hero()]
			btn_atkd_hero_code = arr_hero_skill[ai_select_hero()]
			btn_atkd_enem_turn = arr_turn[turn_begin_main]
			btn_atkd_enum_code = arr_turn_code[turn_begin_main]
			
			var rand_time = get_random_int(1, 3)
			await get_tree().create_timer(rand_time).timeout
			arr_turn[turn_begin_main].disable_all_skill_confirm(false)
			arr_turn[turn_begin_main].enable_anim_turn_begin(false, ENUM_SELECT_HERO.HERO)
			_btn_attack_hero()
		set_info_battle_caster(arr_turn[turn_begin_main])
		info_battle_reset()
	else: print("Battle is done")

# Return lowes hp index by arr_hero_pos
enum AI_ELEM{LIGHT=0, NATURE, WATER, DARK, FIRE}
func ai_select_hero():
	var taunt_confirm = false
	var taunt_temp = []
	var all_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	
	for value in all_hero: 
		if value._defense_taunt and value.get_health !=0 and arr_turn[turn_begin_main]._anti_taunt == false:
			taunt_confirm = true
			taunt_temp.append(value)
	
	if taunt_confirm:
		var rng = randi() % taunt_temp.size()
		var selected_enemy = taunt_temp[rng]
		var _get_index = all_hero.find(selected_enemy)
		return _get_index
	elif taunt_confirm == false:
		var rng = get_random_int(1, 100)
		if rng <= 80:
			# SELECT WEAK ELEM
			var caster_elem = arr_turn[turn_begin_main]._hero_elemen
			var select_lowest_hero_hp = null
			for value in all_hero:
				if caster_elem == AI_ELEM.LIGHT and value._hero_elemen == AI_ELEM.DARK and value.get_health !=0: select_lowest_hero_hp = value
				elif caster_elem == AI_ELEM.DARK and value._hero_elemen == AI_ELEM.LIGHT and value.get_health !=0: select_lowest_hero_hp = value
				elif caster_elem == AI_ELEM.FIRE and value._hero_elemen == AI_ELEM.NATURE and value.get_health !=0: select_lowest_hero_hp = value
				elif caster_elem == AI_ELEM.NATURE and value._hero_elemen == AI_ELEM.WATER and value.get_health !=0: select_lowest_hero_hp = value
				elif caster_elem == AI_ELEM.WATER and value._hero_elemen == AI_ELEM.FIRE and value.get_health !=0: select_lowest_hero_hp = value
			
			if select_lowest_hero_hp == null:
				for value in all_hero:
					if value.get_health !=0 and select_lowest_hero_hp == null: select_lowest_hero_hp = value
					elif value.get_health !=0 and value.get_health < select_lowest_hero_hp.get_health: select_lowest_hero_hp = value
				if select_lowest_hero_hp == null:
					select_lowest_hero_hp = get_random_int(0, 2)
					return select_lowest_hero_hp
			
			var _get_index = all_hero.find(select_lowest_hero_hp)
			print(str("HERO SELECT: ",_get_index))
			return _get_index
		else:
			# SELECT HERO LOWEST HP
			var select_lowest_hero_hp = null
			for value in all_hero:
				if value.get_health !=0 and select_lowest_hero_hp == null: select_lowest_hero_hp = value
				elif value.get_health !=0 and value.get_health < select_lowest_hero_hp.get_health: select_lowest_hero_hp = value
			if select_lowest_hero_hp == null:
				select_lowest_hero_hp = get_random_int(0, 2)
				return select_lowest_hero_hp
			var _get_index = all_hero.find(select_lowest_hero_hp)
			return _get_index

func skill_stun_check():
	var _allcard = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in _allcard:
		if value.get_health !=0:
			value.skill_stun_trigger_self()
enum ENUM_MIMIR_CHECK{HERO, ENEMY}
func skill_amimir_rngreset(card_stat:ENUM_MIMIR_CHECK):
	var main_arr = []
	const main_chances = 15
	match card_stat:
		ENUM_MIMIR_CHECK.HERO:main_arr = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		ENUM_MIMIR_CHECK.ENEMY:main_arr = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var rng = get_random_int(1, 100)
	if rng <= main_chances:
		for value in main_arr:
			if value.skill_amimir_inflict and value.get_health !=0:
				value.skill_amimir_reset()
func btn_battle_end_retry() -> void:
	var get_loading_scrn = load("res://scenes/main_loading_screen.tscn")
	get_tree().change_scene_to_packed(get_loading_scrn)

func set_custom_time(delay: float) -> void:
	var timer = Timer.new()
	timer.wait_time = delay
	timer.one_shot = true
	add_child(timer)  # Tambahkan timer ke node agar berfungsi
	timer.start()

	await timer.timeout  # Tunggu hingga timer selesai
	print("Time is up!")  # Ganti dengan logika Anda

	timer.queue_free()  # Hapus timer setelah selesai

func star_win(count: int) -> void:
	count = clamp(count, 0, 3)  # Pastikan count antara 0-3
	var get_visible = [$Camera2D/star_1, $Camera2D/star_2, $Camera2D/star_3]
	$Camera2D/StarContainer.visible = true
	for value in get_visible: value.visible = false
	var get_anim: AnimationPlayer = $anim_star_win
	var data_anim = ["star_1", "star_2", "star_3"]
	if count == 0:
		return
	for value in range(count):
		get_visible[value].visible = true
		SfxManager.play_star_drop()  # Mainkan efek suara
		get_anim.play(data_anim[value])  # Putar animasi berdasarkan jumlah bintang
		await get_anim.animation_finished

var battle_done:bool = false
func check_turn_has_end():
	var allcard = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2], arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	var get_trans_scr = $Camera2D/MainBlackTrans
	var get_ss:AnimatedSprite2D = $Camera2D/animss_winstat
	var get_btn_retrty = $Camera2D/btn_battle_end_retry
	var get_btn_exit = $Camera2D/btn_battle_end_exit
	var get_bannerflag = $Camera2D/BannerFlag00
	var final_statistic_panel:PanelContainer = $Camera2D/final_statistic
	
	if allcard[0].get_health == 0 and allcard[1].get_health == 0 and allcard[2].get_health == 0:
		AutoloadData.system_level_manager(randi_range(500, 700))
		$Camera2D/btn_battle_end_retry.disabled = true
		$Camera2D/btn_battle_end_exit.disabled = true
		AutoloadData.story_update(true)
		$Camera2D/panel_reward.visible = true
		get_ss.visible = true
		get_trans_scr.visible = true
		get_btn_retrty.visible = true
		get_btn_exit.visible = true
		get_bannerflag.visible = true
		var count_win = 0
		for value in range(6):if value >= 3:if allcard[value].get_health != 0: count_win +=1
		star_win(count_win) 	
		get_ss.play("win_stat_win")
		
		for i in range(3):
			AutoloadData.roadmap_total_damages+=abs(arr_enemy_pos[i].dmg_taken)
			AutoloadData.roadmap_total_heal_taked+=arr_hero_pos[i].total_heal_recived
			AutoloadData.roadmap_total_heal_gift+=arr_hero_pos[i].total_heal
		AutoloadData.roadmap_total_battle+=1
		if AutoloadData.stage_star[AutoloadData.temp_bab][AutoloadData.temp_stage] < count_win:
			AutoloadData.stage_star[AutoloadData.temp_bab][AutoloadData.temp_stage]=count_win
		AutoloadData.save_data()
		print(AutoloadData.stage_star)
		
		#SfxManager.stop_random_bgm_battle()
		SfxManager.play_iswin(true)
		final_statistic_panel.visible=true
		set_fs(fs_bool)
		await fr_main(true)
		fr_save_score()
		$Camera2D/btn_battle_end_retry.disabled = false
		$Camera2D/btn_battle_end_exit.disabled = false
	elif allcard[3].get_health == 0 and allcard[4].get_health == 0 and allcard[5].get_health == 0:
		AutoloadData.system_level_manager(randi_range(200, 400))
		$Camera2D/btn_battle_end_retry.disabled = true
		$Camera2D/btn_battle_end_exit.disabled = true
		for i in range(3):
			AutoloadData.roadmap_total_damages+=abs(arr_enemy_pos[i].dmg_taken)
			AutoloadData.roadmap_total_heal_taked+=arr_hero_pos[i].total_heal_recived
			AutoloadData.roadmap_total_heal_gift+=arr_hero_pos[i].total_heal
		AutoloadData.roadmap_total_battle+=1
		AutoloadData.save_data()
		AutoloadData.story_update(false)
		$Camera2D/panel_reward.visible = true
		get_ss.visible = true
		get_trans_scr.visible = true
		get_btn_retrty.visible = true
		get_btn_exit.visible = true
		get_bannerflag.visible = true
		get_ss.play("win_stat_defeat")
		SfxManager.stop_random_bgm_battle()
		SfxManager.play_iswin(false)
		battle_done = true
		tween_exp_score(false) 
		var money_score_temp = int(current_score/4.0)
		current_score = money_score_temp
		tween_score(money_score_temp, 1.0)
		final_statistic_panel.visible=true
		set_fs(fs_bool)
		await fr_main(false)
		fr_save_score()
		$Camera2D/btn_battle_end_retry.disabled = false
		$Camera2D/btn_battle_end_exit.disabled = false
# BTN ATTACK HERO
var btn_atkd_hero_turn
var btn_atkd_hero_code
var btn_atkd_enem_turn
var btn_atkd_enum_code
func _btn_attack_hero():
	var allcard = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2], arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	for value in allcard:
		value.disabale_warning_cd(true)
		value.enable_icon_turn(false, ENUM_ICON_TURN.ATTACKER)
	disable_all_skill_preview()
	temp_caster_slot = btn_atkd_hero_turn
	temp_enemy_slot = btn_atkd_enem_turn
	temp_caster_skill = btn_atkd_hero_code
	temp_enemy_skill = btn_atkd_enum_code
	
	temp_enemy_slot.ai_skill_select() # select activated skill
	fdmg_anti_taunt(ENUM_TAUNT_CHECK.HERO)
	# CHECK SKILL REMOVE DEBUFF WHEN ALL ALLY(ENEMY) HAVE NO INFLICT DEBUFF THEN SKILL REMOVE DEBUFF NOT TO USE
	var get_active_skill = arr_turn[turn_begin_main].skill_confirm
	var main_active_skilll
	match get_active_skill:
		"skill_0": main_active_skilll = "skill_code"
		"skill_1": main_active_skilll = "skill_code_1"
		"skill_2": main_active_skilll = "skill_code_2"
		"skill_ulti": main_active_skilll = "skill_code_ulti"
	var get_active_skillcode = new_card_s1.dict_all_card_s1[str(temp_enemy_skill)][main_active_skilll]
	if get_active_skillcode == 42 and isallenem_inflict_debuff() == false:
		arr_turn[turn_begin_main].ai_skill_select_notused_rmdebuff(get_active_skill)
	print(str("ACTIVE SKILL IS: ", get_active_skillcode))
	# CHECK SKILL LOCK
	if arr_turn[turn_begin_main].skill_lock: arr_turn[turn_begin_main].skill_confirm = "skill_0"
	# RNG MIMIR TO RESET
	skill_amimir_rngreset(ENUM_MIMIR_CHECK.ENEMY)
	match temp_enemy_slot.skill_confirm:
		"skill_0": attacked_s0(temp_enemy_slot.skill_0_dmg, temp_enemy_slot, temp_caster_slot)
		"skill_1": attacked_s1(temp_enemy_slot.skill_1_dmg, temp_enemy_slot, temp_caster_slot)
		"skill_2": attacked_s2(temp_enemy_slot.skill_2_dmg, temp_enemy_slot, temp_caster_slot)
		"skill_ulti": attacked_s3(temp_enemy_slot.skill_ulti_dmg, temp_enemy_slot, temp_caster_slot)
	# TURN CHECK
	if arr_turn[turn_begin_main].skill_more_turn == true:
		arr_turn[turn_begin_main].turn_action = false
		arr_turn[turn_begin_main].skill_more_turn = false
		arr_turn[turn_begin_main].set_fdmg("GET MORE TURN", 9)
		arr_turn[turn_begin_main].fdmg()
		arr_turn[turn_begin_main].remove_buff(16)
	else: arr_turn[turn_begin_main].turn_action = true
	
	arr_turn[turn_begin_main].get_anim_ulti()
	indikator_skill_temp = 99
	arr_turn[turn_begin_main].total_turn+=1
	skill_stun_check()
	skill_rebith_check()
	enable_allbtn_select()
	disable_indicator_skill_confirm()
	#await get_tree().create_timer(.5).timeout
	turn_begin()
	
func disable_all_skill_preview():
	var get_all_spawn = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in get_all_spawn:
		value.disable_all_skill_icon()

func ai_select_enemy(): 
	var arr_all_enemy = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var arr_short = []
	for value in arr_all_enemy:
		if value.get_health != 0:
			arr_short.append(value)
	if arr_short.is_empty():
		return -1
	var rng = randi() % arr_short.size()
	var selected_enemy = arr_short[rng]
	var _get_index = arr_all_enemy.find(selected_enemy)
	return _get_index

enum ENUM_TAUNT_CHECK{HERO, ENEMY}
func check_taunt(value:ENUM_TAUNT_CHECK):
	var taunt_confirm = false
	var anti_taunt_confirm = arr_turn[turn_begin_main]._anti_taunt
	if value == ENUM_TAUNT_CHECK.HERO:
		var all_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		for _value in all_hero: if _value._defense_taunt and _value.get_health !=0: taunt_confirm = true
	elif value == ENUM_TAUNT_CHECK.ENEMY:
		var all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		for _value in all_enem: if _value._defense_taunt and _value.get_health !=0: taunt_confirm = true
	if anti_taunt_confirm: taunt_confirm = false
	return taunt_confirm

func fdmg_anti_taunt(target:ENUM_TAUNT_CHECK):
	if arr_turn[turn_begin_main]._anti_taunt:
		var all_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		var main_target
		if target == ENUM_TAUNT_CHECK.HERO: main_target = all_hero
		elif target == ENUM_TAUNT_CHECK.ENEMY: main_target = all_enem
		else: 
			print("fun fdmg_anti_taunt error")
			return
		var fdmg_count = 0
		for value in main_target: if value._defense_taunt and value.get_health !=0: fdmg_count += 1
		if fdmg_count !=0: for value in range(fdmg_count): arr_turn[turn_begin_main].set_fdmg("Tunt ingnored.", 9)

func ai_select_enemy_taunt():
	var arr_all_enemy = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var taunt_temp = []
	for value in arr_all_enemy: if value._defense_taunt and value.get_health !=0: taunt_temp.append(value)
	var rng = randi() % taunt_temp.size()
	var selected_enemy = taunt_temp[rng]
	var _get_index = arr_all_enemy.find(selected_enemy)
	return _get_index

# ------------ SKILL ------------
func check_skill_last_cursed(card_type, _self):
	var allhero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	var allenem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var select_confirm
	match card_type:
		"hero": select_confirm = allhero
		"enemy": select_confirm = allenem
	
	var arr_temp = []
	for value in select_confirm: if value.get_health !=0: arr_temp.append(value)
	if arr_temp.is_empty():
		print("ALL CARD DIE")
		return
	
	var level = _self.skill_last_cursed_level
	for value in arr_temp: value.skill_last_cursed_activated(level)

# ------------ SKILL ------------

# BTN ATTACK ENEMY
var btn_atk_hero_turn
var btn_atk_hero_code
var btn_atk_enemy_turn = null
var btn_atk_enemy_code = null
func _btn_attack_enemy():
	arr_turn[turn_begin_main].enable_anim_turn_begin(false, ENUM_SELECT_HERO.HERO)
	var allcard = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2], arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	for value in allcard:
		value.disabale_warning_cd(true)
		value.enable_icon_turn(false, ENUM_ICON_TURN.ATTACKER)
	disable_all_skill_preview()
	enable_icon_target_onenemy(false, ENUM_ARR_ENEM_POS.ARR_0)
	select_single_enem(false, ENUM_SELECT_HERO.ENEMY)
	if btn_atk_enemy_turn == null:
		if check_taunt(ENUM_TAUNT_CHECK.ENEMY):
			temp_enemy_slot = arr_enemy_pos[ai_select_enemy_taunt()]
			temp_enemy_skill = arr_enemy_skill[ai_select_enemy_taunt()]
		elif check_taunt(ENUM_TAUNT_CHECK.ENEMY) == false:
			temp_enemy_slot = arr_enemy_pos[ai_select_enemy()]
			temp_enemy_skill = arr_enemy_skill[ai_select_enemy()]
	else:
		if check_taunt(ENUM_TAUNT_CHECK.ENEMY):
			temp_enemy_slot = arr_enemy_pos[ai_select_enemy_taunt()]
			temp_enemy_skill = arr_enemy_skill[ai_select_enemy_taunt()]
		elif check_taunt(ENUM_TAUNT_CHECK.ENEMY) == false:
			temp_enemy_slot = btn_atk_enemy_turn
			temp_enemy_skill = btn_atk_enemy_code
			if temp_enemy_slot.get_health == 0:
				temp_enemy_slot = arr_enemy_pos[ai_select_enemy()]
				temp_enemy_skill = arr_enemy_skill[ai_select_enemy()]
	temp_caster_slot = btn_atk_hero_turn
	temp_caster_skill = btn_atk_hero_code
	fdmg_anti_taunt(ENUM_TAUNT_CHECK.ENEMY)
	# CHECL SKILL LOCK
	if arr_turn[turn_begin_main].skill_lock: arr_turn[turn_begin_main].skill_confirm = "skill_0"
	# RNG MIMIR TO RESET
	skill_amimir_rngreset(ENUM_MIMIR_CHECK.HERO)
	match temp_caster_slot.skill_confirm:
		"skill_0": attack_s0(temp_caster_slot.skill_0_dmg, temp_caster_slot, temp_enemy_slot)
		"skill_1": attack_s1(temp_caster_slot.skill_1_dmg, temp_caster_slot, temp_enemy_slot)
		"skill_2": attack_s2(temp_caster_slot.skill_2_dmg, temp_caster_slot, temp_enemy_slot)
		"skill_ulti": attack_s3(temp_caster_slot.skill_ulti_dmg, temp_caster_slot, temp_enemy_slot)
	btn_atk_enemy_turn = null
	btn_atk_enemy_code = null
	# CHECK MORE TURN
	if arr_turn[turn_begin_main].skill_more_turn == true:
		arr_turn[turn_begin_main].turn_action = false
		arr_turn[turn_begin_main].skill_more_turn = false
		arr_turn[turn_begin_main].set_fdmg("GET MORE TURN", 9)
		arr_turn[turn_begin_main].fdmg()
		arr_turn[turn_begin_main].remove_buff(16)
	else: arr_turn[turn_begin_main].turn_action = true
	arr_turn[turn_begin_main].get_anim_ulti()
	indikator_skill_temp = 99
	
	arr_turn[turn_begin_main].total_turn+=1
	skill_stun_check()
	skill_rebith_check()
	enable_allbtn_select()
	disable_indicator_skill_confirm()
	#await get_tree().create_timer(.5).timeout
	check_reward()
	turn_begin()

func disable_btn_select_enemy(_bool:bool):
	var arr_select_enem = [$enemy_pos_1, $enemy_pos_2, $enemy_pos_3]
	for value: Button in arr_select_enem:value.disabled = _bool
func disable_btn_select_hero(_bool:bool):
	var all_btn = [$hero_pos_1, $hero_pos_2, $hero_pos_3]
	for value:Button in all_btn: value.disabled = _bool

func ai_select_support_hero(_code:int):
	var num_limit = clamp(_code, 0, 2)
	if arr_hero_pos[num_limit].get_health == 0:
		hero_select_support = get_rand_hero()
	else: hero_select_support = arr_hero_pos[num_limit]

func filter_num_titik(_value: int) -> String:
	var num_str = str(abs(_value))
	var result = "-" if _value < 0 else ""
	var reversed_str = num_str.reverse()
	var chunks = []
	for i in range(0, reversed_str.length(), 3):
		chunks.append(reversed_str.substr(i, 3))
	
	# Menggabungkan menggunakan String.join()
	result += String(".").join(chunks).reverse()
	return result

func battle_info_card(get_card):
	
	var dmg_dealt:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer/dmg_dealt
	var dmg_taken:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer2/dmg_taken
	var total_heal:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer3/total_heal
	var heal_recived:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer10/heal_recived
	var total_turn:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer4/dmg_turn
	var total_crit:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer5/total_crit
	var total_dodge:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer6/total_dodge
	var total_exp:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer7/total_exp
	var elim_count:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer8/elim_card
	var elim_by:Label = $panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/HBoxContainer9/elim_by
	$panel_basic_0/battle_info_00/battle_info_01/VBoxContainer/VBoxContainer/card_name.text = str(get_card.own_name)
	
	dmg_dealt.text = str(filter_num_titik(abs(get_card.dmg_dealt)))
	dmg_taken.text = str(filter_num_titik(abs(get_card.dmg_taken)))
	total_heal.text = str(filter_num_titik(abs(get_card.total_heal)))
	heal_recived.text = str(filter_num_titik(abs(get_card.total_heal_recived)))
	total_turn.text = str(filter_num_titik(abs(get_card.total_turn)))
	total_crit.text = str(filter_num_titik(abs(get_card.total_crit)))
	total_dodge.text = str(filter_num_titik(abs(get_card.total_dodge)))
	total_exp.text = str(filter_num_titik(abs(get_card.total_dodge)))
	elim_count.text = str(get_card.elim_card)
	elim_by.text = str(get_card.elim_by)
	

func btn_select_hero_0() -> void:
	if arr_hero_pos[0]:battle_info_card(arr_hero_pos[0])
	ai_select_support_hero(0)
	set_info_battle_target(ENUM_BATTLE_INFO.HER_POS_0)
func btn_select_hero_1() -> void:
	if arr_hero_pos[1]:battle_info_card(arr_hero_pos[1])
	ai_select_support_hero(1)
	set_info_battle_target(ENUM_BATTLE_INFO.HER_POS_1)
func btn_select_hero_2() -> void:
	if arr_hero_pos[2]:battle_info_card(arr_hero_pos[2])
	ai_select_support_hero(2)
	set_info_battle_target(ENUM_BATTLE_INFO.HER_POS_2)

enum ENUM_ARR_ENEM_POS{ARR_0, ARR_1, ARR_2}
enum ENUM_ARR_HERO_POS{ARR_0, ARR_1, ARR_2}
# SIGNAL BTN SELECT
func btn_select_enemy_0() -> void:
	if arr_enemy_pos[0]: battle_info_card(arr_enemy_pos[0])
	enable_icon_target_onenemy(true, ENUM_ARR_ENEM_POS.ARR_0)
	select_single_enem(true, 0)
	btn_atk_enemy_turn = arr_enemy_pos[0]
	btn_atk_enemy_code = arr_enemy_skill[0]
	set_info_battle_target(ENUM_BATTLE_INFO.ENEM_POS_0)
func btn_select_enemy_1() -> void:
	if arr_enemy_pos[1]: battle_info_card(arr_enemy_pos[1])
	enable_icon_target_onenemy(true, ENUM_ARR_ENEM_POS.ARR_1)
	select_single_enem(true, 1)
	btn_atk_enemy_turn = arr_enemy_pos[1]
	btn_atk_enemy_code = arr_enemy_skill[1]
	set_info_battle_target(ENUM_BATTLE_INFO.ENEM_POS_1)
func btn_select_enemy_2() -> void:
	if arr_enemy_pos[2]: battle_info_card(arr_enemy_pos[2])
	enable_icon_target_onenemy(true, ENUM_ARR_ENEM_POS.ARR_2)
	select_single_enem(true, 2)
	btn_atk_enemy_turn = arr_enemy_pos[2]
	btn_atk_enemy_code = arr_enemy_skill[2]
	set_info_battle_target(ENUM_BATTLE_INFO.ENEM_POS_2)

# CHEAT SPAWN
var cheat_swpan = true
func get_last_card():
	var last_dict = new_card_s1.dict_all_card_s1.keys()
	return last_dict[last_dict.size()-1]

#var arr_hero_slot = []
var arr_hero_rng = [] # arr ini hanya di pakai di func generate_random_hero_card
func generate_random_hero_card():
	var card = null
	if arr_hero_pos.size() < 3:
		var rng = get_random_int(0, _get_total_card_count_s1())
		if arr_hero_rng.size() == 0:
			arr_hero_rng.append(rng)
		elif arr_hero_rng.size() < 3:
			if arr_hero_rng.has(rng):
				while arr_hero_rng.has(rng):
					var new_rng = get_random_int(0, _get_total_card_count_s1())
					rng = new_rng
			arr_hero_rng.append(rng)
		
		var temp_code = ""
		
		# CHEAT SPAWN
		if cheat_swpan:
			temp_code = str(get_last_card())
			arr_hero_rng[0]=_get_total_card_count_s1()
		else:
			if rng <10: temp_code = str("00",rng)
			elif rng <100: temp_code = str("0",rng)
			else: temp_code = str(rng)
			
		if cheat_swpan:
			set_card(card, CHAR_TYPE.HERO, temp_code)
		else:
			var code_s1 = str("s1_",temp_code)
			set_card(card, CHAR_TYPE.HERO, code_s1)
		cheat_swpan = false
	else:
		print("Slot hero Penuh")
func generate_fixed_card(card_type:CHAR_TYPE, card_code):
	var card = null
	set_card(card, card_type, card_code)
#var arr_enemy_slot
var arr_enemy_rng = []
func generate_random_enemy_card():
	var card = null
	if arr_enemy_pos.size() < 3:
		var rng = get_random_int(0, _get_total_card_count_s1())
		print(str("INI RNG: ", rng))
		if arr_enemy_rng.size() == 0:
			arr_enemy_rng.append(rng)
		elif arr_enemy_rng.size() < 3:
			if arr_enemy_rng.has(rng):
				while arr_enemy_rng.has(rng):
					var new_rng = get_random_int(0, _get_total_card_count_s1())
					rng = new_rng
			arr_enemy_rng.append(rng)
		
		var temp_code = ""
		if rng <10: temp_code = str("00",rng)
		elif rng <100: temp_code = str("0",rng)
		else: temp_code = str(rng)
		var code_s1 = str("s1_",temp_code)
		set_card(card, CHAR_TYPE.ENEMY, code_s1)
	else:
		print("Slot enemy Penuh")

enum CHAR_TYPE {HERO, ENEMY}
enum ENUM_CUSTOM_RANK {ATTACKER, AGILITY, DEFENDER, UNIVERSAL}
enum ENUM_CUSTOM_RANK_LEVEL {ATTACKER_LV1, ATTACKER_LV2, ATTACKER_LV3, AGILITY_LV1, AGILITY_LV2, AGILITY_LV3, DEFENDER_LV1, DEFENDER_LV2, DEFENDER_LV3, UNIVERSAL_LV1, UNIVERSAL_LV2, UNIVERSAL_LV3}
var arr_hero_pos =[] # POSISI HERO DI DALAM DECK
var arr_enemy_pos = [] # POSISI ENEMY DI DALAM DECK
var arr_hero_skill = [] # ISI CODE SKILL CASTER
var arr_enemy_skill = [] # ISI CODE SKILL ENEMY
func set_card(caster, char_type, code):
	caster = BASE_CARD.instantiate()
	if char_type == CHAR_TYPE.HERO:
		arr_hero_pos.append(caster)
		arr_hero_skill.append(code)
		caster.name = str("hero_",code)
		caster.get_card_node = str("hero_",code)
		caster.card_type_confirm = "hero"
		caster.card_code = str(code)
		set_hero_pos(caster)
	elif char_type == CHAR_TYPE.ENEMY:
		arr_enemy_pos.append(caster)
		arr_enemy_skill.append(code)
		caster.name = str("enemy_",code)
		caster.get_card_node = str("enemy_",code)
		caster.card_type_confirm = "enemy"
		caster.card_code = str(code)
		set_enemy_pos(caster)
		
	caster.skill_0_dmg = new_card_s1.dict_all_card_s1[code]["skill_0_dmg"]
	caster.skill_1_dmg = new_card_s1.dict_all_card_s1[code]["skill_1_dmg"]
	caster.skill_2_dmg = new_card_s1.dict_all_card_s1[code]["skill_2_dmg"]
	caster.skill_ulti_dmg = new_card_s1.dict_all_card_s1[code]["skill_ulti_dmg"]
	caster.skill_0_hit = new_card_s1.dict_all_card_s1[code]["skill_0_hit"]
	caster.skill_1_hit = new_card_s1.dict_all_card_s1[code]["skill_1_hit"]
	caster.skill_2_hit = new_card_s1.dict_all_card_s1[code]["skill_2_hit"]
	caster.skill_3_hit = new_card_s1.dict_all_card_s1[code]["skill_3_hit"]
	
	set_img(caster, new_card_s1.dict_all_card_s1[code]["img"])
	set_attr(caster, new_card_s1.dict_all_card_s1[code]["elem"], new_card_s1.dict_all_card_s1[code]["job"], new_card_s1.dict_all_card_s1[code]["rank"], new_card_s1.dict_all_card_s1[code]["name"], new_card_s1.dict_all_card_s1[code]["c_rank_stat"], new_card_s1.dict_all_card_s1[code]["c_rank_value"])
	set_skill_target(caster, new_card_s1.dict_all_card_s1[code]["skill_0_target"], new_card_s1.dict_all_card_s1[code]["skill_1_target"], new_card_s1.dict_all_card_s1[code]["skill_2_target"], new_card_s1.dict_all_card_s1[code]["skill_ulti_target"])
	set_cooldown(caster, new_card_s1.dict_all_card_s1[code]["skill_1_cd"], new_card_s1.dict_all_card_s1[code]["skill_2_cd"], new_card_s1.dict_all_card_s1[code]["skill_ulti_cd"])
	set_indic_debuff_confirm(caster, new_card_s1.dict_all_card_s1[code]["skill_code"], new_card_s1.dict_all_card_s1[code]["skill_code_1"], new_card_s1.dict_all_card_s1[code]["skill_code_2"], new_card_s1.dict_all_card_s1[code]["skill_code_ulti"])
	get_card_border(caster, caster._hero_elemen)
	caster.set_gearset_stat(code)
	for value in range(4): set_indic_icon_skill(caster, code, value)

func reset_skill(code, caster):
	match code:
		1: caster.skill_1_cd = caster._default_skill_1_cd
		2: caster.skill_2_cd = caster._default_skill_2_cd
		3: caster.skill_ulti_cd = caster._default_skill_ulti_cd
		
	caster._update_cd()
	caster.skill_confirm = "skill_0"
	
# ---------------------------------- HERO SKILL ----------------------------------
func get_rand_hero():
	var all_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
	var bool_stop = false
	while bool_stop == false:
		var rng = get_random_int(0, all_hero.size()-1)
		if all_hero[rng].get_health != 0:
			bool_stop = true
			return all_hero[rng]
		else: all_hero.remove_at(rng)
		 
var hero_select_support = null
func get_pct(value, pct):
	return (value * pct) / 100

enum ENUM_SUPP_INDIC{SINGLE, AOE}
func heal_supp(_caster_, _target_, indic:ENUM_SUPP_INDIC):
	var target_hp_before = _target_.get_health
	var rng
	if indic==ENUM_SUPP_INDIC.SINGLE: rng=get_random_int(30, 40)
	elif indic==ENUM_SUPP_INDIC.AOE: rng=get_random_int(20, 30)
	var total_heal = get_pct(_caster_.get_health, rng)
	_target_.stat_health(total_heal)
	_target_.set_fdmg(total_heal,2)
	var target_hp_after = _target_.get_health
	_caster_.total_heal+=target_hp_after-target_hp_before
	_target_.total_heal_recived+=target_hp_after-target_hp_before
	
func deff_supp(_caster_, _target_, indic:ENUM_SUPP_INDIC):
	var target_hp_before = _target_.get_health
	var rng
	if indic==ENUM_SUPP_INDIC.SINGLE: rng=get_random_int(30, 40)
	elif indic==ENUM_SUPP_INDIC.AOE: rng=get_random_int(20, 30)
	var total_def = get_pct(_caster_.get_deffense, rng)
	_target_.stat_deffense(total_def)
	_target_.set_fdmg(total_def,3)
	var target_hp_after = _target_.get_health
	_caster_.total_heal+=target_hp_after-target_hp_before
	_target_.total_heal_recived+=target_hp_after-target_hp_before
func attack_s0(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		var count_hit = _caster.skill_0_hit
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		match _caster.skill_0_target:
			"single":
				load_skill(0, _caster, temp_caster_skill)
				for value in count_hit: 
					_caster.attack_to(_caster.skill_0_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_enem:
						if value.get_health !=0:
							load_skill(0, _caster, temp_caster_skill)
							_caster.attack_to(_caster.skill_0_dmg, arr_enemy_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(0, hero_select_support, temp_caster_skill)
				deff_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.anim_attack(1)
				hero_select_support.fdmg()
			"aoe_spell":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(0, value, temp_caster_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
			"single_heal":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(0, hero_select_support, temp_caster_skill)
				heal_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.anim_attack(1)
				hero_select_support.fdmg()
				limit_hp_card(hero_select_support)
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(0, value, temp_caster_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						limit_hp_card(value)
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	hero_select_support = null
	limit_hp_card(_caster)

func attack_s1(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		reset_skill(1, _caster)
		var count_hit = _caster.skill_1_hit
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		match _caster.skill_1_target:
			"single":
				load_skill(1, _caster, temp_caster_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_1_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_enem:
						if value.get_health !=0:
							load_skill(1, _caster, temp_caster_skill)
							_caster.attack_to(_caster.skill_1_dmg, arr_enemy_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(1, hero_select_support, temp_caster_skill)
				deff_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.anim_attack(1)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.fdmg()
			"aoe_spell":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(1, value, temp_caster_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.skill_instant_heal_trigger()
						value.fdmg()
			"single_heal":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(1, hero_select_support, temp_caster_skill)
				heal_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.anim_attack(1)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.fdmg()
				limit_hp_card(hero_select_support)
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(1, value, temp_caster_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						limit_hp_card(value)
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	hero_select_support = null
	limit_hp_card(_caster)
		
func attack_s2(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		reset_skill(2, _caster)
		var count_hit = _caster.skill_2_hit
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		match _caster.skill_2_target:
			"single":
				load_skill(2, _caster, temp_caster_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_2_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_enem:
						if value.get_health !=0:
							load_skill(2, _caster, temp_caster_skill)
							_caster.attack_to(_caster.skill_2_dmg, arr_enemy_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(2, hero_select_support, temp_caster_skill)
				deff_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.anim_attack(1)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.fdmg()
			"aoe_spell":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(2, value, temp_caster_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.skill_instant_heal_trigger()
						value.fdmg()
			"single_heal":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(2, hero_select_support, temp_caster_skill)
				heal_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.anim_attack(1)
				hero_select_support.fdmg()
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(2, value, temp_caster_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	hero_select_support = null
	limit_hp_card(_caster)

func attack_s3(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		reset_skill(3, _caster)
		var count_hit = _caster.skill_3_hit
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		match _caster.skill_ulti_target:
			"single":
				load_skill(3, _caster, temp_caster_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_ulti_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_enem:
						if value.get_health !=0:
							load_skill(3, _caster, temp_caster_skill)
							_caster.attack_to(_caster.skill_ulti_dmg, arr_enemy_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(3, hero_select_support, temp_caster_skill)
				deff_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.anim_attack(1)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.fdmg()
			"aoe_spell":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(3, value, temp_caster_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.skill_instant_heal_trigger()
						value.fdmg()
			"single_heal":
				if hero_select_support == null: hero_select_support = get_rand_hero()
				load_skill(3, hero_select_support, temp_caster_skill)
				heal_supp(_caster, hero_select_support, ENUM_SUPP_INDIC.SINGLE)
				hero_select_support.skill_instant_heal_trigger()
				hero_select_support.anim_attack(1)
				hero_select_support.fdmg()
				limit_hp_card(hero_select_support)
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_hero:
					if value.get_health !=0:
						load_skill(3, value, temp_caster_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						limit_hp_card(value)
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	hero_select_support = null
	limit_hp_card(_caster)
		
# ---------------------------------- ENEMY SKILL ----------------------------------
func get_maxint_ofarr(arr: Array) -> int:
	if arr.is_empty(): return -1
	var max_value = arr.max()
	var max_indices = []
	for i in range(arr.size()): if arr[i] == max_value: max_indices.append(i)
	return max_indices[randi() % max_indices.size()]

# ----------- MAIN VAR DEBUFF INFLICT -----------
var arr_total_debuff = [0, 0, 0]
func check_allenem_inflict():
	var main_all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	arr_total_debuff = [0, 0, 0]
	var debuff_count = 0
	var enem_pos = 0
	for value in main_all_enem:
		var arr_debuff_checks = [
			value._defense_breaker_isactive,
			value._weakening_isactive,
			value.skill_burn_isactive,
			value._skill_poison_isactive,
			value.skill_lock_isactive]
		for _value in arr_debuff_checks: if _value: debuff_count +=1
		if value.get_health == 0: debuff_count = 0
		arr_total_debuff[enem_pos] = debuff_count
		debuff_count = 0
		enem_pos += 1

func ai_select_toremove_debuff():
	var main_all_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	check_allenem_inflict()
	return main_all_enem[get_maxint_ofarr(arr_total_debuff)]
func isallenem_inflict_debuff():
	arr_total_debuff = [0, 0, 0]
	check_allenem_inflict()
	if arr_total_debuff[0] == 0 and arr_total_debuff[1] == 0 and arr_total_debuff[2] == 0: return false
	else: return true
	
# ----------- END MAIN VAR DEBUFF INFLICT -----------
enum ENUM_STAGE_SELECT{TOP_ATTACK, TOP_HP, MIN_HP}
func get_rand_enem(select_stage:ENUM_STAGE_SELECT):
	var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	var arr_temp = []
	var main_enem = null
	for value in get_enem: if value.get_health !=0: arr_temp.append(value)
	match select_stage:
		ENUM_STAGE_SELECT.TOP_ATTACK:
			for value in arr_temp:
				if main_enem == null: main_enem = value
				elif value.get_attack > main_enem.get_attack: main_enem = value
		ENUM_STAGE_SELECT.TOP_HP:
			for value in arr_temp:
				if main_enem == null: main_enem = value
				elif value.get_health > main_enem.get_health: main_enem = value
		ENUM_STAGE_SELECT.MIN_HP:
			for value in arr_temp:
				if main_enem == null: main_enem = value
				elif value.get_health < main_enem.get_health: main_enem = value
		_:print("func get_rand_enem wrong input")
	return main_enem

func check_skill_enemy_code(code):
	var skill_code
	match code:
		0: skill_code = "skill_code"
		1: skill_code = "skill_code_1"
		2: skill_code = "skill_code_2"
		3: skill_code = "skill_code_ulti"
	var get_code = str(temp_enemy_skill)
	var confirm_code = new_card_s1.dict_all_card_s1[get_code][skill_code]
	return confirm_code

func attacked_s0(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		var count_hit = _caster.skill_0_hit
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		match _caster.skill_0_target:
			"single": 
				load_skill(0, _caster, temp_enemy_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_0_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_hero:
						if value.get_health !=0:
							load_skill(0, _caster, temp_enemy_skill)
							_caster.attack_to(_caster.skill_0_dmg, arr_hero_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.TOP_ATTACK)
				if check_skill_enemy_code(0) == 42:
					select_enem = ai_select_toremove_debuff()
				load_skill(0, select_enem, temp_enemy_skill)
				deff_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.anim_attack(1)
				select_enem.skill_instant_heal_trigger()
				select_enem.fdmg()
			"aoe_spell":
				for value in get_enem:
					if value.get_health !=0:
						load_skill(0, value, temp_enemy_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.skill_instant_heal_trigger()
						value.fdmg()
			"single_heal":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.MIN_HP)
				load_skill(0, select_enem, temp_enemy_skill)
				select_enem.skill_instant_heal_trigger()
				heal_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.anim_attack(1)
				select_enem.fdmg()
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_enem:
					if value.get_health != 0:
						load_skill(0, value, temp_enemy_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	limit_hp_card(_caster)

func attacked_s1(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		reset_skill(1, _caster)
		var count_hit = _caster.skill_1_hit
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		match _caster.skill_1_target:
			"single":
				load_skill(1, _caster, temp_enemy_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_1_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_hero:
						if value.get_health !=0:
							load_skill(1, _caster, temp_enemy_skill)
							_caster.attack_to(_caster.skill_1_dmg, arr_hero_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.TOP_ATTACK)
				if check_skill_enemy_code(1) == 42: select_enem = ai_select_toremove_debuff()
				load_skill(1, select_enem, temp_enemy_skill)
				deff_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.anim_attack(1)
				select_enem.skill_instant_heal_trigger()
				select_enem.fdmg()
			"aoe_spell":
				for value in get_enem:
					if value.get_health !=0:
						load_skill(1, value, temp_enemy_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.skill_instant_heal_trigger()
						value.fdmg()
			"single_heal":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.MIN_HP)
				load_skill(1, select_enem, temp_enemy_skill)
				heal_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.skill_instant_heal_trigger()
				select_enem.anim_attack(1)
				select_enem.fdmg()
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_enem:
					if value.get_health != 0:
						load_skill(0, value, temp_enemy_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	limit_hp_card(_caster)
		
func attacked_s2(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		reset_skill(2, _caster)
		var count_hit = _caster.skill_2_hit
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		match _caster.skill_2_target:
			"single":
				load_skill(2, _caster, temp_enemy_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_2_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_hero:
						if value.get_health !=0:
							load_skill(2, _caster, temp_enemy_skill)
							_caster.attack_to(_caster.skill_2_dmg, arr_hero_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.TOP_ATTACK)
				if check_skill_enemy_code(2) == 42: select_enem = ai_select_toremove_debuff()
				load_skill(2, select_enem, temp_enemy_skill)
				deff_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.anim_attack(1)
				select_enem.skill_instant_heal_trigger()
				select_enem.fdmg()
			"aoe_spell":
				for value in get_enem:
					if value.get_health !=0:
						load_skill(2, value, temp_enemy_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.skill_instant_heal_trigger()
						value.fdmg()
			"single_heal":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.MIN_HP)
				load_skill(2, select_enem, temp_enemy_skill)
				heal_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.skill_instant_heal_trigger()
				select_enem.anim_attack(1)
				select_enem.fdmg()
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_enem:
					if value.get_health != 0:
						load_skill(2, value, temp_enemy_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	limit_hp_card(_caster)

func attacked_s3(_pct_dmg, _caster, _enemy):
	if _caster.get_health != 0 and _enemy.get_health != 0:
		set_skill_turn(_caster)
		reset_skill(3, _caster)
		var count_hit = _caster.skill_1_hit
		var get_hero = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2]]
		var get_enem = [arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
		match _caster.skill_ulti_target:
			"single": 
				load_skill(3, _caster, temp_enemy_skill)
				for value in count_hit:
					_caster.attack_to(_caster.skill_ulti_dmg, _enemy)
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"aoe":
				for _value in count_hit:
					var _count = 0
					for value in get_hero:
						if value.get_health !=0:
							load_skill(3, _caster, temp_enemy_skill)
							_caster.attack_to(_caster.skill_ulti_dmg, arr_hero_pos[_count])
						_count += 1
					_caster.skill_instant_heal_trigger()
					_caster.fdmg()
					await get_tree().create_timer(.2).timeout
			"single_spell":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.TOP_ATTACK)
				if check_skill_enemy_code(3) == 42: select_enem = ai_select_toremove_debuff()
				load_skill(3, select_enem, temp_enemy_skill)
				deff_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.anim_attack(1)
				select_enem.fdmg()
			"aoe_spell":
				for value in get_enem:
					if value.get_health !=0:
						load_skill(3, value, temp_enemy_skill)
						deff_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.anim_attack(1)
						value.fdmg()
			"single_heal":
				var select_enem = get_rand_enem(ENUM_STAGE_SELECT.MIN_HP)
				load_skill(3, select_enem, temp_enemy_skill)
				heal_supp(_caster, select_enem, ENUM_SUPP_INDIC.SINGLE)
				select_enem.skill_instant_heal_trigger()
				select_enem.anim_attack(1)
				select_enem.fdmg()
				SfxManager.play_heal()
			"aoe_heal":
				for value in get_enem:
					if value.get_health != 0:
						load_skill(3, value, temp_enemy_skill)
						heal_supp(_caster, value, ENUM_SUPP_INDIC.AOE)
						value.skill_instant_heal_trigger()
						value.anim_attack(1)
						value.fdmg()
						SfxManager.play_heal()
	else:
		if _caster.get_health == 0:print("Your card aleady die")
		else:print("Enemy already die")
	instant_heal_bool = true
	limit_hp_card(_caster)

# STAT
func stat_attack(caster, value): caster.stat_attack(value)
func stat_deffense(caster, value): caster.stat_deffense(value)
func stat_health(caster, value): caster.stat_health(value)
func stat_speed(caster, value): caster.stat_speed(value)
func stat_cost(caster, value): caster.stat_cost(value)
func stat_evation(caster, value): caster.stat_evation(value)
func stat_crit_rate(caster, value): caster.stat_crit_rate(value)
func stat_crit_dmg(caster, value): caster.stat_crit_dmg(value)
func stat_crit_deff(caster, value): caster.stat_crit_deff(value)
func stat_speed_atk(caster, value): caster.stat_speed_atk(value)

# SKILL
func skill_00_counter_attack(caster, pct) : caster.skill_counter_attack_activated(pct)
func skill_01_skill_evation(caster, level, pct): caster.skill_evation_activated(level, pct) 
func skill_02_reduce_deff(caster, level, pct): caster.skill_defense_breaker_activated(level, pct)
func skill_03_seal(caster, level, pct): caster.skill_lock_activated(level, pct)
func skill_04_skill_weakening(caster, level, pct) : caster.skill_weakening_activated(level, pct)
func skill_05_burn(caster, pct): caster.skill_burn_activated(pct) 
func skill_06_poison(caster, pct) : caster.skill_poison_activated(pct) 
func skill_07_heal(caster, level, pct): caster.skill_heal(level, pct)
func skill_08_vampire(caster, level, pct): caster.skill_vampire_activated(level, pct)
func skill_09_echo_shield(caster, level, pct): caster.skill_echo_shield_activated(level, pct) 
func skill_10_crit_dmg(caster, level, pct): caster.skill_crit_dmg_activated(level, pct) 
func skill_11_crit_rate(caster, level, pct): caster.skill_crit_rate_activated(level, pct) 
func skill_12_turn_speed(caster, level, pct): caster.skill_turn_speed_activated(level, pct) 
func skill_13_defense_up(caster, level, pct): caster.skill_defense_up_activated(level, pct) 
func skill_14_speed_attack(caster, level, pct): caster.skill_speed_attack_activated(level, pct)
func skill_15_attack_up(caster, level, pct): caster.skill_attack_up_activated(level, pct)
func skill_17_rebirth(caster, pct): caster.skill_rebrith_activated(pct)
func skill_18_rage(caster, level, hp_min) : caster.skill_rage_activated(level, hp_min) 
func skill_19_grim_reaper(caster, level): caster.grim_reaper_activated(level)
func skill_20_remove_debuff(caster, pct): caster.skill_remove_debuff_activated(pct)
func skill_21_remove_blue_buff(caster, pct): caster.skill_remove_blue_buff_activated(pct)
func skill_22_remove_gree_buff(caster, pct): caster.skill_remove_green_buff_activateed(pct)
func skill_23_remove_gold_buff(caster, pct): caster.skill_remove_gold_buff_activated(pct)
func skill_24_cd_increase(caster, pct): caster.skill_cd_increase_activated(pct)
func skill_25_cd_decrease(caster, pct): caster.skill_cd_descrease_activated(pct)
func skill_26_random_bluebuff(caster, level, pct): caster.skill_random_bluebuff_activated(level, pct)
func skill_27_instant_heal(caster, pct): caster.skill_instant_heal_activated(pct)
func skill_28_oneshot_cdmg(caster, level, pct): caster.skill_oneshot_cdmg_activated(level, pct)
func skill_29_oneshot_crate(caster, level , pct): caster.skill_oneshot_crate_acticvated(level , pct)
func skill_30_oneshot_turnspeed(caster, level, pct): caster.skill_oneshot_turnspeed_activated(level, pct)
func skill_31_oneshot_defenseup(caster, level, pct): caster.skill_oneshot_defenseup_activated(level, pct)
func skill_32_oneshot_speedattack(caster, level, pct): caster.skill_oneshot_speedattack_activated(level, pct)
func skill_33_oneshot_attackup(caster, level , pct): caster.skill_oneshot_attackup_activated(level, pct)
func skill_34_onesoht_counter(caster, pct): caster.skill_oneshot_counter_activated(pct)
func skill_35_oneshot_eva(caster, level , pct): caster.skill_oneshot_eva_activated(level, pct)
func skill_36_oneshot_grim(caster, level, pct): caster.skill_oneshot_grim_activated(level, pct)
func skill_37_multi_crate_cdmg(caster, level, pct): caster.skill_multi_crate_cdmg_activated(level, pct)
func skill_38_multi_attk_defense(caster, level, pct): caster.skill_multi_attack_defense_activated(level, pct)
func skill_39_multi_spda_spdt(caster, level, pct): caster.skill_multi_spda_spdt_activated(level, pct)
func skill_40_multi_cooldown(caster, level, pct): caster.skill_multi_cooldown_activated(level, pct)
func skill_70_last_cursed(caster, level, pct): caster.skill_last_cursed_set(level, pct)
func skill_72_infinite_heal(caster, pct): caster.skill_infinite_heal_activated(pct)
func skill_73_reflect_burn(caster, pct): caster.skill_reflect_burn_activated(pct)
func skill_74_reflect_poison(caster, pct): caster.skill_reflect_poison_activated(pct)
func skill_75_reflect_attack(caster): caster.skill_ref_attack_activated()
func skill_76_more_turn(caster, pct): caster.skill_more_turn_activated(pct)
func skill_78_refcd_dec(caster, level, pct): caster.skill_refcd_dec_activated(level, pct)
func skill_79_stun(caster, level, pct): caster.skill_stun_activated(level, pct)
func skill_80_amimir(caster, pct): caster.skill_amimir_activated(pct)

func skill_rebith_check():
	var all_card = [arr_hero_pos[0], arr_hero_pos[1], arr_hero_pos[2], arr_enemy_pos[0], arr_enemy_pos[1], arr_enemy_pos[2]]
	for value in all_card:
		if value.get_health == 0 and value.skill_rebrith:
			value.skill_rebirth_trigger()

# func for set
enum ELEM{LIGHT, NATURE, WATER, DARK, FIRE}
enum JOB{WARRIOR, ARCHER, DEFENSE, ASSASIN, SUPPORT, MECH, BEAST, MAGE, HEALER}
enum RANK{STAR_1, STAR_2, STAR_3, STAR_4, STAR_5, STAR_6}
	
func set_hero_pos(caster):
	var canvas_pos = $deck_hero
	canvas_pos.add_child(caster)
	if arr_hero_pos.size() == 1:
		caster.default_position(-250, 280)
	elif arr_hero_pos.size() == 2:
		caster.default_position(0, 280)
	elif arr_hero_pos.size() == 3:
		caster.default_position(250, 280)
func set_enemy_pos(caster):
	var canvas_pos = $deck_enemy
	canvas_pos.add_child(caster)
	if arr_enemy_pos.size() == 1:
		caster.default_position(-250, -160)
	elif arr_enemy_pos.size() == 2:
		caster.default_position(0,-160)
	elif arr_enemy_pos.size() == 3:
		caster.default_position(250, -160)
func set_img(caster, link): caster.default_img(link)
func set_attr(caster, elem, job, rank, _name, c_rank_stat, c_rank_value): caster.default_attribute(elem, job, rank, _name, c_rank_stat, c_rank_value)
func set_desc(caster, header, desc): caster.default_desc(header, desc)
func set_desc_s1(caster, desc): caster.default_skill_1_desc(desc)
func set_desc_s2(caster, desc): caster.default_skill_2_desc(desc)
func set_ulti_desc(caster, desc): caster.default_ulti_desc(desc)
func set_skill_target(caster, s0, s1, s2, ulti): caster.default_skill_target(s0, s1, s2, ulti)
func set_cooldown(caster, s1, s2, ulti): caster.default_cooldown(s1, s2, ulti)
func set_skill_turn(caster): caster._update_cooldown_icon()
func set_indic_debuff_confirm(caster, s0, s1, s2, s3): caster.default_debuff_confrim(s0, s1, s2, s3)

enum ENUM_RESEUME_ICON{ATK_SINGLE, ATK_AOE, SPELL_SINGLE, SPELL_AOE, HEAL_SINGLE, HEAL_AOE, EMTY, PASSIVE, NONE, ANON_ALLY, ANON_ENEMY, REFECT, TURN,
	REFLECT_SUPP, REFLECT_AOE, SPELL_SUPP, TURN_SUPP, HEAL_SUPP, RM_BLUE, RM_RED, RM_GOLD, RM_GREEN, SPELL_MULTI, DEBUFF_AOE, DEBUFF_SINGLE, TURN_CDD,
	TURN_CDI, TURN_SKIP, SPELL_RNG, TURN_REVIVE, ANON_IMMORTAL, ANON_SUPP, HEAL_VAMP, HEAL_INFI, ANON_AOE, TURN_AOE
	}
var data_icon_link ={
		ENUM_RESEUME_ICON.ATK_SINGLE:"res://img/Base Card/Saparate resume icon/atk_single.png", # ATK SINGLE
		ENUM_RESEUME_ICON.ATK_AOE:"res://img/Base Card/Saparate resume icon/atk_aoe.png", # ATK AOE
		ENUM_RESEUME_ICON.SPELL_SINGLE:"res://img/Base Card/Saparate resume icon/spell_single.png", # SPELL SINGLE
		ENUM_RESEUME_ICON.SPELL_AOE:"res://img/Base Card/Saparate resume icon/spell_aoe.png", # SPELL AOE
		ENUM_RESEUME_ICON.HEAL_SINGLE:"res://img/Base Card/Saparate resume icon/heal_single.png", # HEAL SINGLE
		ENUM_RESEUME_ICON.HEAL_AOE:"res://img/Base Card/Saparate resume icon/heal_aoe.png", # HEAL AOE
		ENUM_RESEUME_ICON.EMTY:"res://img/Base Card/Saparate resume icon/emty.png", # EMTY
		ENUM_RESEUME_ICON.PASSIVE:"res://img/Base Card/Saparate resume icon/atk_passive.png", # PASSIVE
		ENUM_RESEUME_ICON.NONE:"res://img/Base Card/Saparate resume icon/atk_none.png", # NONE
		ENUM_RESEUME_ICON.ANON_ALLY:"res://img/Base Card/Saparate resume icon/anon_ally.png", # ANON ALLY
		ENUM_RESEUME_ICON.ANON_ENEMY:"res://img/Base Card/Saparate resume icon/anon_enemy.png", # ANON ENEMY
		ENUM_RESEUME_ICON.REFECT:"res://img/Base Card/Saparate resume icon/reflect.png", # REFLECT
		ENUM_RESEUME_ICON.TURN:"res://img/Base Card/Saparate resume icon/turn.png", # TURN
		ENUM_RESEUME_ICON.REFLECT_SUPP:"res://img/Base Card/Saparate resume icon/reflect_support.png", # REFLECT SUPP
		ENUM_RESEUME_ICON.REFLECT_AOE:"res://img/Base Card/Saparate resume icon/reflect_aoe.png", # REFLECT AOE
		ENUM_RESEUME_ICON.SPELL_SUPP:"res://img/Base Card/Saparate resume icon/support_single.png", # SPELL SUPP
		ENUM_RESEUME_ICON.TURN_SUPP:"res://img/Base Card/Saparate resume icon/turn_support.png", # TURN SUPP
		ENUM_RESEUME_ICON.HEAL_SUPP:"res://img/Base Card/Saparate resume icon/heal_sup_single.png", # HEAL SUPP
		ENUM_RESEUME_ICON.RM_BLUE:"res://img/Base Card/Saparate resume icon/spell_remove.png", # REMOVE BLUE
		ENUM_RESEUME_ICON.RM_RED:"res://img/Base Card/Saparate resume icon/debuff_remove.png", # REMOVE RED
		ENUM_RESEUME_ICON.RM_GOLD:"res://img/Base Card/Saparate resume icon/reflect_remove.png", # REMOVE GOLD
		ENUM_RESEUME_ICON.RM_GREEN:"res://img/Base Card/Saparate resume icon/heal_remove.png", # REMOVE GREEN
		ENUM_RESEUME_ICON.SPELL_MULTI:"res://img/Base Card/Saparate resume icon/spell_multi.png", # SPELL MULTI
		ENUM_RESEUME_ICON.DEBUFF_AOE:"res://img/Base Card/Saparate resume icon/debuff_aoe.png", # DEBUFF AOE
		ENUM_RESEUME_ICON.DEBUFF_SINGLE:"res://img/Base Card/Saparate resume icon/debuff_single.png", # DEBUFF SINGLE
		ENUM_RESEUME_ICON.TURN_CDD:"res://img/Base Card/Saparate resume icon/turn_cdd.png", # TURN CDD
		ENUM_RESEUME_ICON.TURN_CDI:"res://img/Base Card/Saparate resume icon/turn_cdi.png", # TURN CDI
		ENUM_RESEUME_ICON.TURN_SKIP:"res://img/Base Card/Saparate resume icon/turn_skip.png", # TURN SKIP
		ENUM_RESEUME_ICON.SPELL_RNG:"res://img/Base Card/Saparate resume icon/spell_rng.png", # SPELL RNG
		ENUM_RESEUME_ICON.TURN_REVIVE:"res://img/Base Card/Saparate resume icon/turn_revive.png", # REVIVE
		ENUM_RESEUME_ICON.ANON_IMMORTAL:"res://img/Base Card/Saparate resume icon/anon_immortal.png", # ANON IMMORTAL
		ENUM_RESEUME_ICON.ANON_SUPP:"res://img/Base Card/Saparate resume icon/anon_supp.png", # ANON SUPP
		ENUM_RESEUME_ICON.HEAL_VAMP:"res://img/Base Card/Saparate resume icon/heal_vamp.png", # HEAL VAMP
		ENUM_RESEUME_ICON.HEAL_INFI:"res://img/Base Card/Saparate resume icon/heal_infinite.png", # INFI HEAL
		ENUM_RESEUME_ICON.ANON_AOE:"res://img/Base Card/Saparate resume icon/anon_aoe.png", # INFI HEAL
		ENUM_RESEUME_ICON.TURN_AOE:"res://img/Base Card/Saparate resume icon/turn_aoe.png", # TURN AOE
	}
func set_indic_icon_skill_filter(value):
	var all_debuff = [2, 3, 4, 5, 6, 43, 44, 45]
	var all_buff = [10, 11, 12, 13, 14, 15, 26, 27, 28, 29, 30, 31, 42, 48, 50, 51, 52, 53, 54, 55, 59, 60, 61]
	var all_counter = [0, 1, 9, 21, 22, 56, 57, 73, 74, 75]
	var all_passive = [32, 33, 34, 35, 36, 37, 38, 39, 40, 41]
	var all_anon = [18, 19, 58, 70]
	var all_turn = [16, 46, 47, 62, 76, 78, 79, 80]
	var all_heal = [7, 8, 17, 23, 24, 25, 49, 72]
	
	var all_arr = [all_debuff, all_buff, all_counter, all_passive, all_anon, all_turn, all_heal]
	var get_count = -1 # Default jika tidak ditemukan
	
	for count in range(all_arr.size()):
		if all_arr[count].has(value):
			get_count = count
			break
	
	return get_count

func set_indic_icon_skill(caster, code_dict, code_skill):
	var new_data_card = Card_data_s1.new()
	
	var skill_target
	var main_skill
	var _get_dmg
	var _get_level
	var _get_pct
	var _get_indic_atk
	match code_skill:
		0: 
			skill_target = "skill_0_target"
			main_skill = "skill_code"
			_get_dmg = "skill_0_dmg"
			_get_level = "skill_lv"
			_get_pct = "pct_req"
		1: 
			skill_target = "skill_1_target"
			main_skill = "skill_code_1"
			_get_dmg = "skill_1_dmg"
			_get_level = "skill_1_lv"
			_get_pct = "pct_req_1"
		2: 
			skill_target = "skill_2_target"
			main_skill = "skill_code_2"
			_get_dmg = "skill_2_dmg"
			_get_level = "skill_2_lv"
			_get_pct = "pct_req_2"
		3: 
			skill_target = "skill_ulti_target"
			main_skill = "skill_code_ulti"
			_get_dmg = "skill_ulti_dmg"
			_get_level = "skill_ulti_lv"
			_get_pct = "pct_req_ulti"
			
	var get_img_0_code = new_data_card.dict_all_card_s1[code_dict][skill_target]
	var get_img_1_code = new_data_card.dict_all_card_s1[code_dict][main_skill]
	
	var get_skill_target = new_data_card.dict_all_card_s1[code_dict][skill_target]
	if get_skill_target == "single": _get_indic_atk = 0
	elif get_skill_target == "aoe": _get_indic_atk = 1
	elif get_skill_target == "single_spell": _get_indic_atk = 2
	elif get_skill_target == "aoe_spell": _get_indic_atk = 3
	elif get_skill_target == "single_heal": _get_indic_atk = 4
	elif get_skill_target == "aoe_heal": _get_indic_atk = 5
	var get_skill_code = new_data_card.dict_all_card_s1[code_dict][main_skill]
	var get_skill_dmg = new_data_card.dict_all_card_s1[code_dict][_get_dmg]
	var get_skill_level = new_data_card.dict_all_card_s1[code_dict][_get_level]
	var get_skill_pct = new_data_card.dict_all_card_s1[code_dict][_get_pct]
	var full_desc = new_data_card.fullset_desc(get_skill_code, get_skill_pct, get_skill_level, get_skill_dmg, _get_indic_atk)
	
	# ICON INDIC
	for _value in range(7):
		if _value == set_indic_icon_skill_filter(get_img_1_code):
			caster.set_skill_indic_stat(code_skill, _value+1)
	# ICON SKILL
	var get_main_icon_skill
	if get_img_0_code == "single":
		match code_skill:
			0:get_main_icon_skill = 24
			1:get_main_icon_skill = 26
			2:get_main_icon_skill = 28
			3:get_main_icon_skill = 30
	elif get_img_0_code == "aoe":
		match code_skill:
			0:get_main_icon_skill = 25
			1:get_main_icon_skill = 27
			2:get_main_icon_skill = 29
			3:get_main_icon_skill = 31
	elif get_img_0_code == "single_spell":
		match code_skill:
			0:get_main_icon_skill = 12
			1:get_main_icon_skill = 15
			2:get_main_icon_skill = 18
			3:get_main_icon_skill = 21
	elif get_img_0_code == "aoe_spell":
		match code_skill:
			0:get_main_icon_skill = 14
			1:get_main_icon_skill = 17
			2:get_main_icon_skill = 20
			3:get_main_icon_skill = 23
	elif get_img_0_code == "single_heal":
		match code_skill:
			0:get_main_icon_skill = 0
			1:get_main_icon_skill = 3
			2:get_main_icon_skill = 6
			3:get_main_icon_skill = 9
	elif get_img_0_code == "aoe_heal":
		match code_skill:
			0:get_main_icon_skill = 2
			1:get_main_icon_skill = 5
			2:get_main_icon_skill = 8
			3:get_main_icon_skill = 11
	caster.default_icon_skill(code_skill, get_main_icon_skill)
	
	var get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.EMTY]
	var get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.EMTY]
	var get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.EMTY]
	var get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.EMTY]
	
	if get_img_0_code == "single":get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.ATK_SINGLE]
	elif get_img_0_code == "aoe":get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.ATK_AOE]
	elif get_img_0_code == "single_spell":get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.NONE]
	elif get_img_0_code == "aoe_spell":get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.NONE]
	elif get_img_0_code == 'single_heal': get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.NONE]
	elif get_img_0_code == "aoe_heal": get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.NONE]
	else: get_img_0_link = data_icon_link[ENUM_RESEUME_ICON.NONE]
	
	if get_img_0_code in ["single", "single_spell", "single_heal"]:
		match set_indic_icon_skill_filter(get_img_1_code):
			0: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.DEBUFF_SINGLE] # 0 DEBUFF
				if get_img_1_code in [2, 3, 4, 5, 6]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.DEBUFF_SINGLE]
				elif get_img_1_code == 43: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_BLUE]
				elif get_img_1_code == 44: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_GREEN]
				elif get_img_1_code == 45: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_GOLD]
			1: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_SINGLE] # 1 BUFF
				if get_img_0_code == "single_spell": get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_SUPP]
				if get_img_1_code == 42: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_RED]
				elif get_img_1_code == 48: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_RNG]
				elif get_img_1_code in [50,51,52,53,54,55]:
					get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ANON_ALLY]
					get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_SINGLE]
				elif get_img_1_code in [59,60,61]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_MULTI]
			2: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.REFECT] # 2 COUNTER
				if get_img_0_code == "single_spell": get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.REFLECT_SUPP]
				if get_img_1_code in [1, 9]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ATK_SINGLE]
				elif get_img_1_code in [56, 57]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.PASSIVE]
				elif get_img_1_code in [73, 74]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.DEBUFF_SINGLE]
				elif get_img_1_code == 75: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ATK_SINGLE]
			3: get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.PASSIVE] # 3 PASSIVE
			4: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.ANON_ALLY] # 4 ANON
				if get_img_0_code == "single_spell": get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.ANON_SUPP]
				if get_img_1_code == 18: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_SINGLE]
				elif get_img_1_code == 19: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ANON_IMMORTAL]
				elif get_img_1_code == 70:
					get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_AOE]
					get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_MULTI]
			5: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.TURN] # 5 TURN
				if get_img_0_code == "single_spell": get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.ANON_SUPP]
				if get_img_1_code == 46: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDI]
				elif get_img_1_code in [47, 78]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDD]
				elif get_img_1_code == 62:
					get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDI]
					get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDD]
				elif get_img_1_code in [76,79,80]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_SKIP]
			6:
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_SINGLE] # 6 HEAL
				if get_img_0_code == "single_spell": get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_SUPP]
				if get_img_1_code == 8: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_VAMP]
				elif get_img_1_code == 17: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_REVIVE]
				elif get_img_1_code == 72: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_INFI]
				
	elif get_img_0_code in ["aoe", "aoe_spell", "aoe_heal"]:
		match set_indic_icon_skill_filter(get_img_1_code):
			0: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.DEBUFF_AOE] # 0 DEBUFF
				if get_img_1_code == 43: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_BLUE]
				elif get_img_1_code == 44: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_GREEN]
				elif get_img_1_code == 45: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_GOLD]
			1: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_AOE] # 1 BUFF
				if get_img_1_code == 42: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.RM_RED]
				elif get_img_1_code == 48: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_RNG]
				elif get_img_1_code in [50,51,52,53,54,55]:
					get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ANON_ALLY]
					get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_SINGLE]
				elif get_img_1_code in [59,60,61]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_MULTI]
			2: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.REFLECT_AOE] # 2 COUNTER
				if get_img_1_code in [1, 9]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ATK_SINGLE]
				elif get_img_1_code in [56, 57]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.PASSIVE]
				elif get_img_1_code in [73, 74]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.DEBUFF_SINGLE]
				elif get_img_1_code == 75: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ATK_SINGLE]
			3: get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.PASSIVE] # 3 PASSIVE
			4: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.ANON_AOE] # 4 ANON
				if get_img_1_code == 18: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_AOE]
				elif get_img_1_code == 19: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.ANON_IMMORTAL]
				elif get_img_1_code == 70:
					get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_AOE]
					get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.SPELL_MULTI]
			5: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.TURN_AOE] # 5 TURN
				if get_img_1_code == 46: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDI]
				elif get_img_1_code in [47, 78]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDD]
				elif get_img_1_code == 62:
					get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDI]
					get_img_3_link = data_icon_link[ENUM_RESEUME_ICON.TURN_CDD]
				elif get_img_1_code in [76,79,80]: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_SKIP]
			6: 
				get_img_1_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_AOE] # 6 HEAL
				if get_img_1_code == 8: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_VAMP]
				elif get_img_1_code == 17: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.TURN_REVIVE]
				elif get_img_1_code == 72: get_img_2_link = data_icon_link[ENUM_RESEUME_ICON.HEAL_INFI]
	match code_skill:
		0: 
			caster.default_skill_0_desc(str(get_img_0_link), str(get_img_1_link), str(get_img_2_link), str(get_img_3_link))
			caster.default_desc(full_desc)
		1: 
			caster.default_skill_1_icon(str(get_img_0_link), str(get_img_1_link))
			caster.default_skill_1_icon_2N3(str(get_img_2_link), str(get_img_3_link))
			caster.default_skill_1_desc(full_desc)
		2: 
			caster.default_skill_2_icon(str(get_img_0_link), str(get_img_1_link))
			caster.default_skill_2_icon_2N3(str(get_img_2_link), str(get_img_3_link))
			caster.default_skill_2_desc(full_desc)
		3: 
			caster.default_skill_ulti_icon(str(get_img_0_link), str(get_img_1_link))
			caster.default_skill_ulti_icon_2N3(str(get_img_2_link), str(get_img_3_link))
			caster.default_ulti_desc(full_desc)

func _get_total_card_count_s1():
	var count = 0
	var get_card = new_card_s1.dict_all_card_s1
	for value in get_card.keys():
		count += 1
	return count-1

func load_skill(_set_skill, _caster, _code):
	var caster = _caster
	var code = _code
	var level
	var pct_req
	var skill_code
	match _set_skill:
		0:
			skill_code = "skill_code"
			level = new_card_s1.dict_all_card_s1[code]["skill_lv"]
			pct_req = new_card_s1.dict_all_card_s1[code]["pct_req"]
		1:
			skill_code = "skill_code_1"
			level = new_card_s1.dict_all_card_s1[code]["skill_1_lv"]
			pct_req = new_card_s1.dict_all_card_s1[code]["pct_req_1"]
		2:
			skill_code = "skill_code_2"
			level = new_card_s1.dict_all_card_s1[code]["skill_2_lv"]
			pct_req = new_card_s1.dict_all_card_s1[code]["pct_req_2"]
		3:
			skill_code = "skill_code_ulti"
			level = new_card_s1.dict_all_card_s1[code]["skill_ulti_lv"]
			pct_req = new_card_s1.dict_all_card_s1[code]["pct_req_ulti"]
	
	match new_card_s1.dict_all_card_s1[code][skill_code]:
		# LOAD SKILL, SELF
		0: skill_00_counter_attack(caster, pct_req)
		1: skill_01_skill_evation(caster, level, pct_req)
		2: skill_02_reduce_deff(caster, level, pct_req)
		3: skill_03_seal(caster, level, pct_req)
		4: skill_04_skill_weakening(caster, level, pct_req)
		5: skill_05_burn(caster, pct_req)
		6: skill_06_poison(caster, pct_req)
		7: skill_07_heal(caster, level, pct_req)
		8: skill_08_vampire(caster, level, pct_req)
		9: skill_09_echo_shield(caster, level, pct_req)
		10:skill_10_crit_dmg(caster, level, pct_req)
		11:skill_11_crit_rate(caster, level, pct_req)
		12:skill_12_turn_speed(caster, level, pct_req)
		13:skill_13_defense_up(caster, level, pct_req)
		14:skill_14_speed_attack(caster, level, pct_req)
		15:skill_15_attack_up(caster, level, pct_req)
		17:skill_17_rebirth(caster, pct_req)
		18:skill_18_rage(caster, level, pct_req)
		19:skill_19_grim_reaper(caster, level)
		20: print("pure skill activated")
		
		# BUFF
		#21: support_to(caster, ENUM_SKILL_CODE.SUPP_COUNTER, level,pct_req)
		#22: support_to(caster, ENUM_SKILL_CODE.SUPP_EVA, level,pct_req)
		#23: support_to(caster, ENUM_SKILL_CODE.SUPP_HEAL, level,pct_req)
		#24: support_to(caster, ENUM_SKILL_CODE.SUPP_VAMP, level,pct_req)
		#25: support_to(caster, ENUM_SKILL_CODE.SUPP_ECHO, level,pct_req)
		#26: support_to(caster, ENUM_SKILL_CODE.SUPP_CDMG, level,pct_req)
		#27: support_to(caster, ENUM_SKILL_CODE.SUPP_CRATE, level,pct_req)
		#28: support_to(caster, ENUM_SKILL_CODE.SUPP_TURN, level,pct_req)
		#29: support_to(caster, ENUM_SKILL_CODE.SUPP_DEFF, level,pct_req)
		#30: support_to(caster, ENUM_SKILL_CODE.SUPP_SPD, level,pct_req)
		#31: support_to(caster, ENUM_SKILL_CODE.SUPP_ATK, level,pct_req)
		
		# BASIC STAT: ONE SHOT ACTIVATED
		32: if caster.psv_attack: # ATTACK
			stat_attack(caster, pct_req)
			caster.psv_attack = false
		33: if caster.psv_defense: # DEFENSE
			stat_deffense(caster, pct_req)
			caster.psv_defense = false
		34: if caster.psv_health: # HEALTH
			stat_health(caster, pct_req)
			caster.psv_health = false
		35: if caster.psv_speed: # TURN SPEED
			stat_speed(caster, pct_req)
			caster.psv_speed = false
		36: if caster.psv_cost: # COST
			stat_cost(caster, pct_req)
			caster.psv_cost = false
		37: if caster.psv_evation: # EVA
			stat_evation(caster, pct_req)
			caster.psv_evation = false
		38: if caster.psv_crit_rate: # CRIT RATE
			stat_crit_rate(caster, pct_req)
			caster.psv_crit_rate = false
		39: if caster.psv_crit_dmg: # CRIT DMG
			stat_crit_dmg(caster, pct_req)
			caster.psv_crit_dmg = false
		40: if caster.psv_crit_deff: # CRIT DEFF
			stat_crit_deff(caster, pct_req)
			caster.psv_crit_deff = false
		41: if caster.psv_speed_attack: # SPEED ATTACK
			stat_speed_atk(caster, pct_req)
			caster.psv_speed_attack = false
		
		# RESET BUFF OR DEBUFF
		42: skill_20_remove_debuff(caster, pct_req)
		43: skill_21_remove_blue_buff(caster, pct_req)
		44: skill_22_remove_gree_buff(caster, pct_req)
		45: skill_23_remove_gold_buff(caster, pct_req)
		
		# COOLDOWN
		46: skill_24_cd_increase(caster, pct_req)
		47: skill_25_cd_decrease(caster, pct_req)
		
		# RANDOM BUFF
		48: skill_26_random_bluebuff(caster, level, pct_req)
		
		# INSTANT HEAL
		49: skill_27_instant_heal(caster, pct_req)
		
		# ONESHOT
		50: skill_28_oneshot_cdmg(caster, level, pct_req)
		51: skill_29_oneshot_crate(caster, level, pct_req)
		52: skill_30_oneshot_turnspeed(caster, level, pct_req)
		53: skill_31_oneshot_defenseup(caster, level, pct_req)
		54: skill_32_oneshot_speedattack(caster, level, pct_req)
		55: skill_33_oneshot_attackup(caster, level, pct_req)
		56: skill_34_onesoht_counter(caster, pct_req)
		57: skill_35_oneshot_eva(caster, level, pct_req)
		58: skill_36_oneshot_grim(caster, level, pct_req)
		
		# MULTI
		59: skill_37_multi_crate_cdmg(caster, level, pct_req)
		60: skill_38_multi_attk_defense(caster, level, pct_req)
		61: skill_39_multi_spda_spdt(caster, level, pct_req)
		62: skill_40_multi_cooldown(caster, level, pct_req)
		
		# NEW SKILL UPDATE
		70: skill_70_last_cursed(caster, level, pct_req)
		72: skill_72_infinite_heal(caster, pct_req)
		73: skill_73_reflect_burn(caster, pct_req)
		74: skill_74_reflect_poison(caster, pct_req)
		75: skill_75_reflect_attack(caster)
		76: skill_76_more_turn(caster, pct_req)
		78: skill_78_refcd_dec(caster, level, pct_req)
		79: skill_79_stun(caster, level, pct_req)
		80: skill_80_amimir(caster, pct_req)
		
		# DEFAULT
		_: print("Skill not set yet for code:", code)


func btn_battle_info_card() ->void:
	$panel_basic_0/battle_info_00/HBoxContainer2/Label.text = str("Click card to activated.")
	battle_info_btn_main(0)
func btn_battle_info_vs() -> void:
	battle_info_btn_main(1)
	$panel_basic_0/battle_info_00/HBoxContainer2/Label.text = str("Battle info battle.")
func btn_battle_info_elem() -> void:
	$panel_basic_0/battle_info_00/HBoxContainer2/Label.text = str("Element set.")
	battle_info_btn_main(2)

func _on_btn_battle_end_exit_pressed() -> void:
	AutoloadData.scene_data	 = "res://scenes/Lobby.tscn"
	get_tree().change_scene_to_file("res://scenes/new_loading_screen.tscn")
