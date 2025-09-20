class_name card_chapter_6
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

func hero_s1_126() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_126"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Skarnath",
		"126_N_BEAST_1_Skarnath", ## CODE GAMBAR
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
		card_generator.ENUM_SKILL_CODE.BURN, # CODE SKILL
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
func hero_s1_127() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_127"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Takky",
		"127_N_BEAST_1_Takky", ## CODE GAMBAR
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
func hero_s1_128() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_128"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Thryzarak",
		"128_N_BEAST_1_Thryzarak", ## CODE GAMBAR
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
func hero_s1_129() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_129"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Ulo",
		"129_N_BEAST_1_Ulo", ## CODE GAMBAR
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
func hero_s1_130() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_130"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Velkren",
		"130_N_BEAST_1_Velkren", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_POISON, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
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
func hero_s1_131() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_131"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Velkren",
		"131_N_BEAST_1_Vinehare", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.EVA, # CODE SKILL
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
func hero_s1_132() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_132"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Visky",
		"132_N_BEAST_1_Visky", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
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
func hero_s1_133() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_133"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Froghorn",
		"133_N_BEAST_2_Froghorn", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
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
func hero_s1_134() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_134"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Grivok",
		"134_N_BEAST_2_Grivok", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
func hero_s1_135() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_135"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Kanciul",
		"135_N_BEAST_2_KANCIUL", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.EVA, # CODE SKILL
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
func hero_s1_136() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_136"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Lyfern",
		"136_N_BEAST_2_Lyfern", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.EVA, # CODE SKILL
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
func hero_s1_137() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_137"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Rootmaw",
		"137_N_BEAST_2_Rootmaw", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
func hero_s1_138() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_138"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Tenbony",
		"138_N_BEAST_2_Tenbony", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
func hero_s1_139() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_139"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Thornstag",
		"139_N_BEAST_2_Thornstag", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.SPEED_ATK, # CODE SKILL
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
func hero_s1_140() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_140"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Varnisk",
		"140_N_BEAST_2_Varnisk", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
func hero_s1_141() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_141"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Verdantusk",
		"141_N_BEAST_2_Verdantusk", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
func hero_s1_142() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_142"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Vineraptor",
		"142_N_BEAST_2_Vineraptor", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.EVA, # CODE SKILL
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
func hero_s1_143() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_143"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Barkfang",
		"143_N_BEAST_3_Barkfang", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.SPEED_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
func hero_s1_144() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_144"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Bramblehowl",
		"144_N_BEAST_3_Bramblehowl", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
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
func hero_s1_145() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_145"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Brambletusk",
		"145_N_BEAST_3_Brambletusk", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
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
func hero_s1_146() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_146"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Evermaw Serpent",
		"146_N_BEAST_3_Evermaw Serpent", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_POISON, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
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
func hero_s1_147() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_147"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Fernclaw",
		"147_N_BEAST_3_Fernclaw", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CRIT_DMG, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
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
func hero_s1_148() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_148"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mossclaw",
		"148_N_BEAST_3_Mossclaw", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_20K, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
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
func hero_s1_149() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_149"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mosspelt",
		"149_N_BEAST_3_Mosspelt", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_20K, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
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
func hero_s1_150() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_150"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Thistlehorn",
		"150_N_BEAST_3_Thistlehorn", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
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
