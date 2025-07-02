#extends RefCounted
class_name card_generator

# Import enums dan fungsi dari Card_data_s1
enum ELEM{LIGHT, NATURE, WATER, DARK, FIRE}
enum JOB{WARRIOR, ARCHER, DEFENSE, ASSASIN, SUPPORT, MECH, BEAST, MAGE, HEALER}
enum RANK{STAR_1, STAR_2, STAR_3, STAR_4, STAR_5, STAR_6}
enum ENUM_SKILL_TARGET{SINGLE, AOE, SINGLE_SPELL, AOE_SPELL, SINGLE_HEAL, AOE_HEAL}
enum ENUM_MAIN_CHANCES{
	C10=10, C20=20, C30=30, C40=40, C50=50, C60=60, C70=70, C80=80, C90=90, C100=100,
	PSV_ATK_5K=5000, PSV_ATK_10K=10000, PSV_ATK_20K=20000, PSV_ATK_40K=40000, PSV_ATK_80K=80000, PSV_ATK_160K=160000,
	PSV_ATK_320K=320000, PSV_ATK_640K=640000,
	PSV_DEF_1K=1000, PSV_DEF_2K=2000, PSV_DEF_3K=3000, PSV_DEF_4K=4000, PSV_DEF_5K=5000,
	PSV_HP_20K=20000, PSV_HP_40K=40000, PSV_HP_80K=80000, PSV_HP_160K=160000, PSV_HP_320K=320000, PSV_HP_640K=640000, PSV_HP_1280K=1280000,
	PSV_SPDT_50=50, PSV_SPDT_100=100, PSV_SPDT_150=150, PSV_SPDT_200=200, PSV_SPDT_250=250, PSV_SPDT_300=300, PSV_SPDT_350=350, PSV_SPDT_400=400,
	PSV_SPDT_450=450, PSV_SPDT_500=500,
	PSV_EVA_20=20, PSV_EVA_40=40, PSV_EVA_80=80, PSV_EVA_160=160,
	PSV_CRATE_10=10, PSV_CRATE_20=20, PSV_CRATE_30=30, PSV_CRATE_40=40, PSV_CRATE_50=50,
	PSV_CDMG_100=100, PSV_CDMG_200=200, PSV_CDMG_300=300, PSV_CDMG_400=400, PSV_CDMG_500=500,
	PSV_CDEF_10=10, PSV_CDEF_20=20, SPV_CDEF_30=30, PSV_CDEF_40=40, PSV_CDEF_50=50, 
	PSV_SPDA_50=50, PSV_SPDA_100=100, PSV_SPDA_150=150, PSV_SPDA_200=200, PSV_SPDA_250=250
}
enum ENUM_DESC_LEVEL{LV1=1, LV2, LV3}
enum ENUM_SKILL_CODE{
	COUNTER=0, EVA, DEFF_BREAK, SKILL_LOCK, WEAKENING, BURN, POISON, HEALTH_UP, VAMP, ECHO_SHIELD, CRIT_DMG, CRIT_RATE,
	TURN_SPEED, DEFF_UP, SPEED_ATK, ATTACK_UP, COOLDOWN, REVIVE, RAGE, GRIM, NONE, SUPP_COUNTER, SUPP_EVA, SUPP_HEAL, SUPP_VAMP,
	SUPP_ECHO, SUPP_CDMG, SUPP_CRATE, SUPP_TURN, SUPP_DEFF, SUPP_SPD, SUPP_ATK, PSV_ATK, PSV_DEFF, PSV_HP, PSV_SPDT, PSV_CST,
	PSV_EVA, PSV_CRATE, PSV_CDMG, PSV_CDEF, PSV_PSDA, RM_DEBUFF, RM_BLUE_BUFF, RM_GREEN_BUFF, RM_GOLD_BUFF, CD_INC, CD_DEC,
	RAND_BUFF, INS_HEAL, ONESHOT_CDMG, ONESHOT_CRATE, ONESHOT_TSPD, ONESHOT_DEF, ONESHOT_ASPD, ONESHOT_ATTACKUP, ONESHOT_COUNTER,
	ONESHOT_EVA, ONESHOT_GRIM, MULTI_CRATE_CDMG, MULTI_ATK_DEF, MULTI_SPDA_SPDT, MULTI_COOLDOWN, LAST_CURSED=70, INFI_HEAL=72,
	REF_BURN=73, REF_POISON=74, REF_ATTACK=75, MORE_TURN=76, REFCD_DEC=78, STUN=79, AMIMIR=80
}
enum ENUM_SKILL_DAMAGE{
	SKILL_DMG_0=0, SKILL_DMG_10=10, SKILL_DMG_30=30, SKILL_DMG_50=50, SKILL_DMG_80=80, SKILL_DMG_100=100, SKILL_DMG_150=150,
	SKILL_DMG_200=200, SKILL_DMG_250=250, SKILL_DMG_300=300, SKILL_DMG_400=400, SKILL_DMG_500=500, SKILL_DMG_700=700, SKILL_DMG_1K=1000,
	SKILL_DMG_2K=2000, SKILL_DMG_3K=3000, SKILL_DMG_5K=5000, SKILL_DMG_10K=10000, SKILL_DMG_999K=999000
}
enum ENUM_CUSTOM_RANK {ATTACKER, AGILITY, DEFENDER, UNIVERSAL}
enum ENUM_CUSTOM_RANK_LEVEL {ATTACKER_LV1, ATTACKER_LV2, ATTACKER_LV3, AGILITY_LV1, AGILITY_LV2, AGILITY_LV3, DEFENDER_LV1,
	DEFENDER_LV2, DEFENDER_LV3, UNIVERSAL_LV1, UNIVERSAL_LV2, UNIVERSAL_LV3}
enum ENUM_CHAR_GENDER{MALE, FEMALE, UNKNOWN}
enum ENUM_CHAR_RACE{HUMAN, ANIMAL, ELF, CYBORG, GOD, AI, ABBYS, UNKNOWN, SPIRIT, DRAGON}

# Helper functions
func dict_skill_target(_skill_target: ENUM_SKILL_TARGET):
	var skill_target = ""
	match _skill_target:
		ENUM_SKILL_TARGET.SINGLE: skill_target = "single"
		ENUM_SKILL_TARGET.AOE: skill_target = "aoe"
		ENUM_SKILL_TARGET.SINGLE_SPELL: skill_target = "single_spell"
		ENUM_SKILL_TARGET.AOE_SPELL: skill_target = "aoe_spell"
		ENUM_SKILL_TARGET.SINGLE_HEAL: skill_target = "single_heal"
		ENUM_SKILL_TARGET.AOE_HEAL: skill_target = "aoe_heal"
	return skill_target

func set_hero_icon(txt): 
	return str("res://img/Hero/icon/"+txt+".png")

func set_char_gender(gender: ENUM_CHAR_GENDER):
	var main_temp
	match gender:
		ENUM_CHAR_GENDER.MALE: main_temp = "Male"
		ENUM_CHAR_GENDER.FEMALE: main_temp = "Female"
		ENUM_CHAR_GENDER.UNKNOWN: main_temp = "UNKNOWN"
	return str(main_temp)

func set_char_race(race: ENUM_CHAR_RACE):
	var main_temp
	match race:
		ENUM_CHAR_RACE.HUMAN: main_temp = "Human"
		ENUM_CHAR_RACE.ANIMAL: main_temp = "Animal"
		ENUM_CHAR_RACE.ELF: main_temp = "Elf"
		ENUM_CHAR_RACE.CYBORG: main_temp = "Cyborg"
		ENUM_CHAR_RACE.GOD: main_temp = "God"
		ENUM_CHAR_RACE.AI: main_temp = "Artificial Intelligence"
		ENUM_CHAR_RACE.ABBYS: main_temp = "Abyss Creature"
		ENUM_CHAR_RACE.UNKNOWN: main_temp = "UNKNOWN"
		ENUM_CHAR_RACE.SPIRIT: main_temp = "Spirit"
		ENUM_CHAR_RACE.DRAGON: main_temp = "Dragon"
	return main_temp

# Card creation helper function
func create_card(
	id: String,
	name: String,
	img_name: String,
	elem: ELEM,
	job: JOB,
	rank: RANK,
	# Basic skill (skill_0)
	skill_0_target: ENUM_SKILL_TARGET,
	skill_code: ENUM_SKILL_CODE,
	skill_0_dmg: ENUM_SKILL_DAMAGE,
	skill_lv: ENUM_DESC_LEVEL,
	pct_req: ENUM_MAIN_CHANCES,
	skill_0_hit: int = 1,
	# Skill 1
	skill_1_target: ENUM_SKILL_TARGET = ENUM_SKILL_TARGET.SINGLE,
	skill_code_1: ENUM_SKILL_CODE = ENUM_SKILL_CODE.NONE,
	skill_1_dmg: ENUM_SKILL_DAMAGE = ENUM_SKILL_DAMAGE.SKILL_DMG_100,
	skill_1_lv: ENUM_DESC_LEVEL = ENUM_DESC_LEVEL.LV1,
	pct_req_1: ENUM_MAIN_CHANCES = ENUM_MAIN_CHANCES.C100,
	skill_1_cd: int = 1,
	skill_1_hit: int = 1,
	# Skill 2
	skill_2_target: ENUM_SKILL_TARGET = ENUM_SKILL_TARGET.SINGLE,
	skill_code_2: ENUM_SKILL_CODE = ENUM_SKILL_CODE.NONE,
	skill_2_dmg: ENUM_SKILL_DAMAGE = ENUM_SKILL_DAMAGE.SKILL_DMG_100,
	skill_2_lv: ENUM_DESC_LEVEL = ENUM_DESC_LEVEL.LV1,
	pct_req_2: ENUM_MAIN_CHANCES = ENUM_MAIN_CHANCES.C100,
	skill_2_cd: int = 2,
	skill_2_hit: int = 1,
	# Ultimate skill
	skill_ulti_target: ENUM_SKILL_TARGET = ENUM_SKILL_TARGET.SINGLE,
	skill_code_ulti: ENUM_SKILL_CODE = ENUM_SKILL_CODE.NONE,
	skill_ulti_dmg: ENUM_SKILL_DAMAGE = ENUM_SKILL_DAMAGE.SKILL_DMG_500,
	skill_ulti_lv: ENUM_DESC_LEVEL = ENUM_DESC_LEVEL.LV1,
	pct_req_ulti: ENUM_MAIN_CHANCES = ENUM_MAIN_CHANCES.C100,
	skill_ulti_cd: int = 3,
	skill_3_hit: int = 1,
	# Character info
	char_gender: ENUM_CHAR_GENDER = ENUM_CHAR_GENDER.UNKNOWN,
	char_race: ENUM_CHAR_RACE = ENUM_CHAR_RACE.UNKNOWN,
	char_age: String = "Unknown",
	char_height: String = "Unknown",
	char_weight: String = "Unknown",
	# Custom rank
	c_rank_stat: ENUM_CUSTOM_RANK = ENUM_CUSTOM_RANK.UNIVERSAL,
	c_rank_value: ENUM_CUSTOM_RANK_LEVEL = ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV1,
	# Story (optional)
	char_story: String = "",
	char_story_id: String = ""
) -> Dictionary:
	
	var card = {
		# BASIC ATTRIBUTE
		"img": "res://img/Hero/" + img_name + ".png",
		"icon": set_hero_icon(img_name),
		"elem": elem,
		"job": job,
		"rank": rank,
		"name": name,
		
		# STORY
		"char_story": char_story,
		"char_story_id": char_story_id,
		"char_gender": set_char_gender(char_gender),
		"char_race": set_char_race(char_race),
		"char_age": char_age,
		"char_height": char_height,
		"char_weight": char_weight,
		
		# SKILL BASIC
		"skill_0_target": dict_skill_target(skill_0_target),
		"skill_code": skill_code,
		"skill_0_dmg": skill_0_dmg,
		"skill_lv": skill_lv,
		"pct_req": pct_req,
		"skill_0_hit": skill_0_hit,
		
		# SKILL 1
		"skill_1_target": dict_skill_target(skill_1_target),
		"skill_code_1": skill_code_1,
		"skill_1_dmg": skill_1_dmg,
		"skill_1_lv": skill_1_lv,
		"pct_req_1": pct_req_1,
		"skill_1_cd": skill_1_cd,
		"skill_1_hit": skill_1_hit,
		
		# SKILL 2
		"skill_2_target": dict_skill_target(skill_2_target),
		"skill_code_2": skill_code_2,
		"skill_2_dmg": skill_2_dmg,
		"skill_2_lv": skill_2_lv,
		"pct_req_2": pct_req_2,
		"skill_2_cd": skill_2_cd,
		"skill_2_hit": skill_2_hit,
		
		# SKILL ULTI
		"skill_ulti_target": dict_skill_target(skill_ulti_target),
		"skill_code_ulti": skill_code_ulti,
		"skill_ulti_dmg": skill_ulti_dmg,
		"skill_ulti_lv": skill_ulti_lv,
		"pct_req_ulti": pct_req_ulti,
		"skill_ulti_cd": skill_ulti_cd,
		"skill_3_hit": skill_3_hit,
		
		# SPECIAL
		"c_rank_stat": c_rank_stat,
		"c_rank_value": c_rank_value
	}
	
	return card

# Override function untuk child classes
func get_all_heroes() -> Dictionary:
	return {}
