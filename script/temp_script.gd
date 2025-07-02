#extends RefCounted
#class_name Card_data_s1

enum ELEM{LIGHT, NATURE, WATER, DARK, FIRE}
enum JOB{WARRIOR, ARCHER, DEFENSE, ASSASIN, SUPPORT, MECH, BEAST, MAGE, HEALER}
enum RANK{STAR_1, STAR_2, STAR_3, STAR_4, STAR_5, STAR_6}

enum ENUM_SKILL_TARGET{SINGLE, AOE, SINGLE_SPELL, AOE_SPELL, SINGLE_HEAL, AOE_HEAL}
enum ENUM_MAIN_CHANCES{
	C10=10, C20=20, C30=30, C40=40, C50=50, C60=60, C70=70, C80=80, C90=90, C100=100,
	# ATTACK
	PSV_ATK_5K=5000, PSV_ATK_10K=10000, PSV_ATK_20K=20000, PSV_ATK_40K=40000, PSV_ATK_80K=80000, PSV_ATK_160K=160000,
	PSV_ATK_320K=320000, PSV_ATK_640K=640000,
	# DEFENSE
	PSV_DEF_1K=1000, PSV_DEF_2K=2000, PSV_DEF_3K=3000, PSV_DEF_4K=4000, PSV_DEF_5K=5000,
	# HEALTH
	PSV_HP_20K=20000, PSV_HP_40K=40000, PSV_HP_80K=80000, PSV_HP_160K=160000, PSV_HP_320K=320000, PSV_HP_640K=640000, PSV_HP_1280K=1280000,
	# TURN SPEED
	PSV_SPDT_50=50, PSV_SPDT_100=100, PSV_SPDT_150=150, PSV_SPDT_200=200, PSV_SPDT_250=250, PSV_SPDT_300=300, PSV_SPDT_350=350, PSV_SPDT_400=400,
	PSV_SPDT_450=450, PSV_SPDT_500=500,
	# COST
	# EVA
	PSV_EVA_20=20, PSV_EVA_40=40, PSV_EVA_80=80, PSV_EVA_160=160,
	# CRIT RATE
	PSV_CRATE_10=10, PSV_CRATE_20=20, PSV_CRATE_30=30, PSV_CRATE_40=40, PSV_CRATE_50=50,
	# CRIT DMG
	PSV_CDMG_100=100, PSV_CDMG_200=200, PSV_CDMG_300=300, PSV_CDMG_400=400, PSV_CDMG_500=500,
	# CRIT DEFENSE
	PSV_CDEF_10=10, PSV_CDEF_20=20, SPV_CDEF_30=30, PSV_CDEF_40=40, PSV_CDEF_50=50, 
	# SPEED ATTACK
	PSV_SPDA_50=50, PSV_SPDA_100=100, PSV_SPDA_150=150, PSV_SPDA_200=200, PSV_SPDA_250=250
}
enum ENUM_DESC_LEVEL{LV1=1, LV2, LV3}

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

enum ENUM_DICT_DESC_0 {
	ATTACK_0, ATTACK_50, ATTACK_100, ATTACK_150, ATTACK_200, ATTACK_250, ATTACK_300, ATTACK_350, ATTACK_400, ATTACK_450, 
	ATTACK_500, ATTACK_550, ATTACK_600, ATTACK_650, ATTACK_700, ATTACK_750, ATTACK_800, ATTACK_850, ATTACK_900, ATTACK_950, 
	ATTACK_1000, ATTACK_1050, ATTACK_1100, ATTACK_1150, ATTACK_1200, ATTACK_1250, ATTACK_1300, ATTACK_1350, ATTACK_1400, ATTACK_1450, 
	ATTACK_1500, ATTACK_1550, ATTACK_1600, ATTACK_1650, ATTACK_1700, ATTACK_1750, ATTACK_1800, ATTACK_1850, ATTACK_1900, ATTACK_1950, 
	ATTACK_2000, ATTACK_2050, ATTACK_2100, ATTACK_2150, ATTACK_2200, ATTACK_2250, ATTACK_2300, ATTACK_2350, ATTACK_2400, ATTACK_2450, 
	ATTACK_2500, ATTACK_2550, ATTACK_2600, ATTACK_2650, ATTACK_2700, ATTACK_2750, ATTACK_2800, ATTACK_2850, ATTACK_2900, ATTACK_2950, 
	ATTACK_3000,
}
enum ENUM_ATCK_INDIC{SINGLE, AOE, SINGLE_SPELL, AOE_SPELL, SINGLE_HEAL, AOE_HEAL}
func set_desc_ap(_power, _ap):
	match _ap:
		ENUM_ATCK_INDIC.SINGLE: return "Attack one enemie with "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_power,"% AP. "))
		ENUM_ATCK_INDIC.AOE: return "Attack all enemies with "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_power,"% AP. "))
		ENUM_ATCK_INDIC.SINGLE_SPELL: return set_string_color(ENUM_SET_COLOR.BLUE, str("Restores a certain amount of defense to a single ally"))+", including yourself, with the amount restored depending on: "+set_string_color(ENUM_SET_COLOR.PURPLE, str("[30-40%] of the caster's current total defense. "))
		ENUM_ATCK_INDIC.AOE_SPELL: return set_string_color(ENUM_SET_COLOR.BLUE, str("Restores a certain amount of defense to all allies")) +", including yourself, with the amount restored depending on: "+set_string_color(ENUM_SET_COLOR.PURPLE, str("[20-30%] of the caster's current total defense. "))
		ENUM_ATCK_INDIC.SINGLE_HEAL: return set_string_color(ENUM_SET_COLOR.BLUE, str("Restores a certain amount of health to a single ally"))+", including yourself, with the amount restored depending on: "+set_string_color(ENUM_SET_COLOR.PURPLE,str("[30-40%] of the caster's current total health "))
		ENUM_ATCK_INDIC.AOE_HEAL: return set_string_color(ENUM_SET_COLOR.BLUE, str("Restores a certain amount of health to all allies ")) + ", including yourself, with the amount restored depending on: "+ set_string_color(ENUM_SET_COLOR.PURPLE, str("[20-30%] of the caster's current total health. "))

enum ENUM_SKILL_DAMAGE{
	SKILL_DMG_0=0, SKILL_DMG_10=10, SKILL_DMG_30=30, SKILL_DMG_50=50, SKILL_DMG_80=80, SKILL_DMG_100=100, SKILL_DMG_150=150,
	SKILL_DMG_200=200, SKILL_DMG_250=250, SKILL_DMG_300=300, SKILL_DMG_400=400, SKILL_DMG_500=500, SKILL_DMG_700=700, SKILL_DMG_1K=1000,
	SKILL_DMG_2K=2000, SKILL_DMG_3K=3000, SKILL_DMG_5K=5000, SKILL_DMG_10K=10000, SKILL_DMG_999K=999000
}

enum ENUM_CUSTOM_RANK {ATTACKER, AGILITY, DEFENDER, UNIVERSAL}
enum ENUM_CUSTOM_RANK_LEVEL {ATTACKER_LV1, ATTACKER_LV2, ATTACKER_LV3, AGILITY_LV1, AGILITY_LV2, AGILITY_LV3, DEFENDER_LV1,
	DEFENDER_LV2, DEFENDER_LV3, UNIVERSAL_LV1, UNIVERSAL_LV2, UNIVERSAL_LV3}
enum ENUM_SET_COLOR{RED, BLUE, PURPLE, GREY, GOLD, GREEN, HEADER}

func set_string_color(_code:ENUM_SET_COLOR, _txt_:String):
	match _code:
		ENUM_SET_COLOR.RED: return str("[color=#E74C3C]"+_txt_+"[/color]")
		ENUM_SET_COLOR.BLUE: return str("[color=#3498DB]"+_txt_+"[/color]")
		ENUM_SET_COLOR.PURPLE: return str("[color=#9B59B6]"+_txt_+"[/color]")
		ENUM_SET_COLOR.GREY: return str("[color=#767676]"+_txt_+"[/color]")
		ENUM_SET_COLOR.GOLD: return str("[color=#F1C40F]"+_txt_+"[/color]")
		ENUM_SET_COLOR.GREEN: return str("[color=#81C784]"+_txt_+"[/color]")
		ENUM_SET_COLOR.HEADER: return str("\n[color=#C9A227]"+_txt_+"[/color]\n")

## 1 SKILL CODE
enum ENUM_SKILL_CODE{
	COUNTER=0, EVA, DEFF_BREAK, SKILL_LOCK, WEAKENING, BURN, POISON, HEALTH_UP, VAMP, ECHO_SHIELD, CRIT_DMG, CRIT_RATE,
	TURN_SPEED, DEFF_UP, SPEED_ATK, ATTACK_UP, COOLDOWN, REVIVE, RAGE, GRIM, NONE, SUPP_COUNTER, SUPP_EVA, SUPP_HEAL, SUPP_VAMP,
	SUPP_ECHO, SUPP_CDMG, SUPP_CRATE, SUPP_TURN, SUPP_DEFF, SUPP_SPD, SUPP_ATK, PSV_ATK, PSV_DEFF, PSV_HP, PSV_SPDT, PSV_CST,
	PSV_EVA, PSV_CRATE, PSV_CDMG, PSV_CDEF, PSV_PSDA, RM_DEBUFF, RM_BLUE_BUFF, RM_GREEN_BUFF, RM_GOLD_BUFF, CD_INC, CD_DEC,
	RAND_BUFF, INS_HEAL, ONESHOT_CDMG, ONESHOT_CRATE, ONESHOT_TSPD, ONESHOT_DEF, ONESHOT_ASPD, ONESHOT_ATTACKUP, ONESHOT_COUNTER,
	ONESHOT_EVA, ONESHOT_GRIM, MULTI_CRATE_CDMG, MULTI_ATK_DEF, MULTI_SPDA_SPDT, MULTI_COOLDOWN, LAST_CURSED=70, INFI_HEAL=72,
	REF_BURN=73, REF_POISON=74, REF_ATTACK=75, MORE_TURN=76, REFCD_DEC=78, STUN=79, AMIMIR=80
}
## 2 DESC SET ADAW
func set_desc_buff(_buff_code, _chances, _level):
	var main_chances = _chances
	match _buff_code:
		ENUM_SKILL_CODE.COUNTER: return set_string_color(ENUM_SET_COLOR.HEADER, str("[COUNTER ATACK]"))+"Grants " + set_string_color(ENUM_SET_COLOR.BLUE, "Counter Attack ") + "buff " + set_string_color(ENUM_SET_COLOR.PURPLE, "level %d" % _level) + " with a " + set_string_color(ENUM_SET_COLOR.PURPLE, "%d%%" % main_chances) + " chance.\n" + set_string_color(ENUM_SET_COLOR.GREY, "Counter Attack: After the enemy attacks, a counter-attack is dealt for a set amount")
		ENUM_SKILL_CODE.EVA: return set_string_color(ENUM_SET_COLOR.HEADER, str("[EVATION]"))+"Grants "+ set_string_color(ENUM_SET_COLOR.BLUE, "Evation") +" buff" +set_string_color(ENUM_SET_COLOR.PURPLE, " level %d" %_level)+ " with a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%%" %main_chances)+ " chance.\n"+ set_string_color(ENUM_SET_COLOR.GREY, "Evation: When attacked, there's a chance to evade the attack")
		ENUM_SKILL_CODE.DEFF_BREAK: return set_string_color(ENUM_SET_COLOR.HEADER, str("[DEFENSE BREAKER]"))+"Grants " + set_string_color(ENUM_SET_COLOR.RED, "Defense Breaker") + " debuff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d" %_level)+ " to enemy with a "+set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances" %main_chances)
		ENUM_SKILL_CODE.SKILL_LOCK: return set_string_color(ENUM_SET_COLOR.HEADER, str("[SKILL LOCK]"))+"Grants red debuff "+set_string_color(ENUM_SET_COLOR.RED, str("Lock Skill "))+"with "+set_string_color(ENUM_SET_COLOR.PURPLE, str("chances: ",_chances,"%\n"))+set_string_color(ENUM_SET_COLOR.GREY, str("[Lock Skill]: Enemy who have red debuff Lock Skill cannot using all skill except basic skill (skill 0). Red debuff Lock Skill have no limit count"))
		ENUM_SKILL_CODE.WEAKENING: return set_string_color(ENUM_SET_COLOR.HEADER, str("[WEAKENING]"))+"Grants " +set_string_color(ENUM_SET_COLOR.RED, "Weakening")+ " debuff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " to enemy with a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances")%main_chances+ set_string_color(ENUM_SET_COLOR.GREY, "\nWeakening: Reduces attack points, turn speed, attack speed, and evasion")
		ENUM_SKILL_CODE.BURN: return set_string_color(ENUM_SET_COLOR.HEADER, str("[BURN]"))+"After attacking, there's a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+ " to inflict the " +set_string_color(ENUM_SET_COLOR.RED, "Burn")+ " debuff to enemy."+set_string_color(ENUM_SET_COLOR.PURPLE, "(5-15 stacks)")+set_string_color(ENUM_SET_COLOR.GREY, "\nBurn: After attacking or attacked burn will be trigger")
		ENUM_SKILL_CODE.POISON: return set_string_color(ENUM_SET_COLOR.HEADER, str("[POISON]"))+"After attacking, there's a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+ " to inflict the " +set_string_color(ENUM_SET_COLOR.RED, "Poison")+ " debuff to enemy"+ set_string_color(ENUM_SET_COLOR.GREY, "\nPoison: After attacking or attacked poison will be trigger")
		ENUM_SKILL_CODE.HEALTH_UP: return set_string_color(ENUM_SET_COLOR.HEADER, str("[HEAL]"))+"After attacking, there's a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+ " to Gift " +set_string_color(ENUM_SET_COLOR.BLUE, "Heal")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ set_string_color(ENUM_SET_COLOR.GREY, "\nHeal: Restores a certain amount of health")
		ENUM_SKILL_CODE.VAMP: return set_string_color(ENUM_SET_COLOR.HEADER, str("[VAMPIRE]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Vampire")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a "+set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chance"%main_chances)+ set_string_color(ENUM_SET_COLOR.GREY, "\nVampire: Restores a certain amount of health, based on the damage dealt to the enemy")
		ENUM_SKILL_CODE.ECHO_SHIELD: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ECHO SHIELD]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Echo Shield")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+ set_string_color(ENUM_SET_COLOR.GREY, "\nEcho Shield: Restores a certain amount of health and defense after attacked")
		ENUM_SKILL_CODE.CRIT_DMG: return set_string_color(ENUM_SET_COLOR.HEADER, str("[CRITICAL DAMAGES]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Critical Damage")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a "+set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+set_string_color(ENUM_SET_COLOR.GREY, "\nCritical Damage: Significantly boosts attack when a critical hit is triggered")
		ENUM_SKILL_CODE.CRIT_RATE: return set_string_color(ENUM_SET_COLOR.HEADER, str("[CRITICAL RATE]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Critical Rate")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a "+set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+ set_string_color(ENUM_SET_COLOR.GREY, "\nCritical Hit: Attack damage multiplies when a critical hit is triggered, based on the critical damage level")
		ENUM_SKILL_CODE.TURN_SPEED: return set_string_color(ENUM_SET_COLOR.HEADER, str("[TURN SPEED]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Turn Speed")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a " + set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances) + set_string_color(ENUM_SET_COLOR.GREY, "\nTurn Speed: The higher the turn speed, the faster your turn begins")
		ENUM_SKILL_CODE.DEFF_UP: return set_string_color(ENUM_SET_COLOR.HEADER, str("[DEFENSE UP]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Defense Up")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a "+ set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+set_string_color(ENUM_SET_COLOR.GREY, "\nDefense Up: Temporarily increases defense points while this buff is active")
		ENUM_SKILL_CODE.SPEED_ATK: return set_string_color(ENUM_SET_COLOR.HEADER, str("[SPEED ATTACK]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Speed Attack")+ " buff " +set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a " +set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+ set_string_color(ENUM_SET_COLOR.GREY, "\nSpeed Attack: Increasing attack speed boosts the chance of a successful hit")
		ENUM_SKILL_CODE.ATTACK_UP: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ATTACK UP]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Attack Up")+ " buff " +set_string_color(ENUM_SET_COLOR.BLUE, "level %d"%_level)+ " with a " + set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances) + set_string_color(ENUM_SET_COLOR.GREY, "\nAttack Up: Temporarily increases base attack points until this buff expires")
		ENUM_SKILL_CODE.COOLDOWN: return ""
		ENUM_SKILL_CODE.REVIVE: return set_string_color(ENUM_SET_COLOR.HEADER, str("[REVIVE]"))+"After eliminated(HP=0) there is "+set_string_color(ENUM_SET_COLOR.PURPLE, str("chances: ",_chances))+" to activated special buff: "+set_string_color(ENUM_SET_COLOR.BLUE, "Rebirth\n")+set_string_color(ENUM_SET_COLOR.GREY, str("[Rebirth]: After eliminated waiting for 10 turn to rebith with restore health point by 20%"))
		ENUM_SKILL_CODE.RAGE: return set_string_color(ENUM_SET_COLOR.HEADER, str("[RAGE]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Cursed Rage ")+ set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " when current HP bellow "+ set_string_color(ENUM_SET_COLOR.PURPLE, "%d%%"%main_chances) + set_string_color(ENUM_SET_COLOR.GREY, "\nCursed Rage: Increases critical attack, base attack, attack speed, and evasion. Stacks each time receiving or dealing damage (maximum 10 stacks) ")
		ENUM_SKILL_CODE.GRIM: return set_string_color(ENUM_SET_COLOR.HEADER, str("[GRIM REAPER]"))+"Grants " +set_string_color(ENUM_SET_COLOR.BLUE, "Cursed Grim ")+set_string_color(ENUM_SET_COLOR.PURPLE, "level %d"%_level)+ " with a "+set_string_color(ENUM_SET_COLOR.PURPLE, "%d%% chances"%main_chances)+set_string_color(ENUM_SET_COLOR.GREY, "\nCursed Grim: Becomes invincible and will remain with 1 health for a short duration") 
		ENUM_SKILL_CODE.NONE: return ""
		ENUM_SKILL_CODE.SUPP_COUNTER: return ""
		ENUM_SKILL_CODE.SUPP_EVA: return ""
		ENUM_SKILL_CODE.SUPP_HEAL: return ""
		ENUM_SKILL_CODE.SUPP_VAMP: return ""
		ENUM_SKILL_CODE.SUPP_ECHO: return ""
		ENUM_SKILL_CODE.PSV_ATK: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE ATTACK UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Fixed Basic Attack: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("+",_chances)) + " Attack Power"
		ENUM_SKILL_CODE.PSV_DEFF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE DEFENSE UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Fixed Basic Defense: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("+",_chances)) + " Defense Power"
		ENUM_SKILL_CODE.PSV_HP: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE HP UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Fixed Basic Health Point: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("+",_chances)) + " Health power"
		ENUM_SKILL_CODE.PSV_SPDT: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE SPEED TURN UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Fixed Basic Turn Speed: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("+",_chances)) + " Turn Speed"
		ENUM_SKILL_CODE.PSV_CST: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE COST]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Card Cost: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("+",_chances)) + " Cost"
		ENUM_SKILL_CODE.PSV_EVA: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE EVATION UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Fixed Evation: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("+",_chances)) + " Evation"
		ENUM_SKILL_CODE.PSV_CRATE: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE CRITICAL RATE UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Critical Chances: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%"))
		ENUM_SKILL_CODE.CRIT_DMG: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSOVE CRITICCAL DAMAGE UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Critical Damages: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%"))
		ENUM_SKILL_CODE.PSV_CDEF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE CRITICAL DEFENSE UP]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Critical Defense: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%"))
		ENUM_SKILL_CODE.PSV_PSDA: return set_string_color(ENUM_SET_COLOR.HEADER, str("[PASSIVE SPEED ATTACK]"))+"At the start of battle, increase " + set_string_color(ENUM_SET_COLOR.BLUE, "Attack Speed: ") + set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances))
		ENUM_SKILL_CODE.RM_DEBUFF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[RED REBUFF REMOVER]"))+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances "))+"gains a blessed power that "+set_string_color(ENUM_SET_COLOR.BLUE, "removes all debuff")+" effects. "
		ENUM_SKILL_CODE.RM_BLUE_BUFF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[BLUE BUFF REMOVER]"))+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances "))+"triggering the wrath of the god then "+ set_string_color(ENUM_SET_COLOR.RED, "removes all blue buff ") +"from the target. " 
		ENUM_SKILL_CODE.RM_GREEN_BUFF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[HEAL REMOVER]"))+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances "))+"triggering the wrath of the god then "+ set_string_color(ENUM_SET_COLOR.RED, "removes all green buff ") +"from the target. " 
		ENUM_SKILL_CODE.RM_GOLD_BUFF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[GOLD BUFF REMOVER]"))+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances "))+"triggering the wrath of the god then "+ set_string_color(ENUM_SET_COLOR.RED, "removes all gold buff ") +"from the target. " 
		ENUM_SKILL_CODE.CD_INC: return set_string_color(ENUM_SET_COLOR.HEADER, str("[INCREASE COOLDOWN]"))+"Curses the target, "+set_string_color(ENUM_SET_COLOR.RED, "increasing skill ")+"cooldown by 1 turn. With a "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances.\n"))+ set_string_color(ENUM_SET_COLOR.GREY, "Cooldown reduction or increase applies only to skills 1 and 2; ultimate skill remains unaffected.")
		ENUM_SKILL_CODE.CD_DEC: return set_string_color(ENUM_SET_COLOR.HEADER, str("[DECREASE COOLDOWN]"))+"Blassed the target, "+set_string_color(ENUM_SET_COLOR.BLUE, "decreasing skill ")+"cooldown by 1 turn. With a "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances.\n"))+ set_string_color(ENUM_SET_COLOR.GREY, "Cooldown reduction or increase applies only to skills 1 and 2; ultimate skill remains unaffected.")
		ENUM_SKILL_CODE.RAND_BUFF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[RANDOM BUFF]"))+"Before turn begin grants one "+set_string_color(ENUM_SET_COLOR.BLUE, "random blue buff ")+"with a chances: "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% (level: )",_level,"\n")) + set_string_color(ENUM_SET_COLOR.GREY, "Random blue buff: Gains 1 random blue buff from the following list:'\n")+ set_string_color(ENUM_SET_COLOR.BLUE, "Critical Damage\nCritical Rare\nTurn Speed\nDefense Up\nAttack Speed\nAttack Up")
		ENUM_SKILL_CODE.INS_HEAL: return set_string_color(ENUM_SET_COLOR.HEADER, str("[INSTANT HEAL]"))+"Restores health points by "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%")) + " of the remaining health of caster to the target" + set_string_color(ENUM_SET_COLOR.GREY, str("\n[Instant heal] The total heal will not exceed the maximum health."))+set_string_color(ENUM_SET_COLOR.GREY, str("\n[Instant Heal] Can restore a portion of health to a card that has been eliminated."))
		ENUM_SKILL_CODE.ONESHOT_CDMG: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT CRITICAL DAMAGE]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains bluebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Critical Danage ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_CRATE: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT CRITICAL RATE]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains bluebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Critical Rate ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_TSPD: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT TURN SPEED]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains bluebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Turn Speed ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_DEF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT DEFENSE UP]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains bluebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Defense Up ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_ASPD: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT SPEED ATTACK UP]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains bluebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Speed Attack ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_ATTACKUP: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT ATTACK UP]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains bluebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Attack Up ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_COUNTER: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT COUNTER]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains goldbuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Counter Attack ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_EVA: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT EVATION]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains goldbuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Evation ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.ONESHOT_GRIM: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ONESHOT GRIM REPEAR]"))+"When health points are below "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")) +"[Oneshot] activated, gains purplebuff: "+set_string_color(ENUM_SET_COLOR.BLUE,"Grim Repear ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Oneshot]: skill can only activate once per match")
		ENUM_SKILL_CODE.MULTI_CRATE_CDMG: return set_string_color(ENUM_SET_COLOR.HEADER, str("[CRITICAL RATE & DAMAGE UP]"))+"Grants multiple bluebuffs, grand "+ set_string_color(ENUM_SET_COLOR.BLUE, "Critical Rate, Critical Damage ") +"with a percentage: "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%. Level: ",_level))
		ENUM_SKILL_CODE.MULTI_ATK_DEF: return set_string_color(ENUM_SET_COLOR.HEADER, str("[ATTACK UP & DEFENSE UP]"))+"Grants multiple bluebuffs, grand "+ set_string_color(ENUM_SET_COLOR.BLUE, "Attack Up, Defense Up ") +"with a percentage: "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%. Level: ",_level))
		ENUM_SKILL_CODE.MULTI_SPDA_SPDT: return set_string_color(ENUM_SET_COLOR.HEADER, str("[SPEED ATTACK UP & TURN SPEED]"))+"Grants multiple bluebuffs, grand "+ set_string_color(ENUM_SET_COLOR.BLUE, "Turn Speed, Speed Attack ") +"with a percentage: "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"%. Level: ",_level))
		ENUM_SKILL_CODE.MULTI_COOLDOWN: return set_string_color(ENUM_SET_COLOR.HEADER, str("[MULTIPLE COOLDOWN]"))+set_string_color(ENUM_SET_COLOR.PURPLE,str(_chances,"% chances to ")) + set_string_color(ENUM_SET_COLOR.BLUE, "Decreased Cooldown ")+"ally target and "+set_string_color(ENUM_SET_COLOR.RED, "Increased Cooldown ")+ "enemy target " +set_string_color(ENUM_SET_COLOR.PURPLE, str("Level: ",_level))+set_string_color(ENUM_SET_COLOR.GREY, "\n[Amount Increased and Decreased] \nLevel 1: 1 turn\nLevel 2: 2 turn\nLevel 3: 3 turn. ")
		ENUM_SKILL_CODE.LAST_CURSED: return set_string_color(ENUM_SET_COLOR.HEADER, str("[LAST CURSED]"))+"Upon defeat, the last positive cursed will activate for all survive ally, will grant " + set_string_color(ENUM_SET_COLOR.BLUE, "Random Bluebuff ") + set_string_color(ENUM_SET_COLOR.PURPLE, str("Level: ",_level,". With chances: ",_chances,"%"))
		ENUM_SKILL_CODE.INFI_HEAL: return set_string_color(ENUM_SET_COLOR.HEADER, str("[INFINITE HEAL]"))+"Each time an attack is received, "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances "))+set_string_color(ENUM_SET_COLOR.BLUE, "restores health ")+"by "+set_string_color(ENUM_SET_COLOR.BLUE, "2% ")+"of total health"
		ENUM_SKILL_CODE.REF_BURN: return set_string_color(ENUM_SET_COLOR.HEADER, str("[REFLECT BURN]"))+"Upon being attacked, "+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chance "))+"to apply debuff "+ set_string_color(ENUM_SET_COLOR.RED, "Burnt ") +"to the enemy "+ set_string_color(ENUM_SET_COLOR.PURPLE, "(1-5 stack)")
		ENUM_SKILL_CODE.REF_POISON: return set_string_color(ENUM_SET_COLOR.HEADER, str("[REFLECT POISON]"))+"Upon being attacked, "+ set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chance "))+"to apply debuff "+set_string_color(ENUM_SET_COLOR.RED, "Poison ")+"to the enemy "+set_string_color(ENUM_SET_COLOR.PURPLE, "(3-6 stack)")
		ENUM_SKILL_CODE.REF_ATTACK: return set_string_color(ENUM_SET_COLOR.HEADER, str("[REFLECT ATTACK]"))+"Upon being attacked, "+set_string_color(ENUM_SET_COLOR.PURPLE, str("100% "))+set_string_color(ENUM_SET_COLOR.BLUE, str("Counter Attack "))+"with total damages: "+set_string_color(ENUM_SET_COLOR.PURPLE, str("20% of basic attack"))
		ENUM_SKILL_CODE.MORE_TURN: return set_string_color(ENUM_SET_COLOR.HEADER, str("[MORE TURN]"))+"The end of the turn have "+set_string_color(ENUM_SET_COLOR.PURPLE, str("Changes: ",_chances,"% "))+"grand "+set_string_color(ENUM_SET_COLOR.BLUE, str("More Turn\n"))+set_string_color(ENUM_SET_COLOR.GREY, str("[More Turn]: Has a chance to restart the attacking turn. Maximum bonus strikes: 3"))
		ENUM_SKILL_CODE.REFCD_DEC: return str(set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% ")))+"Grants buff "+set_string_color(ENUM_SET_COLOR.BLUE, "Reflect Cooldown. ")+set_string_color(ENUM_SET_COLOR.PURPLE, str("Level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, "[Reflect Cooldown]: Reflect Cooldown can only be triggered when attacked. Upon triggering, it reduces some cooldown based on the owner's level. Max stack: 3")
		ENUM_SKILL_CODE.STUN: return set_string_color(ENUM_SET_COLOR.HEADER, str("[STUN]"))+"Applies a debuff "+set_string_color(ENUM_SET_COLOR.RED, str("Stun "))+"to the enemy with "+set_string_color(ENUM_SET_COLOR.PURPLE, str("chances: ",_chances,"% with level: ",_level,"\n"))+set_string_color(ENUM_SET_COLOR.GREY, str("[Stun]: After successfully inflicting a stun debuff, the enemy cannot claim their turn. The number of stun stacks depends on the level owned:\nLevel 1: 5 stacks\nLevel 2: 10 Stacks\nLevel 3: 15 Stacks"))
		ENUM_SKILL_CODE.AMIMIR: return set_string_color(ENUM_SET_COLOR.HEADER, str("[A MIMIR]"))+set_string_color(ENUM_SET_COLOR.PURPLE, str(_chances,"% chances "))+"inflict "+set_string_color(ENUM_SET_COLOR.RED, str("a mimir(sleep) "))+"debuff to the enemy. After successfully, enemy can't claim their turn forever except being attacked by enemy"

# This func for set full desc
func fullset_desc(get_codeSkill, get_chances, get_level, get_atkPower, get_atkIndic):
	var desc_0 = set_desc_ap(get_atkPower, get_atkIndic)
	var desc_1 = set_desc_buff(get_codeSkill, get_chances, get_level)
	var main_desc = str(desc_0,desc_1)
	return main_desc
func set_hero_icon(txt):return str("res://img/Hero/icon/"+txt+".png")
enum ENUM_CHAR_GENDER{MALE, FEMALE, UNKNOWN}
enum ENUM_CHAR_RACE{HUMAN, ANIMAL, ELF, CYBORG, GOD, AI, ABBYS, UNKNOWN, SPIRIT, DRAGON}
func set_char_gender(gender:ENUM_CHAR_GENDER):
	var main_temp
	match gender:
		ENUM_CHAR_GENDER.MALE: main_temp = "Male"
		ENUM_CHAR_GENDER.FEMALE: main_temp = "Female"
		ENUM_CHAR_GENDER.UNKNOWN: main_temp = "UNKNOWN"
	return str(main_temp)
func set_char_race(race:ENUM_CHAR_RACE):
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
var new_story_character = Data_story_character.new()
var new_story_character_id = Data_story_character_id.new()
var dict_all_card_s1 = {
	"s1_000":{
		# BASIC ATTRIBUTE
		"img": "res://img/Hero/N_WAR_1_Dimas.png",
		"icon":set_hero_icon("N_WAR_1_Dimas"),
		"elem": ELEM.NATURE, "job": JOB.WARRIOR, "rank": RANK.STAR_1,
		"name": "Dimas",
		# ----- STORY -----
		"char_story":new_story_character.get_story_character("s1_000"),
		"char_story_id":new_story_character_id.get_story_character("s1_000"),
		"char_gender":set_char_gender(ENUM_CHAR_GENDER.MALE),
		"char_race":set_char_race(ENUM_CHAR_RACE.HUMAN),
		"char_age":"18",
		"char_height":"174",
		"char_weight":"72",
		# ----- SKILL BASIC -----
		"skill_0_target": dict_skill_target(ENUM_SKILL_TARGET.SINGLE), # SKILL TARGET # SKILL GUIDE 0 HERE
		"skill_code": ENUM_SKILL_CODE.PSV_ATK, # CODE SKILL
		"skill_0_dmg": ENUM_SKILL_DAMAGE.SKILL_DMG_200,
		"skill_lv": ENUM_DESC_LEVEL.LV2,
		"pct_req": ENUM_MAIN_CHANCES.PSV_ATK_5K,
		"skill_0_hit" : 1,
		# ----- SKILL 1 -----
		"skill_1_target":dict_skill_target(ENUM_SKILL_TARGET.SINGLE), # SKILL TARGET # SKILL GUIDE 1 HERE
		"skill_code_1": ENUM_SKILL_CODE.NONE, # CODE SKILL
		"skill_1_dmg": ENUM_SKILL_DAMAGE.SKILL_DMG_400,
		"skill_1_lv": ENUM_DESC_LEVEL.LV2,
		"pct_req_1": ENUM_MAIN_CHANCES.C80,
		"skill_1_cd": 2,"skill_1_hit" : 1,
		# ----- SKILL 2 -----
		"skill_2_target":dict_skill_target(ENUM_SKILL_TARGET.SINGLE_SPELL), # SKILL TARGET # SKILL GUIDE 2 HERE
		"skill_code_2": ENUM_SKILL_CODE.DEFF_UP, # CODE SKILL
		"skill_2_dmg": ENUM_SKILL_DAMAGE.SKILL_DMG_100,
		"skill_2_lv": ENUM_DESC_LEVEL.LV2,
		"pct_req_2": ENUM_MAIN_CHANCES.C100,
		"skill_2_cd": 2, "skill_2_hit" : 1,
		# ----- SKILL ULTI -----
		"skill_ulti_target" :dict_skill_target(ENUM_SKILL_TARGET.SINGLE), # SKILL TARGET # SKILL GUIDE 3 HERE
		"skill_code_ulti": ENUM_SKILL_CODE.NONE, # CODE SKILL
		"skill_ulti_dmg": ENUM_SKILL_DAMAGE.SKILL_DMG_1K,
		"skill_ulti_lv": ENUM_DESC_LEVEL.LV2,
		"pct_req_ulti": ENUM_MAIN_CHANCES.C100,
		"skill_ulti_cd": 3, "skill_3_hit" : 1,
		# ----- SPECIAL -----
		"c_rank_stat": ENUM_CUSTOM_RANK.DEFENDER,
		"c_rank_value": ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2
	},
}
