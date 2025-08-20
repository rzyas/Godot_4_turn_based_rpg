class_name card_chapter_2
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
			
func hero_s1_26() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_026"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Vorthyss, King of the Bloodbound Legion",
		"26_D_DEF_6_Vorthyss, King of the Bloodbound Legion", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.DEFENSE,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_HP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_HP_640K, # CHANGES
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
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.AMIMIR, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"??", ## AGE
		"312",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV3,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_27() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_027"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Zahrith",
		"27_D_HEAL_4_Zahrith", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.HEALER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RM_BLUE_BUFF, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
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
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL, # TARGET
		card_generator.ENUM_SKILL_CODE.HEALTH_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
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
func hero_s1_29() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_029"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Hugi",
		"28_D_SUPP_5_Hugi", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C30, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.CRIT_RATE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		4, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TERGET
		card_generator.ENUM_SKILL_CODE.CD_DEC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV3, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.CD_INC, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"28", ## AGE
		"170",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_30() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_030"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Veyssira",
		"30_D_WAR_4_Veyssira", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.ONESHOT_EVA, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C50, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C90, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_500, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_700, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		5, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"89", ## AGE
		"172",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_31() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_031"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Zevrath",
		"31_D_WAR_4_Zevrath", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.RAGE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
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
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_500, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_32() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_032"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Nyvraelle",
		"32_D_WAR_5_Nyvraelle", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_5,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_20K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_500, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.MULTI_CRATE_CDMG, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"??", ## AGE
		"??",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_33() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_033"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Malzharion, King of the Abyssal Flames",
		"33_D_WAR_6_Malzharion, King of the Abyssal Flames", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.REF_BURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C90, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.BURN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.WEAKENING, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C60, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_700, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"187", ## AGE
		"285",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.ATTACKER,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV3,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_34() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_034"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Virexan",
		"34_D_WIZ_1_Virexan", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.MAGE,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL, # TARGET
		card_generator.ENUM_SKILL_CODE.POISON, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV1, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.DEFF_BREAK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		3, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.STUN, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		4, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_3K, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C100, # CHANGES
		10, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
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
