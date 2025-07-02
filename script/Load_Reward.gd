class_name Load_reward
var get_img = Load_images.new()
var base_stat = Base_stat.new()

enum ENUM_REWARD{MONEY, EXP, TICKET, SPIN}
enum ENUM_GRADE {D,C,B,A,S,SS,SSS,UR}
enum ENUM_GRADE_TYPE {GRADE, COLOR}
enum ENUM_TIER {LEVEL_1, LEVEL_2, LEVEL_3, LEVEL_4, LEVEL_5}
enum ENUM_EQ_MAIN {ACC, ARMOR, GLOVES, HELM, SHOES, TROUSERS, WPN_MELEE, WPN_WIZ}
enum ENUM_EQ_ACC {BELT, RING, NECKLACE, EARRINGS, AMULETS}
enum ENUM_EQ_STAT_MAIN { ATK_FLAT, ATK_PCT, DEF_FLAT, DEF_PCT, HP_FLAT, HP_PCT, TURN_FLAT, TURN_PCT, CRIT_RATE, CRIT_DMG, SPD_FLAT, EVA_FLAT, CRIT_DEF }
enum ENUM_GEARSET {
	SET1_FANGCLAW,      # +25% Attack
	SET2_STONEWALL,     # +25% Defense
	SET3_HEARTROOT,     # +25% Health
	SET4_SWIFTWIND,     # +25% Turn Speed
	SET5_STORMLASH,     # +25% Speed Attack
	SET6_SHADOWSTEP,    # +25% Evasion
	SET7_PIERCER,       # +25% Defense Penetration
	SET8_IRONVEIL }      # +25% Crit Defense
enum ENUM_GEARSET_SC {
	SET1_TEMPLAR_VOW, SET2_CRIMSON_ABYSS, SET3_NIGHTSHADE, SET4_RAGEHOWL, SET5_DARK_OVERLOARD, SET6_CELESTIAL_EMPEROR, SET7_GAIA }

func get_uniq_id(add_loop:int) -> String:
	var datetime = Time.get_datetime_dict_from_system()
	var ms = Time.get_ticks_msec() % 1000  # ambil 3 digit milidetik

	var _day   = '%02d' % datetime.day
	var _month = '%02d' % datetime.month
	var _year  = '%02d' % (datetime.year % 100)
	var _hour  = '%02d' % datetime.hour
	var _min   = '%02d' % datetime.minute
	var _sec   = '%02d' % datetime.second
	var _msec  = '%03d' % ms  # milidetik

	return str(_day,_month , _year , _hour , _min , _sec , _msec , add_loop)
# contoh: 100, 20%-nya brp?
func get_pct(value, pct):
	return (value * pct) / 100
#contoh 10, brp persen dari 100?
func set_pct(value_ask, target_to_pct):
	if target_to_pct == 0:
		return 0
	return int((float(value_ask) / target_to_pct) * 100)
func string_grade_tier(type:ENUM_GRADE_TYPE ,tier:ENUM_GRADE): 
	match type:
		ENUM_GRADE_TYPE.GRADE:
			match tier:
				ENUM_GRADE.D: return "D"
				ENUM_GRADE.C: return "C"
				ENUM_GRADE.B: return "B"
				ENUM_GRADE.A: return "A"
				ENUM_GRADE.S: return "S"
				ENUM_GRADE.SS: return "SS"
				ENUM_GRADE.SSS: return "SSS"
				ENUM_GRADE.UR: return "UR"
		ENUM_GRADE_TYPE.COLOR:
			match tier:
				ENUM_GRADE.D: return "#a57638" # # COKLAT
				ENUM_GRADE.C: return "#3db854" # HIJAU
				ENUM_GRADE.B: return "#2c6cd7" # BIRU
				ENUM_GRADE.A: return "#ae28e0" # UNGU 
				ENUM_GRADE.S: return "#FF9100" # KUNING TUA
				ENUM_GRADE.SS: return "#FFF000" # GOLD
				ENUM_GRADE.SSS: return "#ff3d3d" # MERAH
				ENUM_GRADE.UR: return "#00f6ff" # CYAN 
var currency = {
	ENUM_REWARD.EXP:{
		"id":"c_00",
		"id_gb":"cr_exp",
		"icon":get_img.img_icon["exp"],
		"name":"Mana Stone",
		"grade":string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.A),
		"color":string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.A),
		"type":"Currency",
		"desc":"A mysterious stone (Mana Stone) that contains an immense amount of energy." },
	ENUM_REWARD.MONEY:{
		"id":"c_01",
		"id_gb":"gold",
		"icon": get_img.img_icon["money"],
		"name":"Gold Coin",
		"grade":string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.A),
		"color":string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.A),
		"type":"Currency",
		"desc":"Gold Coins are used to upgrade equipment to make them stronger and for various other purposes." },
	ENUM_REWARD.TICKET:{
		"id":"c_02",
		"id_gb":"super_ticket",
		"icon": get_img.img_icon["ticket"],
		"name":"Gold Ticket",
		"grade":string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.A),
		"color":string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.A),
		"type":"Currency",
		"desc":"Golden Tickets can be exchanged for Gold Coins, Mana Stones, and Spin Coins. Exchange them in the Shop - Vault." },
	ENUM_REWARD.SPIN:{
		"id":"c_03",
		"id_gb":"spin_coin",
		"icon": get_img.img_icon["spin"],
		"name":"Spin Coin",
		"grade":string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.A),
		"color":string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.A),
		"type":"Currency",
		"desc":"Spin Coins can only be used for spinning the wheel of fortune and can be accessed from the Shop - Spin menu." }, }
# ----------------------------- EQUIPMENT: START ------------------------------
# NOTE: ACC AKAN DIBANTAI
# ID_UNIQ = CODE GEAR SET
# DESC_UNIQ = GET SET BONUS STAT
func _eq_gearset_desc(get_set:ENUM_GEARSET) -> Dictionary:
	var _id = {0:"Fangclaw", 1:"Stonewall", 2:"Heartroot", 3:"Swiftwind", 4:"Stormlash", 5:"Shadowstep", 6:"Piercer", 7:"Ironveil"}
	var _desc = {
		0:"Boosts raw attack with feral power.\n3 SET (+25% Attack)",
		1:"Turns the wearer into an immovable wall.\n3 SET (+25% Defense)",
		2:"Enhances vitality with ancient life energy.\n3 SET (+25% Health)",
		3:"Increases turn speed with wind-like agility.\n3 SET (+25% Turn Speed)",
		4:"Strikes faster with storm-charged power.\n3 SET (+25% Speed Attack)",
		5:"Grants high evasion through shadow magic.\n3 SET (+25% Evasion)",
		6:"Pierces enemy defenses with ease.\n3 SET (+25% Defense Penetration)",
		7:"Reduces damage from critical hits.\n3 SET (+25% Crit Defense)"
	}
	var id_gearset = {
		0: "eq_gs_0",1: "eq_gs_1",2: "eq_gs_2",3: "eq_gs_3",4: "eq_gs_4",5: "eq_gs_5", 6:"eq_gs_6", 7:"eq_gs_7"
	}
	return {"id": _id[get_set], "desc": _desc[get_set], "gs": id_gearset[get_set] }
func _eq_gearset_sc_desc(get_set:ENUM_GEARSET_SC) -> Dictionary:
	var _id = {0:"Templar Vow",1:"Crimson Abyss",2:"Nightshade",3:"Ragehowl",4:"Dark Overlord",5:"Celestial Emperor", 6:"Gaia's Wrath"}
	var _desc = {
		0:"Sacred armor worn by holy knights bound by unbreakable oaths.\n3 SET (+35% Defense, +20% Crit Defense)\n6 SET (+50% Defense, +35% Crit Defense)",
		1:"Born of fire and blood, this set fuels carnage with every breath.\n3 SET (+25% Critical Rate, +35% Attack)\n6 SET (+35% Critical Rate, +50% Attack)",
		2:"Armor woven in shadows, perfect for those who vanish before they strike.\n3 SET (+35% Evasion, +20% Turn Speed)\n6 SET (+50% Evasion, +40% Turn Speed)",
		3:"Forged from wild fury and beast bones, made for berserkers.\n3 SET (+35% Health, +20% Speed Attack)\n6 SET (+50% Health, +40% Speed Attack)",
		4:"The crown of a tyrant who rules not by fear alone, but by fate itself.\n6 SET (+200% ATTACK & HEALTH)",
		5:"Blessed by the stars and born to rule all realms — above sky, time, and thought.\n6 SET (+200% ATTACK & HEALTH)",
		6:"Forged in nature's fury, this weapon set channels Gaia’s unstoppable power in every strike.\n 6 SET (+400% ATTACK & HEALTH)"}
	var id_gearset = {
		0: "eq_gssc_0",1: "eq_gssc_1",2: "eq_gssc_2",3: "eq_gssc_3",4: "eq_gssc_4",5: "eq_gssc_5", 6:"eq_gssc_6",
	}
	return {"id":_id[get_set], "desc":_desc[get_set], "gs":id_gearset[get_set]}
func _eq_type_general(type: ENUM_EQ_MAIN) -> String:
	match type:
		ENUM_EQ_MAIN.ARMOR: return "Equipment (Armor)"
		ENUM_EQ_MAIN.GLOVES: return "Equipment (Gloves)"
		ENUM_EQ_MAIN.HELM: return "Equipment (Helm)"
		ENUM_EQ_MAIN.SHOES: return "Equipment (Shoes)"
		ENUM_EQ_MAIN.TROUSERS: return "Equipment (Trousers)"
		ENUM_EQ_MAIN.WPN_MELEE: return "Equipment (Weapon Knight)"
		ENUM_EQ_MAIN.WPN_WIZ: return "Equipment (Weapon Wizard)"
		_: return "Unknown Equipment"
	# --------------EQ GENERAL NAME AND DESC:START ----------------------
func _eq_name(tier_code:int, _main:ENUM_EQ_MAIN) ->Dictionary:
	var _name = {
		1:{
			ENUM_EQ_MAIN.ARMOR:"Soldier's Armor",
			ENUM_EQ_MAIN.GLOVES:"Soldier's Gloves",
			ENUM_EQ_MAIN.HELM:"Soldier's Helm",
			ENUM_EQ_MAIN.SHOES:"Soldier's Shoes",
			ENUM_EQ_MAIN.TROUSERS:"Soldier's Trousers",
			ENUM_EQ_MAIN.WPN_MELEE:"Soldier's Sword",
			ENUM_EQ_MAIN.WPN_WIZ:"Soldier's Magic Staff", },
		2:{
			ENUM_EQ_MAIN.ARMOR:"Commander's Armor",
			ENUM_EQ_MAIN.GLOVES:"Commander's Gloves",
			ENUM_EQ_MAIN.HELM:"Commander's Helm",
			ENUM_EQ_MAIN.SHOES:"Commander's Shoes",
			ENUM_EQ_MAIN.TROUSERS:"Commander's Trousers",
			ENUM_EQ_MAIN.WPN_MELEE:"Commander's Sword",
			ENUM_EQ_MAIN.WPN_WIZ:"Commander's Magic Staff", },
	}
	var _desc = {
		0:"Standard Equpment worn by regular soldiers. Durable enough to withstand light attacks on the front lines.",
		1:"Standard Equpment worn by regular soldiers. Durable enough to withstand light attacks on the front lines.",
		2:"Equpment worn by unit leaders. Designed with extra protection and military details that signify authority."}
	return{
		"name":_name[tier_code][_main],
		"desc":_desc[tier_code] }
func _eq_name_sc(tier_code:ENUM_GEARSET_SC, _main:ENUM_EQ_MAIN) -> Dictionary:
	var eq_sc = {
		0:{ # TEMPLAR
			1:{
				"name":"Armor of Radiant Vow",
				"desc":"A shining breastplate worn by those who swore to protect the innocent. Its brilliance repels even the darkest evil and ignites hope in every battle."
			},2:{
				"name":"Gauntlets of Unbroken Faith",
				"desc":"Forged for the hands of those who never falter, these gauntlets amplify divine strength and grant clarity in the heart of chaos."
			},3:{
				"name":"Crown of the Redeemer",
				"desc":"This helmet once belonged to a knight who turned enemies into allies. It purifies intent and shields the mind from corruption."
			},4:{
				"name":" Boots of the Lightbearer",
				"desc":"Each step echoes divine judgment. Worn by crusaders who march not for war, but for salvation."
			},5:{
				"name":"Greaves of Sacred Duty",
				"desc":"Clad in these, the wearer walks with righteousness. They are stained with blood, but only from battles fought to defend peace."
			},6:{
				"name":"Oathbringer Blade",
				"desc":"A sword bound to its wielder by holy vows. It refuses to let its bearer retreat, no matter the odds."
			},7:{
				"name":"Codex of Celestial Light",
				"desc":"An ancient tome blessed by the heavens. Every spell cast from its pages calls forth the fury and mercy of divine realms."
			}
		},1:{ # CRIMSON
			1:{
				"name":"Hellforged Carapace",
				"desc":"Molded in the heart of infernos, this armor burns with hatred. It scars the air with every movement, radiating searing rage."
			},2:{
				"name":"Bloodfang Gauntlets",
				"desc":"Once soaked in the blood of a thousand foes, these gloves sharpen the wearer’s instinct to kill with savage precision."
			},3:{
				"name":"Horns of Eternal Carnage",
				"desc":"A helm adorned with demon horns. It feeds off the bloodlust of the wearer, turning pain into power."
			},4:{
				"name":"Infernal Tread",
				"desc":"With every step, the earth cracks beneath their wrath. Fire follows their trail like a beast on a leash."
			},5:{
				"name":"Emberhide Leggings",
				"desc":"Charred and blackened, these pants still pulse with demonic heat. Each fiber whispers of battles lost and victories drowned in flame."
			},6:{
				"name":"Crimson Slaughterblade",
				"desc":"Forged from cursed steel, this blade drinks blood and screams with the souls of those it slays."
			},7:{
				"name":"Staff of the Forbidden Flame",
				"desc":"A rod born from the first flame of hell. Its power scorches reality itself, burning both allies and foes without mercy."
			}
		},2:{ # SHADOW
			1:{
				"name":"Shroud of the Silent Edge",
				"desc":"A cloak-like armor that blends perfectly with the shadows. It muffles all sound and erases presence like wind on smoke."
			},2:{
				"name":"Phantomgrip Wraps",
				"desc":"Tight-fitting gloves woven from shadowthread. They allow the user to strike unseen and vanish before the echo."
			},3:{
				"name":"Veil of the Nightshade",
				"desc":"This hood shrouds the mind and face in obscurity. It grants vision in darkness and thoughts too fast to follow."
			},4:{
				"name":"Whisperstep Boots",
				"desc":"These boots leave no trace, not even a whisper. Enemies fall before they even know the assassin was there."
			},5:{
				"name":"Darkweaver Leggings",
				"desc":"Light as mist, strong as silence. These leggings bend the light around them, allowing the user to pass like a phantom."
			},6:{
				"name":"Dagger of the Vanishing Fang",
				"desc":"A wicked blade that blurs mid-strike. Its cuts feel like shadows tearing the soul."
			},7:{
				"name":"Shadowbind Tome",
				"desc":"A cursed grimoire containing forbidden illusions. Its pages manipulate light, fear, and space itself."
			}
		},3:{ # BARBARIAN
			1:{
				"name":"Hide of the Beast King",
				"desc":"Made from the flesh of the fiercest beasts, this armor roars with primal might. It offers no elegance—only brutal survival."
			},2:{
				"name":"Shackles of the Wildborn",
				"desc":"Old broken chains now serve as gauntlets. Each link represents a shattered rule, a path walked by fury alone."
			},3:{
				"name":"Skull of the Colossus",
				"desc":"The skull of a giant reforged as a helm. It turns heads into weapons and fear into armor."
			},4:{
				"name":"Tremorwalk Boots",
				"desc":"With each stomp, the ground trembles. These boots are made for warriors who don’t sneak—they announce their rage."
			},5:{
				"name":"Wrathhide Trousers",
				"desc":"Sewn from savage hides, they hold scars of countless wars. Blood dries on them, but the fury never fades."
			},6:{
				"name":"Earthsplitter Sword",
				"desc":"A weapon so heavy and wild, even mountains would tremble. Each swing threatens to crack the sky."
			},7:{
				"name":"Totem of Ancestral Fury",
				"desc":"An ancient relic pulsing with barbaric spirit energy. Its power is untamed, erupting in raw, chaotic blasts."
			}
		},4:{ # OVERLORD
			1:{
				"name":"Abysslord Plate",
				"desc":"A chestplate forged from voidsteel. It feeds on despair and turns pain into power. The deeper the wound, the stronger it shines."
			},2:{
				"name":"Grasp of Ruin",
				"desc":"These cursed gauntlets channel the touch of decay. Whatever they seize begins to wither — body, mind, or hope."
			},3:{
				"name":"Diadem of Eternal Dread",
				"desc":"Not a helmet, but a mark of dominion. This headgear bends the will of lesser creatures and invokes ancient fears."
			},4:{
				"name":"Voidmarch Sabatons",
				"desc":"Each step echoes across the abyss. They let the wearer phase through shadow, and silence even the bravest heart."
			},5:{
				"name":"Dreadwoven Greaves",
				"desc":"Stitched with threads of darkness itself. They offer no warmth — only the cold comfort of complete control."
			},6:{
				"name":"Tyrantfang Greatblade",
				"desc":"A massive blade cursed to crave dominion. It grows heavier with every soul it slays — not as a burden, but as a throne."
			},7:{
				"name":"Orb of Infinite Malice",
				"desc":"A dark core of collapsed hatred. It pulses with forbidden spells capable of erasing light itself."
			}
		},5:{ # CLESTIAL
			1:{
				"name":"Aegis of the Heavens",
				"desc":"This majestic armor radiates divine harmony. It bends fate to protect its wearer and shines with the grace of stars."
			},2:{
				"name":"Hands of Celestial Will",
				"desc":"Gloves worn by the one who commands the cosmos. They grant mastery over time, flow, and creation."
			},3:{
				"name":"Crown of the Infinite Sky",
				"desc":"A golden helm that opens the mind to the universe. It sees both the past and future with unfaltering clarity."
			},4:{
				"name":"Stride of the Firmament",
				"desc":"These shoes defy gravity itself. The wearer walks across the air, stars, and even dreams."
			},5:{
				"name":"Legguards of Ethereal Majesty",
				"desc":"Crafted from divine silk and sunlight. They resonate with celestial energy and repel mortal harm."
			},6:{
				"name":"Blade of Solar Judgment",
				"desc":"A sword of searing purity. Each swing brings the dawn, scorching evil and cleansing the battlefield."
			},7:{
				"name":"Scepter of the Worldscript",
				"desc":"The ultimate arcane tool. With a wave, this scepter can rewrite the very laws of reality — or end them."
			}
		},6:{
			1:{
				"name":"Heartbark Aegis",
				"desc":"This living armor beats in tune with the earth. Enchanted flora bloom across its surface, shielding the wearer with the resilience of nature's core."
			},2:{
				"name":"Thornroot Grips",
				"desc":"Woven from enchanted bark and thorned vines, these gloves channel the strength of ancient woods. Each strike becomes a message from the wilds."
			},3:{
				"name":"Crown of Bloomveil",
				"desc":"Crowned with petals and crystal leaves, this helm grants clarity of mind and the silent wisdom of the forest. It hums with an eternal connection to Gaia's will."
			},4:{
				"name":"Deepgrove Treads",
				"desc":"Forged in sacred springs, these boots leave no trace yet root the wearer with unwavering stability. Each step calls forth Gaia's unseen blessing."
			},5:{
				"name":"Sylvanstride Leggings",
				"desc":"Sylvanstride Leggings."
			},6:{
				"name":"Gaiafang Cleaver",
				"desc":"An axe forged from the heart of Gaia herself. Its edge sings with the wind, and every swing echoes the roar of the earth. Vines curl along its haft, pulsing with raw elemental fury."
			},7:{
				"name":"Verdant Whisperer",
				"desc":"A staff carved from an ancient tree that grew at the center of the world. Blue crystal buds glow softly, channeling primal magic through the roots of reality itself."
			},
		}
	}
	return {
		"name":eq_sc[tier_code][_main]["name"],
		"desc":eq_sc[tier_code][_main]["desc"] }
	# --------------EQ GENERAL NAME AND DESC:END ----------------------
func _eq_name_acc(code):
	var _acc_eqname = {
		1: 'Bronzeleaf Ring', 2: 'Roselight Band', 3: 'Bloodshade Pendant', 4: 'Magenta Core Ring', 5: 'Verdant Jade Necklace',
		6: 'Amethyst Veil Necklace', 7: 'Frostbite Ring', 8: 'Royal Amethyst Ring', 9: 'Regalia of Twilight Jade', 10: 'Celestine Loop Pendant',
		11: 'Azure Focus Ring', 12: 'Runebound Amethyst Ring', 13: 'Runebound Amethyst Ring – Gilded Edge', 14: 'Talisman of the Golden Pact', 15: 'Winged Amethyst Ring',
		16: 'Celestial Emberwing Ring', 17: 'Talisman of the Infernal Head', 18: 'Talisman of the Skullbound', 19: 'Demonhorn Skull Ring', 20: 'Eye of the Forbidden Seer',
		21: 'Demon\'s Infernal Ring', 22: 'Pendant of the Infernal Fiend', 23: 'Angel\'s Embrace Ring', 24: 'Talisman of the Heavenly Guardian', 25: 'Amethyst Jade Ring',
		26: 'Dragon\'s Head Ring', 27: 'Claw of the Dragon Earrings', 28: 'Dragon Scale Belt', 29: 'Dragon\'s Fang Necklace', 30: 'Ring of the Eternal Sigil', 31:"Lifebind Girdle", 32:"Ring of Verdant Pulse", 33:"Echoleaf Studs", 34:"Echoleaf Studs",
	}
	return _acc_eqname[code]
func _eq_gearset_acc(code) -> Dictionary:
	var gearset_desc = {
		1: "Relics of a lost era — pure power with no limits.",
		2: "Blood-forged and flame-bound, this set grants immense power at great cost.\n4 SET (+20% Critical Rate)",
		3: "Blessed by ancient light, this set bestows divine strength to the worthy.\n4 SET (+35% Critical Defense)",
		4: "Born from an eternal dragon, this set holds primal might that defies fate.\n4 SET (+500% Damage to Dragon Monster)",
		5: "Gifted by celestial warriors, this set grants unyielding strength and spirit.\n1 SET (+15% Critical Defense)",
		6: "Subtle relics infused with life essence, granting wisdom, clarity, and the pulse of the earth.\n4 SET (+1000% Damage in all Dungeon)"
	}

	var gearset_id = {
		1:"Artifacts of the Forgotten",
		2:"Covenant of the Infernal Lords",
		3:"Benediction of the Radiant Host",
		4:"Legacy of the Eternal Dragon",
		5:"Aegis of the Seraphic Vanguard",
		6:"Gaia's Whisper Set"
	}
	
	var id_gearset = {
		1: "acc_gs_1",2: "acc_gs_2",3: "acc_gs_3",4: "acc_gs_4",5: "acc_gs_5",6: "acc_gs_6",
	}
	return {"id":gearset_id[code], "desc":gearset_desc[code], "gs":id_gearset[code]}
func _eq_dict_gen(code: int, eq_main: ENUM_EQ_MAIN) -> Dictionary:
	if eq_main == ENUM_EQ_MAIN.ACC:
		var txt_acc = ""
		if code > 99: txt_acc = ""
		elif code >= 10: txt_acc = "0"
		else: txt_acc = "00"
		var _id = str("eq_acc_",txt_acc,code)
		
		var acc_desc
		var _acc_desc = {
			1:"Forged by the hands of master craftsmen, granting essential strength to young warriors.",
			2:"Relics of ancient heroes, holding immense power that only the chosen ones can wield.",
			3:"Born from the very essence of the world, these accessories carry unspeakable power beyond human limits.",
			4:"An ancient gear set blessed by Gaia, wrapped in blue energy and living flora. Said to be the strongest relics of the natural world, each piece resonates with the power of life itself."}
		if code in range(1, 14):acc_desc = _acc_desc[1]
		elif code in range(14, 26):acc_desc = _acc_desc[2]
		elif code in range(26, 31):acc_desc = _acc_desc[3]
		elif code in range(31, 35):acc_desc = _acc_desc[4]
		
		var _acc_ring = [1, 2, 4, 7, 8, 11, 12, 13, 15, 16, 19, 20, 23, 25, 26, 30, 32]
		var _acc_earring = [5, 27, 33]
		var _acc_amuelet = [3, 6, 9, 10, 14, 17, 18, 21, 22, 24, 29, 34]
		var _acc_belt = [28, 31]
		
		var _id_gb =""
		if code in _acc_ring: _id_gb = "eq_acc_ring"
		elif code in _acc_earring: _id_gb = "eq_acc_earring"
		elif code in _acc_amuelet: _id_gb = "eq_acc_amuelt"
		elif code in _acc_belt: _id_gb = "eq_acc_belt"
		else: _id_gb="BRO ERROR WOKWOWKOWKOWKWK"
		
		var uniq_id =""
		var uniq_desc =""
		var id_gearset =""
		if code in range(1, 14):
			uniq_id = _eq_gearset_acc(1)["id"]
			uniq_desc = _eq_gearset_acc(1)["desc"]
			uniq_desc = _eq_gearset_acc(1)["gs"]
			id_gearset = _eq_gearset_acc(1)["gs"]
		elif code in range(17, 23):
			uniq_id = _eq_gearset_acc(2)["id"]
			uniq_desc = _eq_gearset_acc(2)["desc"]
			id_gearset = _eq_gearset_acc(2)["gs"]
		elif code in range(14, 17) or code in range(23, 26):
			uniq_id = _eq_gearset_acc(3)["id"]
			uniq_desc = _eq_gearset_acc(3)["desc"]
			id_gearset = _eq_gearset_acc(3)["gs"]
		elif code in range(26, 30):
			uniq_id = _eq_gearset_acc(4)["id"]
			uniq_desc = _eq_gearset_acc(4)["desc"]
			id_gearset = _eq_gearset_acc(4)["gs"]
		elif code == 30:
			uniq_id = _eq_gearset_acc(5)["id"]
			uniq_desc = _eq_gearset_acc(5)["desc"]
			id_gearset = _eq_gearset_acc(5)["gs"]
		elif code in range(31, 35):
			uniq_id = _eq_gearset_acc(6)["id"]
			uniq_desc = _eq_gearset_acc(6)["desc"]
			id_gearset = _eq_gearset_acc(6)["gs"]
		
		return {
			"name": _eq_name_acc(code),
			"desc": acc_desc,
			"type": "Equipment (Accessories)",
			"id": _id,
			"id_gb": _id_gb,
			"id_uniq": uniq_id,
			"desc_uniq": uniq_desc,
			"gs":id_gearset }
	# SET ID
	var name_id = {
		0: "eq_acc_", 1: "eq_armor_", 2: "eq_gloves_", 3: "eq_helm_",
		4: "eq_shoes_", 5: "eq_trouser_", 6: "eq_wpn_melee_", 7: "eq_wpn_wiz_"}
	var name_id_gb = {
		0: "eq_acc", 1: "eq_armor", 2: "eq_gloves", 3: "eq_helm",
		4: "eq_shoes", 5: "eq_trouser", 6: "eq_wpn_melee", 7: "eq_wpn_wiz" }
	var txt_temp = ""
	
	if code > 99: txt_temp = ""
	elif code >= 10: txt_temp = "0"
	else: txt_temp = "00"
	var final_id = str(name_id[eq_main], txt_temp, code)
	var final_id_gb = str(name_id_gb[eq_main])
	var final_type = _eq_type_general(eq_main)
	# SET NAME
	var code_gearset = {17: 0, 18: 1, 19: 2, 20: 3, 21: 4, 22: 5, 23: 6, 24: 7}
	var code_gearset_sc = {25: 0, 26: 1, 27: 2, 28: 3, 29: 4, 30: 5, 31:6}
	var set_main_data = {}
		
	if code in range(1, 17):
		set_main_data = {
			"name": _eq_name(1, eq_main)["name"],
			"desc": _eq_name(1, eq_main)["desc"],
			"id_uniq": "Standard Equipment",
			"desc_uniq": "Common gear crafted to handle various basic situations.",
			"gs":"none" }
	elif code in range(17, 25):
		set_main_data = {
			"name": _eq_name(2, eq_main)["name"],
			"desc": _eq_name(2, eq_main)["desc"],
			"id_uniq": _eq_gearset_desc(code_gearset[code])["id"],
			"desc_uniq": _eq_gearset_desc(code_gearset[code])["desc"],
			"gs": _eq_gearset_desc(code_gearset[code])["gs"] }
	elif code in range(25, 32):
		set_main_data = {
			"name": _eq_name_sc(code_gearset_sc[code], eq_main)["name"],
			"desc": _eq_name_sc(code_gearset_sc[code], eq_main)["desc"],
			"id_uniq": _eq_gearset_sc_desc(code_gearset_sc[code])["id"],
			"desc_uniq": _eq_gearset_sc_desc(code_gearset_sc[code])["desc"],
			"gs": _eq_gearset_sc_desc(code_gearset_sc[code])["gs"]  }
	
	return {
		"name": set_main_data["name"],
		"desc": set_main_data["desc"],
		"type": str(final_type),
		"id": str(final_id),
		"id_gb": str(final_id_gb),
		"id_uniq": set_main_data["id_uniq"],
		"desc_uniq": set_main_data["desc_uniq"],
		"gs": set_main_data["gs"]
	}
func _eq_grade(value:int) -> Array:
	var arr_0
	var arr_1
	if value >= 120:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.UR)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.UR)
	elif value >= 100:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.SSS)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.SSS)
	elif value >= 90:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.SS)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.SS)
	elif value >= 74:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.S)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.S)
	elif value >= 58:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.S)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.S)
	elif value >= 42:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.A)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.A)
	elif value >= 26:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.B)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.B)
	elif value >= 10:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.C)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.C)
	else:
		arr_0 = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.D)
		arr_1 = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.D)
	return [str("GRADE: ",arr_0), arr_1] # 0: GRADE, 1: COLOR
var _eq_rng_stat_sss = false
func _eq_rng_stat(stat:ENUM_EQ_STAT_MAIN,tier: ENUM_TIER) -> Array :
	var main_code
	var main_stat
	var max_value:int
	
	match stat as ENUM_EQ_STAT_MAIN:
		ENUM_EQ_STAT_MAIN.ATK_FLAT:
			if tier == ENUM_TIER.LEVEL_1: max_value = 10000
			elif tier == ENUM_TIER.LEVEL_2: max_value = 20000
			elif tier == ENUM_TIER.LEVEL_3: max_value = 50000
			elif tier == ENUM_TIER.LEVEL_4: max_value = 100000
			elif tier == ENUM_TIER.LEVEL_5: max_value = 150000
			else: max_value = 1000
		ENUM_EQ_STAT_MAIN.DEF_FLAT:
			if tier == ENUM_TIER.LEVEL_1: max_value = 500
			elif tier == ENUM_TIER.LEVEL_2: max_value = 1000
			elif tier == ENUM_TIER.LEVEL_3: max_value = 2000
			elif tier == ENUM_TIER.LEVEL_4: max_value = 3000
			elif tier == ENUM_TIER.LEVEL_5: max_value = 5000
			else: max_value = 100
		ENUM_EQ_STAT_MAIN.HP_FLAT:
			if tier == ENUM_TIER.LEVEL_1: max_value = 20000
			elif tier == ENUM_TIER.LEVEL_2: max_value = 50000
			elif tier == ENUM_TIER.LEVEL_3: max_value = 100000
			elif tier == ENUM_TIER.LEVEL_4: max_value = 250000
			elif tier == ENUM_TIER.LEVEL_5: max_value = 400000
			else: max_value = 5000
		ENUM_EQ_STAT_MAIN.TURN_FLAT:
			if tier == ENUM_TIER.LEVEL_1: max_value = 25
			elif tier == ENUM_TIER.LEVEL_2: max_value = 50
			elif tier == ENUM_TIER.LEVEL_3: max_value = 100
			elif tier == ENUM_TIER.LEVEL_4: max_value = 200
			elif tier == ENUM_TIER.LEVEL_5: max_value = 350
			else: max_value = 10
		ENUM_EQ_STAT_MAIN.CRIT_RATE:
			if tier == ENUM_TIER.LEVEL_1: max_value = 5
			elif tier == ENUM_TIER.LEVEL_2: max_value = 10
			elif tier == ENUM_TIER.LEVEL_3: max_value = 25
			elif tier == ENUM_TIER.LEVEL_4: max_value = 20
			elif tier == ENUM_TIER.LEVEL_5: max_value = 30
			else: max_value = 10
		ENUM_EQ_STAT_MAIN.CRIT_DMG:
			if tier == ENUM_TIER.LEVEL_1: max_value = 25
			elif tier == ENUM_TIER.LEVEL_2: max_value = 50
			elif tier == ENUM_TIER.LEVEL_3: max_value = 100
			elif tier == ENUM_TIER.LEVEL_4: max_value = 200
			elif tier == ENUM_TIER.LEVEL_5: max_value = 300
			else: max_value = 25
		ENUM_EQ_STAT_MAIN.SPD_FLAT, ENUM_EQ_STAT_MAIN.EVA_FLAT:
			if tier == ENUM_TIER.LEVEL_1: max_value = 15
			elif tier == ENUM_TIER.LEVEL_2: max_value = 30
			elif tier == ENUM_TIER.LEVEL_3: max_value = 50
			elif tier == ENUM_TIER.LEVEL_4: max_value = 100
			elif tier == ENUM_TIER.LEVEL_5: max_value = 150
			else: max_value = 15
		ENUM_EQ_STAT_MAIN.CRIT_DEF:
			if tier == ENUM_TIER.LEVEL_1: max_value = 10
			elif tier == ENUM_TIER.LEVEL_2: max_value = 15
			elif tier == ENUM_TIER.LEVEL_3: max_value = 20
			elif tier == ENUM_TIER.LEVEL_4: max_value = 30
			elif tier == ENUM_TIER.LEVEL_5: max_value = 40
			else: max_value = 10
		ENUM_EQ_STAT_MAIN.ATK_PCT, ENUM_EQ_STAT_MAIN.DEF_PCT, ENUM_EQ_STAT_MAIN.HP_PCT, ENUM_EQ_STAT_MAIN.TURN_PCT:
			if tier == ENUM_TIER.LEVEL_1: max_value = 20
			elif tier == ENUM_TIER.LEVEL_2: max_value = 40
			elif tier == ENUM_TIER.LEVEL_3: max_value = 70
			elif tier == ENUM_TIER.LEVEL_4: max_value = 150
			elif tier == ENUM_TIER.LEVEL_5: max_value = 250
			else: max_value = 20
	match stat as ENUM_EQ_STAT_MAIN:
		ENUM_EQ_STAT_MAIN.ATK_FLAT: main_code="atk_flat"
		ENUM_EQ_STAT_MAIN.ATK_PCT: main_code="atk_pct"
		ENUM_EQ_STAT_MAIN.DEF_FLAT: main_code="def_flat"
		ENUM_EQ_STAT_MAIN.DEF_PCT: main_code="def_pct"
		ENUM_EQ_STAT_MAIN.HP_FLAT: main_code="hp_flat"
		ENUM_EQ_STAT_MAIN.HP_PCT: main_code="hp_pct"
		ENUM_EQ_STAT_MAIN.TURN_FLAT: main_code="turn_flat"
		ENUM_EQ_STAT_MAIN.TURN_PCT: main_code="turn_pct"
		ENUM_EQ_STAT_MAIN.CRIT_RATE: main_code="crit_rate"
		ENUM_EQ_STAT_MAIN.CRIT_DMG: main_code="crit_dmg"
		ENUM_EQ_STAT_MAIN.SPD_FLAT: main_code="spd_flat"
		ENUM_EQ_STAT_MAIN.EVA_FLAT: main_code="eva_flat"
		ENUM_EQ_STAT_MAIN.CRIT_DEF: main_code="crit_def"
	
	# MEMPERSULIT MENDAPATKAN HIGH TIER ------------------------
	var pct_tier ={0:10, 1:15, 2:20, 3:25, 4:42}
	var _div = 100
	var rng_tier = randi_range(1, 100)
	if _eq_rng_stat_sss: rng_tier = 1
	if rng_tier == 1:
		_div = 120
		pct_tier[3]=70
		pct_tier[2]=60
		pct_tier[1]=50
		pct_tier[0]=40
		if _eq_rng_stat_sss: pct_tier[3]=100
	elif rng_tier <= 10:
		_div = 80
		pct_tier[3]=50
		pct_tier[2]=40
		pct_tier[1]=30
		pct_tier[0]=20
	elif rng_tier <= 20: _div = 60
	elif rng_tier <= 30: _div = 40
	else: _div = 20
		
	if _eq_rng_stat_ur: _div = 150
	main_stat = randi_range(get_pct(max_value, pct_tier[tier]), get_pct(max_value, _div) )
	var grade = _eq_grade(set_pct(main_stat, max_value)) # [0] return str grade [1] return str color code
	return [main_code, main_stat, grade[0], grade[1]]
func _eq_set_stat(_parent:Dictionary, stat_1, stat_2, stat_3):
	var _dict = {
		"stat_1" = {
			"stat_code": stat_1[0],
			"stat_main": stat_1[1],
			"stat_grade": stat_1[2],
			"stat_color": stat_1[3],
			"default_stat": stat_1[1]
		},
		"stat_2" = {
			"stat_code": stat_2[0],
			"stat_main": stat_2[1],
			"stat_grade": stat_2[2],
			"stat_color": stat_2[3],
			"default_stat": stat_2[1]
		},
		"stat_3" = {
			"stat_code": stat_3[0],
			"stat_main": stat_3[1],
			"stat_grade": stat_3[2],
			"stat_color": stat_3[3],
			"default_stat": stat_3[1]
		}
	}
	_parent.merge(_dict)
func _eq_rng_stat_acc(tier):
	var all_rng = {
		1:_eq_rng_stat(ENUM_EQ_STAT_MAIN.ATK_FLAT, tier),
		2:_eq_rng_stat(ENUM_EQ_STAT_MAIN.ATK_PCT, tier),
		3:_eq_rng_stat(ENUM_EQ_STAT_MAIN.DEF_FLAT, tier),
		4:_eq_rng_stat(ENUM_EQ_STAT_MAIN.DEF_PCT, tier),
		5:_eq_rng_stat(ENUM_EQ_STAT_MAIN.HP_FLAT, tier),
		6:_eq_rng_stat(ENUM_EQ_STAT_MAIN.HP_PCT, tier),
		7:_eq_rng_stat(ENUM_EQ_STAT_MAIN.TURN_FLAT, tier),
		8:_eq_rng_stat(ENUM_EQ_STAT_MAIN.TURN_PCT, tier),
		9:_eq_rng_stat(ENUM_EQ_STAT_MAIN.CRIT_RATE, tier),
		10:_eq_rng_stat(ENUM_EQ_STAT_MAIN.CRIT_DMG, tier),
		11:_eq_rng_stat(ENUM_EQ_STAT_MAIN.SPD_FLAT, tier),
		12:_eq_rng_stat(ENUM_EQ_STAT_MAIN.EVA_FLAT, tier),
		13:_eq_rng_stat(ENUM_EQ_STAT_MAIN.CRIT_DEF, tier),
	}
	return all_rng[randi_range(1, 13)]
	
func eq_gen(equipment:ENUM_EQ_MAIN, tier:ENUM_TIER) -> Dictionary:
	var rng:int # SET VALUE (RNG) TO GET GET RANDOM ITEM BASE ON OWN LEVEL
	var temp_dict:Dictionary
	
	if equipment == ENUM_EQ_MAIN.ACC:
		match tier:
			ENUM_TIER.LEVEL_3: rng = randi_range(14, 25)
			ENUM_TIER.LEVEL_4: rng = randi_range(26, 30)
			ENUM_TIER.LEVEL_5: rng = randi_range(31, 34)
			_: rng = randi_range(1, 13)
	else:
		match tier:
			ENUM_TIER.LEVEL_1: rng = randi_range(1, 16)
			ENUM_TIER.LEVEL_2: rng = randi_range(17, 24)
			ENUM_TIER.LEVEL_3: rng = randi_range(25, 28)
			ENUM_TIER.LEVEL_4: rng = randi_range(29, 30)
			ENUM_TIER.LEVEL_5: rng = 31 
	
	match tier:
		4:
			temp_dict["grade_txt"] = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.UR)
			temp_dict["grade_color"] = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.UR)
		3:
			temp_dict["grade_txt"] = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.SSS)
			temp_dict["grade_color"] = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.SSS)
		2:
			temp_dict["grade_txt"] = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.SS)
			temp_dict["grade_color"] = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.SS)
		1:
			temp_dict["grade_txt"] = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.S)
			temp_dict["grade_color"] = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.S)
		0:
			temp_dict["grade_txt"] = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.A)
			temp_dict["grade_color"] = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.A)
		_:
			temp_dict["grade_txt"] = string_grade_tier(ENUM_GRADE_TYPE.GRADE, ENUM_GRADE.D)
			temp_dict["grade_color"] = string_grade_tier(ENUM_GRADE_TYPE.COLOR, ENUM_GRADE.D)
	
	var desc_temp = _eq_dict_gen(rng, equipment)
	match equipment:
		ENUM_EQ_MAIN.ACC:
			#desc_temp = _eq_acc_desc[rng] # NOTE: SELAIN ACC BELUM DIBUAT
			temp_dict["icon"] = get_img.img_eq_acc(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_acc(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat_acc(tier),
				_eq_rng_stat_acc(tier),
				_eq_rng_stat_acc(tier) )
		ENUM_EQ_MAIN.ARMOR:
			temp_dict["icon"] = get_img.img_eq_armor(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_armor(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.DEF_PCT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.HP_PCT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.CRIT_DEF, tier) )
		ENUM_EQ_MAIN.GLOVES:
			temp_dict["icon"] = get_img.img_eq_glove(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_glove(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.ATK_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.HP_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.SPD_FLAT, tier) )
		ENUM_EQ_MAIN.HELM:
			temp_dict["icon"] = get_img.img_eq_helm(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_helm(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.DEF_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.HP_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.TURN_PCT, tier) )
		ENUM_EQ_MAIN.SHOES:
			temp_dict["icon"] = get_img.img_eq_shoes(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_shoes(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.SPD_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.EVA_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.TURN_FLAT, tier) )
		ENUM_EQ_MAIN.TROUSERS:
			temp_dict["icon"] = get_img.img_eq_trousers(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_trousers(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.HP_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.DEF_PCT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.EVA_FLAT, tier) )
		ENUM_EQ_MAIN.WPN_MELEE:
			temp_dict["icon"] = get_img.img_eq_wpn_melee(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_wpn_melee(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.ATK_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.ATK_PCT, tier),
				_eq_rng_stat_acc(tier) )
		ENUM_EQ_MAIN.WPN_WIZ:
			temp_dict["icon"] = get_img.img_eq_wpn_wiz(rng)
			temp_dict["icon_raw"] = get_img.raw_img_eq_wpn_wiz(rng)
			_eq_set_stat(
				temp_dict,
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.ATK_FLAT, tier),
				_eq_rng_stat(ENUM_EQ_STAT_MAIN.TURN_FLAT, tier),
				_eq_rng_stat_acc(tier) )
	# BASIC DESC
	# icon = set gambar
	var _enhance = {
		0:{ "max":5, "price":10000, "sell":20000},
		1:{ "max":10, "price":50000, "sell":100000},
		2:{ "max":15, "price":500000, "sell":1000000},
		3:{ "max":20, "price":2500000, "sell":5000000},
		4:{ "max":25, "price":25000000, "sell":50000000},
	}
	var sell_total = _eq_sell_total(temp_dict["stat_1"]["stat_grade"],temp_dict["stat_2"]["stat_grade"],temp_dict["stat_3"]["stat_grade"])
	temp_dict ["gs"] = desc_temp["gs"]
	temp_dict ["name"] = desc_temp["name"] # name
	temp_dict ["type"] = desc_temp["type"] # type (desc)
	temp_dict ["desc"] =  desc_temp["desc"] # desc
	temp_dict ["id"] = desc_temp["id"] # uniq id
	temp_dict ["id_gb"] = desc_temp["id_gb"] # id global
	temp_dict ["id_uniq"] = desc_temp["id_uniq"] # id gear set
	temp_dict ["desc_uniq"] = desc_temp["desc_uniq"]
	temp_dict ["is_equiped"] = false
	temp_dict ["eq_lock"] = false
	temp_dict ["sell"] = int(_enhance[tier]["sell"]*sell_total) # SELLING PRICE
	temp_dict ["enhance_main"] = 0
	temp_dict ["enhance_min"] = 0
	temp_dict ["enhance_max"] = _enhance[tier]["max"] # MAX ENHANCE
	temp_dict ["enhance_price"] = _enhance[tier]["price"]*sell_total # ENHANCE UPGRADE PRICE
	return temp_dict
	# ----------------------- EQ CHEST -----------------------
func _eq_sell_total(stat_1, stat_2, stat_3):
	var grade = {"GRADE: D":2,"GRADE: C":3,"GRADE: B":4,"GRADE: A":5,"GRADE: S":6,"GRADE: SS":7,"GRADE: SSS":8,"GRADE: UR":9,}
	var total:int =0
	total += grade[stat_1]
	total += grade[stat_2]
	total += grade[stat_3]
	
	return total
var _eq_rng_stat_ur = false
# ----------------- MAIN FUNC TO MAKE DICT ITEM ------------------
func eq_chest(level: int, loop_id:int) -> Dictionary: # MAIN FUNC TO GENERATE EQ DICT AN AUTO SAVE TO DB
	if level == 7: _eq_rng_stat_sss = true
	elif level == 8: _eq_rng_stat_ur = true
	var grade_eq: int
	var grade_acc: int = 0  # Inisialisasi dengan nilai default
	var rand: int
	var level_limit = clamp(level, 1, 8)
	
	# Generate random number untuk setiap pengecekan probabilitas secara terpisah
	var rng_item_type = randi_range(1, 100)
	var rng_grade_eq = randi_range(1, 100)
	var rng_grade_acc = randi_range(1, 100)
	
	match level_limit:
		1:
			rand = 2
			grade_eq = 0
		2:
			rand = 2
			if rng_grade_eq <= 20: grade_eq = 1
			else: grade_eq = 0
		3:
			if rng_item_type <= 5: rand = 1
			else: rand = 2
			
			if rng_grade_eq <= 10: grade_eq = 2
			elif rng_grade_eq <= 30: grade_eq = 1
			else: grade_eq = 0
			
			grade_acc = 1
		4:
			if rng_item_type <= 15: rand = 1
			else: rand = 2
			
			if rng_grade_eq <= 10: grade_eq = 3
			
			elif rng_grade_eq <= 30: grade_eq = 2
			else: grade_eq = 1
			
			if rng_grade_acc <= 20: grade_acc = 2
			else: grade_acc = 1
		5:
			if rng_item_type <= 20: rand = 1
			else: rand = 2
			
			if rng_grade_eq <= 30: grade_eq = 3
			else: grade_eq = 2
			
			if rng_grade_acc <= 10: grade_acc = 3
			elif rng_grade_acc <= 30: grade_acc = 2
			else: grade_acc = 1
		6:
			if rng_item_type <= 25: rand = 1
			else: rand = 2
			
			if rng_grade_eq == 1: grade_eq = 4
			else: grade_eq = 3
			
			if rng_grade_acc <= 20: grade_acc = 3
			else: grade_acc = 2
		7:
			rand = 2
			if rng_grade_eq <= 35: grade_eq = 3
			else: grade_eq = 2
		8:
			if rng_item_type <= 30: rand = 1
			else: rand = 2
			
			if rng_grade_eq <= 30: grade_eq = 4
			else: grade_eq = 3
			
			if rng_grade_acc <= 15: grade_acc = 4
			elif rng_grade_acc <= 35: grade_acc = 3
			else: grade_acc = 2
			
	var _rand = {
		1: eq_gen(ENUM_EQ_MAIN.ACC, grade_acc),  # Aksesori
		2: eq_gen(randi_range(1, 7), grade_eq),  # Weapon/Armor
	}
	if _eq_rng_stat_sss: _eq_rng_stat_sss = false
	elif _eq_rng_stat_ur: _eq_rng_stat_ur = false
	# SET ID NODE
	_rand[rand]["id_node"]= str(_rand[rand]["id"],"_",get_uniq_id(loop_id))
	var _id_node = _rand[rand]["id_node"]
	AutoloadData.player_equipment[_id_node] = _rand[rand]
	#AutoloadData.player_equipment[_id_node] = _rand[rand]
	AutoloadData.roadmap_total_eq+=1
	AutoloadData.save_data()
	return _rand[rand]
# ----------------------------- EQUIPMENT: END ------------------------------

# ----------------------------- INVENTORY: START ------------------------------
enum ENUM_INVENTORY{CARD_GACHA, CHEST, ENHANCE, FRAGMENTS, MISC, TOKEN}
func _inventory_currency(code) -> Dictionary:
	var limit_code = clamp(code, 1, 4)
	var _get_current = {1:AutoloadData.player_exp, 2:AutoloadData.player_money, 3:AutoloadData.player_super_ticket}
	var main_desc = {
		1:{
			"name":currency[1]["name"],
			"desc":currency[1]["desc"],
			"icon":currency[1]["icon"]
		},2:{
			"name":currency[0]["name"],
			"desc":currency[0]["desc"],
			"icon":currency[0]["icon"]
		},3:{
			"name":currency[2]["name"],
			"desc":currency[2]["desc"],
			"icon":currency[2]["icon"]
		}
	}
	return {
		"name": main_desc[limit_code]["name"],
		"icon": main_desc[limit_code]["icon"],
		"type":"Currency",
		"desc":main_desc[limit_code]["desc"],
		"own": _get_current[limit_code],
		"id_node" : str("inven_currency_",limit_code),
	}
func _inventory_card_gacha(code) -> Dictionary:
	var img_data = Load_images.new()
	var limit_code = clamp(code, 1, AutoloadData.player_inventory_card_gacha.size())
	var main_desc = {
		1:{
			"name":"Water Card",
			"desc":"Contains cards with the water element, randomly obtained from 3-star to 6-star with a certain rate."
		},2:{
			"name":"Nature Card",
			"desc":"Contains cards with the nature element, randomly obtained from 3-star to 6-star with a certain rate."
		},3:{
			"name":"Fire Card",
			"desc":"Contains cards with the fire element, randomly obtained from 3-star to 6-star with a certain rate."
		},4:{
			"name":"Light Card",
			"desc":"Contains cards with the light element, randomly obtained from 3-star to 6-star with a certain rate."
		},5:{
			"name":"Dark Card",
			"desc":"Contains cards with the dark element, randomly obtained from 3-star to 6-star with a certain rate."
		},6:{
			"name":"Apex Card",
			"desc":"A very special card containing all elements, with a rate between 5-star and 6-star."
		},
	}
	return {
		"name": main_desc[limit_code]["name"],
		"icon": img_data.img_inventory_card_gacha(limit_code),
		"type":"Card Gacha",
		"desc":main_desc[limit_code]["desc"],
		"own": AutoloadData.player_inventory_card_gacha[limit_code],
		"id_node" : str("inven_card_gacha_",limit_code),
	}
func _inventory_chest_dict(code) -> Dictionary:
	var img_data = Load_images.new()
	var limit_code = clamp(code, 1, AutoloadData.player_inventory_chest.size())
	var main_desc = {
		1:{
			"name":"Wooden Gearchest",
			"desc":"A basic war crate made of aged wood. Contains random starter gear for fresh adventurers."
		},2:{
			"name":"Iron-Wood Gearchest",
			"desc":"A sturdy chest reinforced with iron. Holds random early-tier gear fit for new warriors."
		},3:{
			"name":"Golden-Wood Gearchest",
			"desc":"A refined chest of polished wood and gold trim. Contains rare gear for rising champions."
		},4:{
			"name":"Mystic Iron Gearchest",
			"desc":"A purple-forged iron chest adorned with violet gems. Holds enchanted gear touched by arcane forces."
		},5:{
			"name":"Crimson Iron Gearchest",
			"desc":"A heavy iron chest radiating a fierce red aura. Contains powerful gear forged for seasoned warriors."
		},6:{
			"name":"Draconic Crimson Gearchest",
			"desc":"A grand red-and-black chest carved with dragon motifs. Holds elite gear infused with ancient draconic power."
		},7:{
			"name":"Draconic Apex Gearchest",
			"desc":"A mighty chest of red and black, etched with dragon sigils. Guarantees high-tier gear—no luck, only power."
		},8:{
			"name":"Gaia's Celestial Gearchest",
			"desc":"A radiant blue chest, glowing with the essence of Gaia itself. This legendary chest holds the ultimate gear, infused with the full power of the earth and sky."
		}
	}
	return {
		"name": main_desc[limit_code]["name"],
		"icon": img_data.img_inventory_chest(limit_code),
		"type":"Gearchest Box",
		"desc":main_desc[limit_code]["desc"],
		"own": AutoloadData.player_inventory_chest[limit_code],
		"id_node" : str("inven_chest_",limit_code),
	}
func _inventory_enhance_dict(code) -> Dictionary:
	var img_data = Load_images.new()
	var limit_code = clamp(code, 1, AutoloadData.player_inventory_enhance.size())
	var main_desc = {
		1:{
			"name":"Broken Envil",
			"desc":"A damaged yet still functional forge, worn from years of use. Though cracked and battered, it can still enhance low-level gear, channeling just enough power to improve weapons and armor for fledgling adventurers."
		},2:{
			"name":"Quality Envil",
			"desc":"A forge of fine craftsmanship, capable of enhancing commander-level gear. Its steady flame empowers weapons and armor, boosting their strength with precision and skill. Ideal for those ready to face greater challenges."
		},3:{
			"name":"Titan Envil",
			"desc":"A forge of immense power, glowing with a radiant blue aura. This formidable Envil radiates energy capable of enhancing legendary equipment, imbuing it with unmatched strength and aura. Only the most skilled can harness its full potential to craft weapons and armor of legendary status."
		},4:{
			"name":"Golden Envil",
			"desc":"The pinnacle of forges, shimmering with a brilliant golden glow. This Envil has the unparalleled ability to enhance any equipment, regardless of its nature or origin, imbuing it with supreme power. Only the worthy can wield its might to forge true legends."
		},
	}
	return {
		"name":main_desc[limit_code]["name"],
		"icon": img_data.img_inventory_enhance(code),
		"type":"Gear Enhance Tool",
		"desc":main_desc[limit_code]["desc"],
		"own": AutoloadData.player_inventory_enhance[code],
		"id_node" : str("inven_enhance_",limit_code),
	}
func _inventory_frag_dict(code) -> Dictionary:
	var img_data = Load_images.new()
	var limit_code = clamp(code, 1, AutoloadData.player_inventory_fragment.size())
	var main_desc = {
		1:{
			"name":"Asha's Feather",
			"desc":"The last feather of Agni's Finix, still burning with the rage of its death. Its touch can ignite fate itself."
		},
		2:{
			"name":"Horn of Tharok",
			"desc":"Torn from the last legendary rhino in a battle that split mountains. Still echoes with primal fury."
		},3:{
			"name":"Broken Lyre of Seraphim",
			"desc":"Once sang the harmonies of heaven—now cracked, it weeps haunting notes that stir forgotten sorrow."
		},4:{
			"name":"Shed Scale of Vyrnath",
			"desc":"Once part of an ancient dragon’s armor. Still hums with the echoes of storms it once deflected."
		},5:{
			"name":"Elarin’s Verdant Relic",
			"desc":"An elven heirloom carved from living wood. Whispers forgotten oaths when touched by moonlight."
		},6:{
			"name":"Azure Plume of Zephra",
			"desc":"From a bird that rides the sky’s edge. Light as wind, yet holds the weight of forgotten skies."
		},7:{
			"name":"Lava Sigil Stone",
			"desc":"Forged in the heart of an eruption, this stone bears an ancient symbol—its heat burns with unspoken power."
		},8:{
			"name":"Kecubung",
			"desc":"The materials Mr. Bobon uses to have fun."
		},9:{
			"name":"Orb of Eternal Tides",
			"desc":"A shimmering sphere that pulses with unknown currents. It holds the whispers of the deep, a tide that never fades."
		},10:{
			"name":"Eye of Umbraroth",
			"desc":"A gaze that sees through shadows, piercing the very fabric of darkness. It holds the power to bend light and consume hope."
		},11:{
			"name":"Frostbranch of Aeloria",
			"desc":"A chilling branch plucked from the heart of eternal winter. It pulses with a frozen breath, capable of freezing time itself."
		},12:{
			"name":"Heart of the Infernal Beast",
			"desc":"A beating ember from a creature born of flame. Its fiery pulse ignites the air, scorching all that dare to approach."
		},13:{
			"name":"Radiant Golden Amuelt",
			"desc":"A sacred talisman that gleams with blinding light. Its glow protects and guides, banishing shadows from the soul."
		},14:{
			"name":"Hexalite of the Deep Azure",
			"desc":"A mysterious blue gem, shaped in a perfect hexagon, its facets pulse with hidden energy. Its glow beckons, yet reveals nothing."
		},15:{
			"name":"Sapphire of the Forgotten",
			"desc":"A deep blue stone that hums with ancient power. Its origins are lost to time, yet its aura promises both secrets and peril."
		},16:{
			"name":"Flarestone of the Inferno",
			"desc":"A stone that radiates searing heat, as if it holds the very essence of a sun. It burns with a relentless fury, waiting to unleash its fury."
		},17:{
			"name":"Mystic Artifact of Umbra",
			"desc":"A shadowed relic, draped in forgotten magics. It hums with an eerie presence, its true power concealed in the veil of darkness."
		},18:{
			"name":"Verdant Energy Stone",
			"desc":"A vibrant green stone that pulses with life force. Its power resonates with the earth, granting strength to those who seek harmony with nature."
		},19:{
			"name":"Crystal of Glacial Dawn",
			"desc":"A shard of pure ice, frozen at the break of a thousand dawns. It shimmers with cold, holding the stillness of winter’s heart."
		},20:{
			"name":"Emberborn Relic",
			"desc":"A relic that refuses to cool, its heat ever-burning with the remnants of a lost fire. Touching it means embracing the fury of an eternal flame."
		},21:{
			"name":"Conch of Eternal Tide",
			"desc":"A radiant shell that hums with the rhythm of the ocean's deepest currents. It channels the raw energy of the seas, granting the power to summon storms or calm the waters. Yet, its force is unpredictable—control it, and you command nature itself; lose focus, and be swept away by its boundless might."
		},22:{
			"name":"Bone of the Abyssal Depths",
			"desc":"A deep blue bone, encrusted with coral that thrives in the darkest waters. Its eerie glow emanates from within, resonating with the forgotten spirits of the sea. This ancient relic holds the power to command the ocean’s creatures, but those who seek to harness its strength must risk being consumed by the very depths it was forged in. The coral serves as both a warning and a guide—only the bold can unlock its true potential."
		},23:{
			"name":"Eye of the Abyssal Serpent",
			"desc":"A single, glowing eye plucked from a monstrous sea creature that lurks in the darkest waters. Its eerie gaze pierces through the veil of night, revealing hidden truths and ancient horrors beneath the waves. The eye pulses with a life of its own, able to summon the terror of the deep, but those who stare into it too long risk being lost to the abyss, forever marked by its haunting vision."
		},24:{
			"name":"Root of the Frozen Heart",
			"desc":"A deep blue root, twisted and gnarled, pulsing with an otherworldly energy. It thrives in the coldest of places, drawing power from the heart of frozen earth. This root can heal or freeze, depending on the will of its user, but its true strength lies in the balance of life and death it embodies. To wield it is to control the coldest aspects of nature—yet it whispers of ancient sorrows best left forgotten."
		},25:{
			"name":"Crystal of the Bound Grove",
			"desc":"A violet crystal intertwined with ancient roots, its surface flickering with the pulse of hidden life. It binds the essence of nature, merging the power of the earth with the strength of the arcane. The crystal’s energy can fortify the soul or ensnare it, as its roots extend deep into the fabric of the world. Wielding it grants control over nature’s forces—but those who seek its power must remain ever-vigilant, for the crystal’s grasp grows tighter with every use."
		},26:{
			"name":"Cyan Shard of the Tempest",
			"desc":"A crystal of striking cyan, glowing with the energy of untamed storms. It hums with the power of the sky’s fury, capable of calling down lightning or calming the winds. Its surface shimmers like the ocean at dawn, yet within it lies a volatile force—one that can either protect or obliterate. To wield this crystal is to hold dominion over the very weather itself, but its temper is as unpredictable as the storms it commands."
		},27:{
			"name":"Crystal of Pure Aether",
			"desc":"A flawless, clear blue crystal that shimmers like a tranquil ocean under the sun. It resonates with an otherworldly energy, a pure essence that bends light and time itself. This crystal holds the ability to amplify magic to unimaginable heights, but its calm exterior hides a deep, boundless power—one that can either heal or unravel reality. To wield it requires perfect harmony of mind and spirit, for even the slightest imbalance could fracture its delicate balance."
		},28:{
			"name":"Mystic Blue Dust",
			"desc":"A fine, shimmering powder that glows with an ethereal blue hue. It carries the essence of forgotten spells, capable of unlocking ancient magic or summoning mysterious forces. This dust is volatile, and when used, it can either enhance a spell to unimaginable levels or spiral into chaotic distortion. Those who seek to control its power must tread carefully, for the very nature of the dust is unpredictable—its magic is as much a gift as it is a curse."
		},29:{
			"name":"Leaf of the Celestial Veil",
			"desc":"A delicate, vibrant blue leaf pulsing with mystic energy. It hums with the essence of the skies, drawing from an ancient, hidden power that transcends time. This leaf can heal wounds, sharpen senses, or summon winds of great force. However, its energy is unpredictable—while it may heal one moment, it can unleash destructive power the next. To use it is to walk the line between creation and chaos, guided only by the faintest whisper of forgotten winds."
		},30:{
			"name":"Rooted Cyan Crystal",
			"desc":"A stunning cyan crystal, intertwined with the roots of ancient, unseen plants. Its glow pulses like the heartbeat of the earth, drawing energy from the deep, fertile soil below. This crystal embodies the harmony of nature’s growth and the raw power of the elements. When held, it channels both earth and sky, enhancing plant life or unleashing destructive growth. Yet, as its roots spread, it also demands a bond with its wielder—those who seek its power must be willing to nurture or risk being consumed by the very force they command."
		},
	}
	return {
		"name":main_desc[limit_code]["name"],
		"icon": img_data.img_inventory_fragments(code),
		"type":"Fragment",
		"desc":main_desc[limit_code]["desc"],
		"own": AutoloadData.player_inventory_fragment[code],
		"id_node" : str("inven_frag_",limit_code),
	}
func _inventory_misc_dict(code) -> Dictionary:
	var img_data = Load_images.new()
	var limit_code = clamp(code, 1, AutoloadData.player_inventory_misc.size())
	var main_desc = {
		1:{
			"name":"Gold treasure",
			"desc":"Receive a random amount of gold ranging from 1,000,000 to 10,000,000."
		},2:{
			"name":"Mana Treasure",
			"desc":"Receive a random amount of mana ranging from 100,000 to 1,000,000."
		},3:{
			"name":"Ticket Treasure",
			"desc":"Receive a random amount of Super ticket ranging from 50 to 500"
		},4:{
			"name":"Login Check-in",
			"desc":"Receive a random reward every time you log in."
		},5:{
			"name":"Gaia Key",
			"desc":"A Gaia key that can only be used to unlock the Gaia Celestial Gearchest."
		},
	}
	return {
		"name":main_desc[limit_code]["name"],
		"icon": img_data.img_inventory_misc(code),
		"type":"Misc",
		"desc":main_desc[limit_code]["desc"],
		"own": AutoloadData.player_inventory_misc[code],
		"id_node" : str("inven_misc_",limit_code),
		
	}
func _inventory_token_dict(code) -> Dictionary:
	var img_data = Load_images.new()
	var limit_code = clamp(code, 1, AutoloadData.player_inventory_token.size())
	var main_desc = {
		1:{
			"name":"Demon Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Demons."
		},2:{
			"name":"Dragon Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Dragon."
		},3:{
			"name":"Elf Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Elf."
		},4:{
			"name":"Goblin Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Goblin."
		},5:{
			"name":"Mech Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Mech."
		},6:{
			"name":"Minotaur Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Minotaur."
		},7:{
			"name":"Viking Token",
			"desc":"A highly valuable token used to unlock the portal gate to the Dimension of Viking."
		},
	}
	return {
		"name":main_desc[limit_code]["name"],
		"icon": img_data.img_inventory_token(code),
		"type":"Token",
		"desc":main_desc[limit_code]["desc"],
		"own": AutoloadData.player_inventory_token[code],
		"id_node" : str("inven_token_",limit_code),
	}
