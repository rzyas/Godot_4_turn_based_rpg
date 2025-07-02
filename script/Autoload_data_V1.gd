extends Node

var scene_data:String = ""

var player_level: int = 1
var player_exp_main: int = 0
var player_exp_need: int = 1000
var player_level_exp_limit = {
	1: 1000, 5: 2000, 10: 5000, 15: 10000, 20: 12000, 
	25: 15000, 30: 20000, 40: 25000, 50: 30000, 70: 50000,
	100: 70000, 150: 100000, 200: 125000, 300: 200000, 500: 250000,
	1000: 500000, 2000: 1000000, 5000: 2500000, 10000: 5000000
}

func get_exp_requirement_for_level(level: int) -> int:
	# Cari milestone level terdekat yang <= level saat ini
	var milestone_level = 1
	for key in player_level_exp_limit.keys():
		if level >= key:
			milestone_level = key
	return player_level_exp_limit[milestone_level]

func system_level_manager(value: int):
	player_exp_need = get_exp_requirement_for_level(player_level)
	var total_exp = player_exp_main + value
	while total_exp >= player_exp_need:
		total_exp -= player_exp_need
		player_level += 1
		player_exp_need = get_exp_requirement_for_level(player_level)
	# Set sisa exp setelah level up
	player_exp_main = total_exp
	
	save_data()
	
func update_player_level()->Dictionary:
	var lobby_eq = Lobby_equipments.new()
	return {
		"level":str("LEVEL ", player_level),
		"exp":str(lobby_eq.filter_num_k(player_exp_main),"/",lobby_eq.filter_num_k(player_exp_need)),
		"prog":lobby_eq.set_pct(player_exp_main, player_exp_need)
	}
		
var player_money: int = 0
var player_exp: int = 0
var player_super_ticket: int = 0
var current_stage:int = 0
var player_spin_coin:int = 10
var player_reward:int = 0
var player_reward_special:int = 0
var spin_exp:int = 0
var spin_level:int = 0
var spin_reward:int = 1
var spin_exhance_common:int = 0
var spin_exhance_special:int = 0

# ------------ SETTING:START ------------------
var setting_language_is_EN:bool = true
var setting_default_db_level:Array = [-80.0, -30.0, -10.0, -5.0, 0.0]
var setting_player_db_level = setting_default_db_level[4]

func load_volume_setting():
	var index = setting_default_db_level.find(setting_player_db_level)
	index = clamp(index, 0, 4)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Master'), setting_default_db_level[index])

# ------------ SETTING:END ------------------

var system_cardCollection:Array[String] = [
	"s1_000", "s1_001", "s1_002", "s1_003", "s1_004", "s1_005", "s1_006", "s1_007", "s1_008", "s1_009", "s1_010", "s1_011",
	"s1_012", "s1_013", "s1_014", "s1_015", ]
var player_cardCollection: Array[String] = [
	"s1_000", "s1_001", "s1_002" ]
	
var player_inventory_card_gacha = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0}
var player_inventory_chest = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0}
var player_inventory_enhance = {1: 0, 2: 0, 3: 0, 4: 0}
var player_inventory_fragment = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0, 10: 0, 11: 0, 12: 0, 13: 0, 14: 0, 15: 0, 16: 0, 17: 0, 18: 0, 19: 0, 20: 0, 21: 0, 22: 0, 23: 0, 24: 0, 25: 0, 26: 0, 27: 0, 28: 0, 29: 0, 30: 0}
var player_inventory_misc = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
var player_inventory_token = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0}

var player_equipment:Dictionary = {}
var player_gear:Dictionary = {}
var player_equiped:Dictionary = {}

@onready var cardSet_player: Array[String] = ["s1_000", "s1_001", "s1_002"]
@onready var cardSet_enemy: Array = ["s1_000", "s1_001", "s1_002"]

var redeem_code_history: Array[String] = []
var redeem_pwd_history: Array[String] = []
var redeem_assign_history: Array[String] = []

var story_stage: Dictionary = {
	0: {"total": 1, "clear": false},
	1: {"total": 0, "clear": false},
	2: {"total": 0, "clear": false},
	3: {"total": 0, "clear": false},
	4: {"total": 0, "clear": false},
	5: {"total": 0, "clear": false},
	6: {"total": 0, "clear": false} }

#--------------------------------------------------------------------------------

const SAVE_PATH := "user://save_data.tres"

func _ready():
	reset_data()
	load_data()
func story_update(win_battle_:bool):
	for i in range(7):
		if story_stage[i]["total"] <12 and story_stage[i]["total"] !=0 and win_battle_ and current_stage+1 == story_stage[i]["total"]:
			story_stage[i]["total"]+=1
		if story_stage[i]["total"] == 12 and win_battle_:
			story_stage[i]["clear"] = true
			if story_stage[i+1]["total"] == 0:
				story_stage[i+1]["total"] = 1
	save_data()
func reset_data():
	player_exp_need = 1000
	player_exp_main = 0
	player_level = 1
	setting_player_db_level = setting_default_db_level[4]
	setting_language_is_EN = true
	spin_exhance_special = 0
	spin_exhance_common = 0
	spin_reward = 1
	spin_level = 0
	spin_exp = 0
	player_reward_special = 0
	player_reward = 0
	player_spin_coin = 3
	current_stage = 0
	player_money = 0
	player_exp = 0
	player_super_ticket = 0
	player_cardCollection = ["s1_000", "s1_001", "s1_002", "s1_013"]
	cardSet_player = ["s1_013", "s1_001", "s1_002"]
	cardSet_enemy = ["s1_000", "s1_001", "s1_002"]
	redeem_code_history = []
	redeem_pwd_history = []
	redeem_assign_history = []
	story_stage = {
		0: {"total": 1, "clear": false},
		1: {"total": 0, "clear": false},
		2: {"total": 0, "clear": false},
		3: {"total": 0, "clear": false},
		4: {"total": 0, "clear": false},
		5: {"total": 0, "clear": false},
		6: {"total": 0, "clear": false}}
	player_inventory_card_gacha = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0}
	player_inventory_chest = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0}
	player_inventory_enhance = {1: 0, 2: 0, 3: 0, 4: 0}
	player_inventory_fragment = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0, 10: 0, 11: 0, 12: 0, 13: 0, 14: 0, 15: 0, 16: 0, 17: 0, 18: 0, 19: 0, 20: 0, 21: 0, 22: 0, 23: 0, 24: 0, 25: 0, 26: 0, 27: 0, 28: 0, 29: 0, 30: 0}
	player_inventory_misc = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
	player_inventory_token = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0}
	player_equipment = {}
	player_gear = {}
	player_equiped = {}
	save_data()

func save_data():
	var data := {
		"player_exp_need": player_exp_need,
		"player_exp_main": player_exp_main,
		"player_level": player_level,
		"setting_player_db_level": setting_player_db_level,
		"player_money": player_money,
		"player_exp": player_exp,
		"player_super_ticket": player_super_ticket,
		"player_cardCollection": player_cardCollection,
		"cardSet_player": cardSet_player,
		"cardSet_enemy": cardSet_enemy,
		"redeem_code_history": redeem_code_history,
		"story_stage": story_stage,
		"current_stage": current_stage,
		"redeem_pwd_history": redeem_pwd_history,
		"redeem_assign_history": redeem_assign_history,
		"system_cardCollection": system_cardCollection,
		"player_inventory_card_gacha": player_inventory_card_gacha,
		"player_inventory_chest" : player_inventory_chest,
		"player_inventory_enhance" : player_inventory_enhance,
		"player_inventory_fragment" : player_inventory_fragment,
		"player_inventory_misc" : player_inventory_misc,
		"player_inventory_token" : player_inventory_token,
		"player_equipment" : player_equipment,
		"player_gear" : player_gear,
		"player_equiped" : player_equiped,
		"player_spin_coin": player_spin_coin,
		"player_reward": player_reward,
		"player_reward_special": player_reward_special,
		"spin_exp": spin_exp,
		"spin_level": spin_level,
		"spin_reward": spin_reward,
		"spin_exhance_common": spin_exhance_common,
		"spin_exhance_special": spin_exhance_special,
		"setting_language_is_EN": setting_language_is_EN,
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(data)
	file.close()

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data: Dictionary = file.get_var()
	file.close()
	
	setting_player_db_level = (data.get("setting_player_db_level", setting_default_db_level[4]))
	setting_language_is_EN = bool( data.get("setting_language_is_EN", true) )
	player_exp_need = int(data.get("player_exp_need", 0))
	player_exp_main = int(data.get("player_exp_main", 0))
	player_money = int(data.get("player_money", 0))
	player_exp = int(data.get("player_exp", 0))
	current_stage = int(data.get("current_stage", 0))
	player_super_ticket = int(data.get("player_super_ticket", 0))
	player_reward = int(data.get("player_reward", 0))
	player_spin_coin = int(data.get("player_spin_coin", 0))
	player_reward_special = int(data.get("player_reward_special", 0))
	spin_exp = int(data.get("spin_exp", 0))
	spin_level = int(data.get("spin_level", 0))
	spin_reward = int(data.get("spin_reward", 0))
	spin_exhance_common = int(data.get("spin_exhance_common", 0))
	spin_exhance_special = int(data.get("spin_exhance_special", 0))
	player_level = int(data.get("player_level", 1))
	player_cardCollection = data.get("player_cardCollection", []) as Array
	cardSet_player = data.get("cardSet_player", []) as Array
	cardSet_enemy = data.get("cardSet_enemy", []) as Array
	redeem_code_history = data.get("redeem_code_history", []) as Array
	story_stage = data.get("story_stage", {}) as Dictionary
	player_inventory_card_gacha = data.get("player_inventory_card_gacha", {}) as Dictionary
	player_inventory_chest = data.get("player_inventory_chest", {}) as Dictionary
	player_inventory_enhance = data.get("player_inventory_enhance", {}) as Dictionary
	player_inventory_fragment = data.get("player_inventory_fragment", {}) as Dictionary
	player_inventory_misc = data.get("player_inventory_misc", {}) as Dictionary
	player_inventory_token = data.get("player_inventory_token", {}) as Dictionary
	player_equipment = data.get("player_equipment", {}) as Dictionary
	player_gear = data.get("player_gear", {}) as Dictionary
	player_equiped = data.get("player_equiped", {}) as Dictionary
	redeem_pwd_history = data.get("redeem_pwd_history", []) as Array
	redeem_assign_history = data.get("redeem_assign_history", []) as Array
	system_cardCollection = data.get("system_cardCollection", []) as Array
