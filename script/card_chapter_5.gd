class_name card_chapter_5
extends Node

var new_story_character = Data_story_character.new()
var new_story_character_id = Data_story_character_id.new()
var new_card = card_generator.new()

var all_card: Dictionary = {}

func _init() -> void:
	for m in get_method_list():
		if m.name.begins_with("hero_s1"):
			var hero_data = call(m.name)
			all_card[hero_data["key"]] = hero_data["value"]
			
func hero_s1_101() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_101"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Auric Sentinel",
		"101_L_DEF_5_Auric Sentinel", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REFCD_DEC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		8, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RM_BLUE_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"30", ## AGE
		"172",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_102() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_102"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurielle Sunveil",
		"102_L_DEF_6_Aurielle Sunveil", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.LAST_CURSED, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.SKILL_LOCK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.COUNTER, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"35", ## AGE
		"161",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_103() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_103"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Seraphlet",
		"103_L_HEAL_1_Seraphlet", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.HEALER,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_DEFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_DEF_1K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_HEAL, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_104() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_104"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Seraphis",
		"104_L_HEAL_2_Seraphis", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.HEALER,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_DEFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_DEF_1K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_HEAL, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_105() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_105"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurithal",
		"105_L_HEAL_4_Aurithal", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.HEALER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_40K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE_HEAL, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.HEALTH_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CD_INC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"27", ## AGE
		"183",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_106() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_106"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Lumistra",
		"106_L_HEAL_6_Lumistra", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.HEALER,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_320K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.SKILL_LOCK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL, # TARGET
		card_generator.ENUM_SKILL_CODE.INS_HEAL, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"21", ## AGE
		"165",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_107() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_107"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solmiris",
		"107_L_SUPP_1_Solmiris", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C10, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.SKILL_LOCK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_108() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_108"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solcryst",
		"108_L_SUPP_4_Solcryst", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C70, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.RAND_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"24", ## AGE
		"156",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_109() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_109"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Luminarch Eternis",
		"109_L_SUPP_5_Luminarch Eternis", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RAND_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"24", ## AGE
		"156",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_110() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_110"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Lumirael",
		"110_L_SUPP_5_Lumirael", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_160K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.CRIT_DMG, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.VAMP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"18", ## AGE
		"148",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_111() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_111"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mia",
		"111_L_SUPP_6_Mia", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_160K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.MULTI_ATK_DEF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"31", ## AGE
		"164",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_112() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_112"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Radiantis",
		"112_L_WAR_3_Radiantis", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_5K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"25", ## AGE
		"175",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_113() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_113"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Archangel Solmara",
		"113_L_WAR_5_Archangel Solmara", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.SPEED_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_700, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"26", ## AGE
		"170",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_114() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_114"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Zyphira Solborne",
		"114_L_WAR_6_Zyphira Solborne", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.MULTI_ATK_DEF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RAGE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"23", ## AGE
		"151",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_115() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_115"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurivox Seraph",
		"115_L_WIZ_4_Aurivox Seraph", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.BURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"25", ## AGE
		"177",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_116() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_116"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Halorien",
		"116_L_WIZ_4_Halorien", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.ONESHOT_CRATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		1, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.MULTI_CRATE_CDMG, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"??", ## AGE
		"168",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_117() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_117"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Elydras",
		"117_L_WIZ_5_Elydras", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.BURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.BURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"25", ## AGE
		"183",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_118() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_118"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Halorune",
		"118_L_WIZ_6_Halorune", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.CD_DEC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.CD_INC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"31", ## AGE
		"192",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV3,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_119() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_119"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Barkhopper",
		"119_N_BEAST_1_Barkhopper", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.TURN_SPEED, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_120() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_120"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Barktail",
		"120_N_BEAST_1_Barktail", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_121() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_121"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Drovek",
		"121_N_BEAST_1_Drovek", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CRIT_DMG, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_122() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_122"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Kumbang",
		"122_N_BEAST_1_Kumbang", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_123() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_123"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Manta",
		"123_N_BEAST_1_Manta", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_124() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_124"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mossback",
		"124_N_BEAST_1_Mossback", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.POISON, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_125() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_125"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mossback",
		"125_N_BEAST_1_Nexal", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.TURN_SPEED, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ANIMAL, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
