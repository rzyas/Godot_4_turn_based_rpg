class_name card_chapter_8
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

func hero_s1_176() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_176"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Barnacub",
		"176_W_BEAST_1_Barnacub", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_177() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_177"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Bubblefin Sprite",
		"177_W_BEAST_1_Bubblefin Sprite", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_178() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_178"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Dribblet",
		"178_W_BEAST_1_Dribblet", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_179() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_179"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Foamling",
		"179_W_BEAST_1_Foamling", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_CODE.MORE_TURN, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_180() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_180"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mistkelp Puff",
		"180_W_BEAST_1_Mistkelp Puff", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_CODE.COUNTER, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_181() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_181"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Mudscale Minnow",
		"181_W_BEAST_1_Mudscale Minnow", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.DRAGON, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_182() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_182"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Pearlscale Puffer",
		"182_W_BEAST_1_Pearlscale Puffer", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_183() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_183"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Qelp",
		"183_W_BEAST_1_Qelp", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_184() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_184"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Ripplefin",
		"184_W_BEAST_1_Ripplefin", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.CRIT_DMG, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_185() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_185"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Seashell Impet",
		"185_W_BEAST_1_Seashell Impet", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_186() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_186"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Shellcrawler",
		"186_W_BEAST_1_Shellcrawler", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.ONESHOT_COUNTER, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_187() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_187"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Splashling",
		"187_W_BEAST_1_Splashling", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_188() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_188"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Splashling",
		"188_W_BEAST_1_Tidehopper", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_POISON, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_189() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_189"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Abyssal Lantern",
		"189_W_BEAST_2_Abyssal Lantern", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.VAMP, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_190() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_190"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Brackmire Lurker",
		"190_W_BEAST_2_Brackmire Lurker", ## CODE GAMBAR
		card_generator.ELEM.WATER,
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
		card_generator.ENUM_SKILL_CODE.POISON, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_191() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_191"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Brinefang Serpent",
		"191_W_BEAST_2_Brinefang Serpent", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.MULTI_ATK_DEF, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_192() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_192"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Coralback Guardian",
		"192_W_BEAST_2_Coralback Guardian", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_193() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_193"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Kelprune Stalker",
		"193_W_BEAST_2_Kelprune Stalker", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_194() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_194"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Moonfin Luriel",
		"194_W_BEAST_2_Moonfin Luriel", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_195() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_195"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Shardscale Pike",
		"195_W_BEAST_2_Shardscale Pike", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_DEFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_DEF_1K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_196() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_196"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Stormfin Ray",
		"196_W_BEAST_2_Stormfin Ray", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_SPDT, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_SPDT_50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_197() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_197"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Varkulith",
		"197_W_BEAST_2_Varkulith", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_198() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_198"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Waveclaw Stalker",
		"198_W_BEAST_2_Waveclaw Stalker", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_199() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_199"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Waveclaw Stalker",
		"199_W_BEAST_3_Brinecrusher Lobstros", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_200() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_200"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Dreadclam Titanis",
		"200_W_BEAST_3_Dreadclam Titanis", ## CODE GAMBAR
		card_generator.ELEM.WATER,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_20K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_500, # CODE DMG
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
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
