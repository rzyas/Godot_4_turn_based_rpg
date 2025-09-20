class_name card_chapter_4
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

func hero_s1_76() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_076"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Luminflare Archmage",
		"76_F_WIZ_6_Luminflare Archmage", ## CODE GAMBAR
		card_generator.ELEM.FIRE,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.BURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		1, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.SKILL_LOCK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_77() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_077"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solaris Infernum",
		"77_F_WIZ_6_Solaris Infernum", ## CODE GAMBAR
		card_generator.ELEM.FIRE,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.MULTI_SPDA_SPDT, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV3,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_78() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_078"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Dyana",
		"78_L_ARC_4_Dyana", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"23", ## AGE
		"162",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_79() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_079"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Elyssara Starfall",
		"79_L_ARC_4_Elyssara Starfall", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C20, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"26", ## AGE
		"170",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_80() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_080"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Heliora Sunscourge",
		"80_L_ARC_4_Heliora Sunscourge", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_PSDA, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_SPDT_100, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.EVA, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"21", ## AGE
		"154",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_81() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_081"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solaris Arclight",
		"81_L_ARC_4_Solaris Arclight", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_SPDT_100, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"25", ## AGE
		"170",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_82() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_082"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Caelith Radiantmark",
		"82_L_ARC_5_Caelith Radiantmark", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_20K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.MORE_TURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"25", ## AGE
		"172",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_83() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_083"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Isyra the Gleam",
		"83_L_ARC_5_Isyra the Gleam", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_40K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.EVA, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_500, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"18", ## AGE
		"161",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_84() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_084"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurelis Dawnpiercer",
		"84_L_ARC_6_Aurelis Dawnpiercer", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.ONESHOT_CRATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RM_BLUE_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"32", ## AGE
		"182",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV3,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_85() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_085"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solcrane",
		"85_L_ASSA_2_Solcrane", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ASSASIN,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
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
func hero_s1_86() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_086"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solmantis",
		"86_L_ASSA_2_Solmantis", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ASSASIN,
		card_generator.RANK.STAR_2,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
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
func hero_s1_87() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_087"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Celestrike",
		"87_L_ASSA_5_Celestrike", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ASSASIN,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_SPDT, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_SPDT_200, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.CRIT_DMG, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_88() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_088"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Seraphim Aurelios",
		"88_L_ASSA_5_Seraphim Aurelios", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.ASSASIN,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.MORE_TURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.RM_BLUE_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.SKILL_LOCK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"29", ## AGE
		"180",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_89() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_089"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Dawnstag",
		"89_L_BEAST_1_Dawnstag", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_90() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_090"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Glareon",
		"90_L_BEAST_1_Glareon", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
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
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_91() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_091"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Glintpaw",
		"91_L_BEAST_1_Glintpaw", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.REVIVE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		1, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV1,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_92() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_092"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solarian Hound",
		"92_L_BEAST_1_Solarian Hound", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C40, # CHANGES
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
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
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
func hero_s1_93() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_093"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurivine",
		"93_L_BEAST_3_Aurivine", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_10K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.ATTACK_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
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
func hero_s1_94() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_094"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Lumivox",
		"94_L_BEAST_3_Lumivox", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_10K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
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
func hero_s1_95() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_095"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurelia Dawnward",
		"95_L_DEF_3_Aurelia Dawnward", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_ATTACK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"19", ## AGE
		"161",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_96() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_096"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Seraphaela",
		"96_L_DEF_3_Seraphaela", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_20K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"25", ## AGE
		"166",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_97() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_097"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Solenne Veyra",
		"97_L_DEF_3_Solenne Veyra", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_3,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REFCD_DEC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_20K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.HEALTH_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.CD_INC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
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
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.HUMAN, # RACE
		"26", ## AGE
		"185",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_98() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_098"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Halcyros",
		"98_L_DEF_4_Halcyros", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CD_INC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"22", ## AGE
		"172",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_99() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_099"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurelian Wisp",
		"99_L_DEF_5_Aurelian Wisp", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_80K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.SPEED_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.RM_DEBUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.SPIRIT, # RACE
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
func hero_s1_100() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_100"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Aurelon Warden",
		"100_L_DEF_5_Aurelon Warden", ## CODE GAMBAR
		card_generator.ELEM.LIGHT,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RM_GOLD_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_CODE.RM_GOLD_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.GOD, # RACE
		"23", ## AGE
		"179",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
