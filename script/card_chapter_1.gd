class_name card_chapter_1

var rng_card_star = [card_generator.RANK.STAR_1, card_generator.RANK.STAR_2, card_generator.RANK.STAR_3,
	card_generator.RANK.STAR_4, card_generator.RANK.STAR_5, card_generator.RANK.STAR_6]

# Inisialisasi story data (jika diperlukan)
var new_story_character = Data_story_character.new()
var new_story_character_id = Data_story_character_id.new()
var new_card = card_generator.new()

func hero_s1_1() -> Dictionary:
	var heroes:Dictionary = {}
	var hero_code = "s1_001"
	heroes[hero_code] = new_card.create_card(
		hero_code,
		"Thalyss",
		"1_D_ARC_4_Thalyss", ## CODE GAMBAR
		card_generator.ELEM.DARK,
		card_generator.JOB.ARCHER,
		card_generator.RANK.STAR_4,
		# Basic skill
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TARGET
		card_generator.ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_100, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.PSV_ATK_10K, # CHANGES
		1, ## HIT
		# Skill 1
		card_generator.ENUM_SKILL_TARGET.SINGLE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_300, # CODE DMG
		card_generator.ENUM_DESC_LEVEL.LV2, # CODE LEVEL
		card_generator.ENUM_MAIN_CHANCES.C80, # CHANGES
		2, ## COOLDOWN
		1, ## HIT
		# Skill 2
		card_generator.ENUM_SKILL_TARGET.AOE, # TERGET
		card_generator.ENUM_SKILL_CODE.NONE, # CODE SKILL
		card_generator.ENUM_SKILL_DAMAGE.SKILL_DMG_150, # CODE DMG
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
		4, ## COOLDOWN
		1, ## HIT
		# Character info
		card_generator.ENUM_CHAR_GENDER.FEMALE, # GENDER
		card_generator.ENUM_CHAR_RACE.ABBYS, # RACE
		"??", ## AGE
		"165",  ## HEIGH
		"??", ## WEIGH
		# Custom rank
		card_generator.ENUM_CUSTOM_RANK.AGILITY,                                                                        
		card_generator.ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2,
		# Story
		new_story_character.get_story_character(hero_code), # EN
		new_story_character_id.get_story_character(hero_code) ) # ID
	return { "key": hero_code, "value": heroes[hero_code] }
