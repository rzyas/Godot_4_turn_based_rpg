extends Node
func filter_num_k(value: int) -> String:
	var thresholds = [
		[1e21, "Sx"], # Sextillion
		[1e18, "Qi"], # Quintillion
		[1e15, "Qa"], # Quadrillion
		[1e12, "T"],  # Trillion
		[1e9, "B"],   # Billion
		[1e6, "M"],   # Million
		[1e3, "K"],   # Thousand
	]
	for threshold in thresholds:
		if value >= threshold[0]:
			return "%.2f%s" % [value / threshold[0], threshold[1]]
	return str(value)

func set_pct(total: int, angka_utama: int) -> int:
	if total == 0:
		return 0 # Hindari pembagian oleh nol
	return int((angka_utama * 100.0) / total)

var scene_data: String = ""
# =====================================================
# DECLARATIVE DATA STRUCTURE - Tambah data baru di sini saja!
# =====================================================
# Player progression data
var player_name = ""
var player_level: int = 1
var player_exp_main: int = 0
var player_exp_need: int = 1000
var player_money: int = 0
var player_exp: int = 0
var player_super_ticket: int = 0
var player_spin_coin: int = 10
var player_reward: int = 0
var player_reward_special: int = 0
# Stage
var temp_bab=0
var temp_stage=0
var current_stage: int = 0
var stage_star = {
	0:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	1:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	2:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	3:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	4:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	5:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	6:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], }
# Spin system data
var spin_exp: int = 0
var spin_level: int = 0
var spin_reward: int = 1
var spin_exhance_common: int = 0
var spin_exhance_special: int = 0
# Settings
var setting_language_is_EN: bool = true
var setting_default_db_level: Array = [-80.0, -30.0, -10.0, -5.0, 0.0]
var setting_player_db_level = setting_default_db_level[4]
# Collections and inventories
var system_cardCollection: Array[String] = [
	"s1_000", "s1_001", "s1_002", "s1_003", "s1_004"
]
var player_cardCollection: Array[String] = [
	"s1_000", "s1_001", "s1_002"
]
var player_cardAvailable: Array[String] = []
var player_inventory_card_gacha = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0}
var player_inventory_chest = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0}
var player_inventory_enhance = {1: 0, 2: 0, 3: 0, 4: 0}
var player_inventory_fragment = {
	1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0, 10: 0,
	11: 0, 12: 0, 13: 0, 14: 0, 15: 0, 16: 0, 17: 0, 18: 0, 19: 0, 20: 0,
	21: 0, 22: 0, 23: 0, 24: 0, 25: 0, 26: 0, 27: 0, 28: 0, 29: 0, 30: 0
}
var player_inventory_misc = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
var player_inventory_token = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0}

var player_equipment: Dictionary = {}
var player_gear: Dictionary = {}
var player_equiped: Dictionary = {}

@onready var cardSet_player: Array[String] = ["s1_000", "s1_001", "s1_002"]
@onready var cardSet_enemy: Array = ["s1_000", "s1_001", "s1_002"]

var redeem_code_history: Array[String] = []
var redeem_pwd_history: Array[String] = []
var redeem_assign_history: Array[String] = []
# ========================================
# ROADMAP
# ========================================
var roadmap_total_enhance:int=0
var roadmap_total_spin:int=0
var roadmap_total_eq:int=0
var roadmap_total_heal_gift:int=0
var roadmap_total_heal_taked:int=0
var roadmap_total_damages:int=0
var roadmap_total_battle:int=0
var roadmap_gold:int=0
var roadmap_mana:int=0
enum ENUM_ROADMAP_REWARD{GOLD,MANA,TICKET,SPIN}
var roadmap_data = {
	0:{"quest":2, "increment":1, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":1},
	1:{"quest":1, "increment":1, "rwd":ENUM_ROADMAP_REWARD.TICKET, "count":500},
	2:{"quest":18, "increment":18, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":3},
	3:{"quest":1000000, "increment":1000000, "rwd":ENUM_ROADMAP_REWARD.GOLD, "count":100000},
	4:{"quest":100000, "increment":100000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":10000},
	5:{"quest":25, "increment":25, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":1},
	6:{"quest":1000000, "increment":1000000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":25000},
	7:{"quest":500000, "increment":500000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":25000},
	8:{"quest":500000, "increment":500000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":25000},
	9:{"quest":1, "increment":1, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":1},
	10:{"quest":10, "increment":10, "rwd":ENUM_ROADMAP_REWARD.TICKET, "count":300},
	11:{"quest":10, "increment":10, "rwd":ENUM_ROADMAP_REWARD.TICKET, "count":2000},
	12:{"quest":10, "increment":10, "rwd":ENUM_ROADMAP_REWARD.GOLD, "count":500000},
}
# ======================================================
# STORY MANAGER
# ======================================================
var story_stage: Dictionary = {
	0: {"total": 1, "clear": false},
	1: {"total": 0, "clear": false},
	2: {"total": 0, "clear": false},
	3: {"total": 0, "clear": false},
	4: {"total": 0, "clear": false},
	5: {"total": 0, "clear": false},
	6: {"total": 0, "clear": false} }
func story_update(win_battle_: bool):
	if story_stage[temp_bab]['clear']==true or win_battle_==false: return
	
	var is_last_stage = story_stage[temp_bab]['total'] == temp_stage+1
	if is_last_stage:
		story_stage[temp_bab]['total']+=1
		if story_stage[temp_bab]['total']==13:
			story_stage[temp_bab]['clear']=true
			if story_stage.has(temp_bab+1):
				story_stage[temp_bab+1]['total']=1
	save_data()
# =====================================================
# CONFIGURATION
# =====================================================
var player_level_exp_limit = {
	1: 1000, 5: 2000, 10: 5000, 15: 10000, 20: 12000, 
	25: 15000, 30: 20000, 40: 25000, 50: 30000, 70: 50000,
	100: 70000, 150: 100000, 200: 125000, 300: 200000, 500: 250000,
	1000: 500000, 2000: 1000000, 5000: 2500000, 10000: 5000000 }
# Security key untuk enkripsi
const ENCRYPTION_KEY = "M4A1AK47356E_$GODOT44_INDONESIA45"
const SAVE_PATH := "user://save_data.dat"
const CHECKSUM_PATH := "user://save_checksum.dat"
const SAVE_VERSION := "2.0"
# =====================================================
# AUTOMATIC SAVE SYSTEM - TIDAK PERLU DIUBAH!
# =====================================================
# Variables yang tidak perlu disave (exclude dari save)
var _excluded_variables: Array[String] = [
	"scene_data", "_excluded_variables", "_save_variables_cache", 
	"setting_default_db_level", "system_cardCollection", "player_level_exp_limit"]
# Cache untuk mempercepat akses
var _save_variables_cache: Array[String] = []
func _ready():
	reset_data()
	_initialize_save_system()
	load_data()
func _initialize_save_system():
	"""Initialize save system dan cache variables yang akan disave"""
	_save_variables_cache.clear()
	# Get semua property dari script ini
	var property_list = get_property_list()
	for property in property_list:
		var var_name = property.name
		# Skip built-in properties dan excluded variables
		if var_name.begins_with("_") or var_name in _excluded_variables:
			continue
		# Skip method dan constants
		if property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			_save_variables_cache.append(var_name)
	print("Variables yang akan disave: ", _save_variables_cache)
# =====================================================
# GAME LOGIC FUNCTIONS
# =====================================================
func get_exp_requirement_for_level(level: int) -> int:
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
	player_exp_main = total_exp
	save_data()
func update_player_level() -> Dictionary:
	var lobby_eq = Lobby_equipments.new()
	var filter_name = player_name.substr(0, 14)
	return {
		"level": str("LEVEL ", player_level, " (",filter_name,")"),
		"exp": str(lobby_eq.filter_num_k(player_exp_main), "/", lobby_eq.filter_num_k(player_exp_need)),
		"prog": lobby_eq.set_pct(player_exp_main, player_exp_need)
	}
func load_volume_setting():
	var index = setting_default_db_level.find(setting_player_db_level)
	index = clamp(index, 0, 4)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index('Master'), setting_default_db_level[index])
# =====================================================
# AUTOMATIC SAVE/LOAD SYSTEM
# =====================================================
func get_current_data() -> Dictionary:
	"""Automatically collect all saveable data"""
	var data = {}
	
	for var_name in _save_variables_cache:
		data[var_name] = get(var_name)
	
	# Add metadata
	data["timestamp"] = Time.get_unix_time_from_system()
	data["version"] = SAVE_VERSION
	
	return data
func apply_loaded_data(data: Dictionary):
	"""Automatically apply loaded data to variables"""
	for var_name in _save_variables_cache:
		if data.has(var_name):
			set(var_name, data[var_name])
		# Jika variable baru tidak ada di save lama, gunakan default value (sudah diset di reset_data)
	
	# Update exp_need berdasarkan level yang dimuat
	player_exp_need = get_exp_requirement_for_level(player_level)

func reset_data():
	player_cardAvailable = []
	roadmap_total_enhance=0
	roadmap_total_spin=0
	roadmap_total_eq=0
	roadmap_total_heal_gift=0
	roadmap_total_heal_taked=0
	roadmap_total_damages=0
	roadmap_total_battle=0
	roadmap_gold=0
	roadmap_mana=0
	temp_bab=0
	temp_stage=0
	stage_star = {
		0:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		1:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		2:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		3:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		4:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		5:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		6:[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], }
	roadmap_data = {
		0:{"quest":2, "increment":1, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":1},
		1:{"quest":1, "increment":1, "rwd":ENUM_ROADMAP_REWARD.TICKET, "count":500},
		2:{"quest":18, "increment":18, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":3},
		3:{"quest":1000000, "increment":1000000, "rwd":ENUM_ROADMAP_REWARD.GOLD, "count":100000},
		4:{"quest":100000, "increment":100000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":10000},
		5:{"quest":25, "increment":25, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":1},
		6:{"quest":1000000, "increment":1000000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":25000},
		7:{"quest":500000, "increment":500000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":25000},
		8:{"quest":500000, "increment":500000, "rwd":ENUM_ROADMAP_REWARD.MANA, "count":25000},
		9:{"quest":1, "increment":1, "rwd":ENUM_ROADMAP_REWARD.SPIN, "count":1},
		10:{"quest":10, "increment":10, "rwd":ENUM_ROADMAP_REWARD.TICKET, "count":300},
		11:{"quest":10, "increment":10, "rwd":ENUM_ROADMAP_REWARD.TICKET, "count":2000},
		12:{"quest":10, "increment":10, "rwd":ENUM_ROADMAP_REWARD.GOLD, "count":500000},
	}
	# NEW DATA defaults - Tambahkan default values untuk data baru
	"""Reset semua data ke default values"""
	player_name = "tanpa nama"
	player_level = 10
	player_exp_main = 0
	player_exp_need = 1000
	player_money = 0
	player_exp = 0
	player_super_ticket = 0
	current_stage = 0
	player_spin_coin = 0
	player_reward = 0
	player_reward_special = 0
	
	spin_exp = 0
	spin_level = 0
	spin_reward = 1
	spin_exhance_common = 0
	spin_exhance_special = 0
	
	setting_player_db_level = setting_default_db_level[4]
	setting_language_is_EN = true
	
	player_cardCollection = ["s1_000", "s1_001", "s1_002"]
	cardSet_player = ["s1_000", "s1_001", "s1_002"]
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
		6: {"total": 0, "clear": false}
	}
	
	player_inventory_card_gacha = {1:0, 2:0, 3:0, 4:0, 5:0, 6:0}
	player_inventory_chest = {1:2, 2:3, 3:2, 4:43, 5:34, 6:198, 7:22, 8:34}
	player_inventory_enhance = {1:12, 2:320, 3:76, 4: 12}
	player_inventory_fragment = {
		1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0, 10: 0,
		11: 0, 12: 0, 13: 0, 14: 0, 15: 0, 16: 0, 17: 0, 18: 0, 19: 0, 20: 0,
		21: 0, 22: 0, 23: 0, 24: 0, 25: 0, 26: 0, 27: 0, 28: 0, 29: 0, 30: 0
	}
	player_inventory_misc = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
	player_inventory_token = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0}
	
	player_equipment = {}
	player_gear = {}
	player_equiped = {}
	
	save_data()
# =====================================================
# SAVE/LOAD FUNCTIONS
# =====================================================
func generate_checksum(data: Dictionary) -> String:
	var json_string = JSON.stringify(data)
	return json_string.md5_text()

func validate_data_integrity(data: Dictionary) -> bool:
	# Validasi rentang nilai yang masuk akal
	if data.get("player_level", 1) < 1 or data.get("player_level", 1) > 999999:
		return false
	if data.get("player_money", 0) < 0 or data.get("player_money", 0) > 999999999:
		return false
	if data.get("player_exp_main", 0) < 0:
		return false
	if data.get("current_stage", 0) < 0 or data.get("current_stage", 0) > 1000:
		return false
	# Validasi konsistensi data
	var level = data.get("player_level", 1)
	var exp_need = get_exp_requirement_for_level(level)
	var exp_main = data.get("player_exp_main", 0)
	if exp_main >= exp_need:
		return false
	return true

func save_data():
	"""Save data using automatic system"""
	var data = get_current_data()
	# Generate checksum
	var checksum = generate_checksum(data)
	# Simpan file utama dengan enkripsi
	var file := FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, ENCRYPTION_KEY)
	if file == null:
		print("Error: Tidak bisa membuat file save")
		return
	file.store_var(data)
	file.close()
	# Simpan checksum terpisah
	var checksum_file := FileAccess.open(CHECKSUM_PATH, FileAccess.WRITE)
	if checksum_file != null:
		checksum_file.store_string(checksum)
		checksum_file.close()
	#print("Data saved successfully with ", _save_variables_cache.size(), " variables")
func load_data():
	"""Load data using automatic system"""
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found, using defaults")
		return
	# Load file utama
	var file := FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, ENCRYPTION_KEY)
	if file == null:
		print("Error: Tidak bisa membaca file save atau key salah")
		return
	var loaded_data: Dictionary = file.get_var()
	file.close()
	# Validasi checksum jika ada
	if FileAccess.file_exists(CHECKSUM_PATH) and loaded_data.has("timestamp"):
		var checksum_file := FileAccess.open(CHECKSUM_PATH, FileAccess.READ)
		if checksum_file != null:
			var stored_checksum = checksum_file.get_as_text()
			checksum_file.close()
			var current_checksum = generate_checksum(loaded_data)
			if stored_checksum != current_checksum:
				print("Warning: Data integrity check failed")
				create_backup_from_corrupted(loaded_data)
	# Validasi data integrity
	if not validate_data_integrity(loaded_data):
		print("Warning: Data validation failed, attempting recovery")
		loaded_data = attempt_data_recovery(loaded_data)
	# Apply loaded data
	apply_loaded_data(loaded_data)
	# Save ulang dengan format terbaru jika perlu upgrade
	var loaded_version = loaded_data.get("version", "1.0")
	if loaded_version != SAVE_VERSION:
		print("Upgrading save file from version ", loaded_version, " to ", SAVE_VERSION)
		save_data()
	print("Data loaded successfully. Version: ", loaded_version)
# =====================================================
# RECOVERY AND BACKUP FUNCTIONS
# =====================================================
func attempt_data_recovery(data: Dictionary) -> Dictionary:
	var recovered_data = data.duplicate()
	# Fix level jika tidak wajar
	if recovered_data.get("player_level", 1) < 1:
		recovered_data["player_level"] = 1
	elif recovered_data.get("player_level", 1) > 10000:
		recovered_data["player_level"] = 10000
	# Fix money jika negatif
	if recovered_data.get("player_money", 0) < 0:
		recovered_data["player_money"] = 0
	# Fix exp jika negatif
	if recovered_data.get("player_exp_main", 0) < 0:
		recovered_data["player_exp_main"] = 0
	# Fix stage jika negatif
	if recovered_data.get("current_stage", 0) < 0:
		recovered_data["current_stage"] = 0
	# Fix exp consistency
	var level = recovered_data.get("player_level", 1)
	var exp_need = get_exp_requirement_for_level(level)
	var exp_main = recovered_data.get("player_exp_main", 0)
	if exp_main >= exp_need:
		recovered_data["player_exp_main"] = exp_need - 1
	return recovered_data

func create_backup_from_corrupted(data: Dictionary):
	var backup_path = "user://corrupted_backup_" + str(Time.get_unix_time_from_system()) + ".dat"
	var backup_file = FileAccess.open(backup_path, FileAccess.WRITE)
	if backup_file != null:
		backup_file.store_var(data)
		backup_file.close()
		print("Backup corrupted data to: ", backup_path)

func create_backup():
	if FileAccess.file_exists(SAVE_PATH):
		var backup_path = "user://save_backup_" + str(Time.get_unix_time_from_system()) + ".dat"
		var original_file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, ENCRYPTION_KEY)
		var backup_file = FileAccess.open_encrypted_with_pass(backup_path, FileAccess.WRITE, ENCRYPTION_KEY)
		if original_file != null and backup_file != null:
			var data = original_file.get_var()
			backup_file.store_var(data)
			original_file.close()
			backup_file.close()
			print("Backup created: ", backup_path)

func emergency_reset():
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
	if FileAccess.file_exists(CHECKSUM_PATH):
		DirAccess.remove_absolute(CHECKSUM_PATH)
	reset_data()
	print("Emergency reset completed")
# =====================================================
# UTILITY FUNCTIONS
# =====================================================
func add_currency(currency_name: String, amount: int):
	"""Helper function untuk menambah currency secara aman"""
	if has_method("set") and has_method("get"):
		var current_value = get(currency_name)
		if current_value != null and current_value is int:
			set(currency_name, current_value + amount)
			save_data()
			print("Added ", amount, " ", currency_name, ". New total: ", get(currency_name))
		else:
			print("Error: Currency '", currency_name, "' not found or not integer type")

func get_currency(currency_name: String) -> int:
	"""Helper function untuk mendapatkan currency"""
	var value = get(currency_name)
	if value != null and value is int:
		return value
	return 0

# Contoh penggunaan:
# GameData.add_currency("new_gold_currency", 100)
# GameData.add_currency("premium_gems", 50)
# var gold = GameData.get_currency("new_gold_currency")
