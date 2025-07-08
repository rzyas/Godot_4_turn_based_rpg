class_name card_chapter_1

var rng_card_star = [card_generator.RANK.STAR_1, card_generator.RANK.STAR_2, card_generator.RANK.STAR_3,
	card_generator.RANK.STAR_4, card_generator.RANK.STAR_5, card_generator.RANK.STAR_6]

# Inisialisasi story data (jika diperlukan)
var new_story_character = Data_story_character.new()
var new_story_character_id = Data_story_character_id.new()
var new_card = card_generator.new()

func hero_s1_000() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_000"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Dimas",
		"N_WAR_1_Dimas", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.WARRIOR,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE_HEAL,
		card_generator.ENUM_SKILL_CODE.PSV_ATK,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_640K,
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C80,
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL,
		card_generator.ENUM_SKILL_CODE.DEFF_UP,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_1K,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.MALE,
		card_generator.ENUM_CHAR_RACE.HUMAN,
		"14", ## AGE
		"160",  ## HEIGH
		"50", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code),
		new_story_character_id.get_story_character(hero_code) )
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_001() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_001"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Karin",
		"N_HEAL_1_Karin", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.HEALER,
		card_generator.RANK.STAR_6,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C10,
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE_HEAL,
		card_generator.ENUM_SKILL_CODE.HEALTH_UP,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_HEAL,
		card_generator.ENUM_SKILL_CODE.RM_DEBUFF,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE,
		card_generator.ENUM_CHAR_RACE.HUMAN,
		"13", ## AGE
		"145",  ## HEIGH
		"42", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.DEFENDER,
		card_generator.ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1,
		# Story
		new_story_character.get_story_character(hero_code),
		new_story_character_id.get_story_character(hero_code) )
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_002() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_002"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Reza",
		"N_SUPP_1_Reza", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.PSV_SPDT,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.PSV_SPDT_50,
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE_SPELL,
		card_generator.ENUM_SKILL_CODE.CRIT_RATE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_400,
		card_generator.ENUM_DESC_LEVEL.LV1,
		card_generator.ENUM_MAIN_CHANCES.C100,
		3, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE_SPELL,
		card_generator.ENUM_SKILL_CODE.DEFF_UP,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_10,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		4, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE,
		card_generator.ENUM_CHAR_RACE.HUMAN,
		"14", ## AGE
		"154",  ## HEIGH
		"46", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code),
		new_story_character_id.get_story_character(hero_code) )
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_003() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_003"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Ulo",
		"N_BEAST_1_Ulo", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.SUPPORT,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C50,
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200,
		card_generator.ENUM_DESC_LEVEL.LV1,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_250,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.POISON,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_50,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C50,
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN,
		card_generator.ENUM_CHAR_RACE.ANIMAL,
		"-", ## AGE
		"-",  ## HEIGH
		"-", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code),
		new_story_character_id.get_story_character(hero_code) )
	return { "key": hero_code, "value": heroes[hero_code] }
func hero_s1_004() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_004"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Kumbang",
		"N_BEAST_1_Kumbang", ## CODE GAMBAR
		card_generator.ELEM.NATURE,
		card_generator.JOB.BEAST,
		card_generator.RANK.STAR_1,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_80,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C50,
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150,
		card_generator.ENUM_DESC_LEVEL.LV1,
		card_generator.ENUM_MAIN_CHANCES.C100,
		1, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.SINGLE,
		card_generator.ENUM_SKILL_CODE.ATTACK_UP,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100,
		card_generator.ENUM_DESC_LEVEL.LV1,
		card_generator.ENUM_MAIN_CHANCES.C100,
		2, ## COOLDOWN
		1, ## HIT
		# Ultimate
		card_generator.ENUM_SKILL_TARGET.AOE,
		card_generator.ENUM_SKILL_CODE.NONE,
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_200,
		card_generator.ENUM_DESC_LEVEL.LV2,
		card_generator.ENUM_MAIN_CHANCES.C50,
		3, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.UNKNOWN,
		card_generator.ENUM_CHAR_RACE.ANIMAL,
		"-", ## AGE
		"-",  ## HEIGH
		"-", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1,
		# Story
		new_story_character.get_story_character(hero_code),
		new_story_character_id.get_story_character(hero_code) )
	return { "key": hero_code, "value": heroes[hero_code] }
