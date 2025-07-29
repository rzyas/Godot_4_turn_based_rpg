class_name Gate_desc

var tools_code = ["Farm", "Fisher", "Hunter", "Miner", "Thief"]
var tools_item = {
	"Farm": {
		0: {"name": "Old Shovel", "desc": "An old shovel once used for planting various crops. It looks simple, but it carries the power of nature in every swing."},
		1: {"name": "Natural Fertilizer", "desc": "A natural fertilizer that accelerates plant growth. It radiates a warm energy that makes the soil more fertile."},
		2: {"name": "Rare Plant Seeds", "desc": "Rare plant seeds that thrive in the right hands. They hold the potential for new life."},
		3: {"name": "Bucket of Water", "desc": "A bucket filled with clear water. A simple yet vital source of life for nature."},
		4: {"name": "Scarecrow", "desc": "A scarecrow made of straw and tattered cloth. Though silent, its presence protects the fields from harm."}
	},
	"Fisher": {
		0: {"name": "Fishing Boat", "desc": "A small boat used for fishing on lakes or rivers. Light, quiet, and ready to accompany a silent morning."},
		1: {"name": "Bait Box", "desc": "A bait box filled with fresh worms. A trusty companion for anglers seeking a bountiful catch."},
		2: {"name": "Fishing Rod", "desc": "A simple yet sturdy fishing rod. The main tool for catching fish with patience and calm."},
		3: {"name": "Fishing Net", "desc": "A wide and sturdy fishing net. Ideal for catching multiple fish at once in calm waters."},
		4: {"name": "Cast Net", "desc": "A hand-thrown fishing cast net. It takes skill, but can catch a large number of fish at once."}
	},
	"Hunter": {
		0: {"name": "Beast Trap", "desc": "A sturdy iron trap used to catch wild beasts. Dangerous, but effective when used with caution."},
		1: {"name": "Crossbow", "desc": "A high-precision crossbow with powerful range. The weapon of choice for hunters who value distance and accuracy."},
		2: {"name": "Dual Short Swords", "desc": "A pair of short swords, light and swift. Perfect for agile fighters who rely on speed and dexterity."},
		3: {"name": "Rope", "desc": "A sturdy and versatile rope. Useful for climbing, tying, or setting traps."},
		4: {"name": "Travel Backpack", "desc": "A large backpack for carrying gear during adventures. Comfortable, durable, and always ready for long journeys."}
	},
	"Miner": {
		0: {"name": "Mining Helmet", "desc": "A sturdy helmet with a central light, designed for miners. Provides protection and illumination in dark places."},
		1: {"name": "Pickaxe", "desc": "A sharp pickaxe used to break rocks and mine minerals. The essential tool of a true miner."},
		2: {"name": "Lantern", "desc": "An old lantern that emits a warm glow. A faithful companion when exploring the night and dark places."},
		3: {"name": "Mine Cart", "desc": "A small mine cart used to transport rocks and minerals. Its iron frame is sturdy, and its wheels creak as it moves."},
		4: {"name": "Oxygen Tank", "desc": "A portable oxygen tank for breathing in toxic areas or enclosed spaces. Essential for survival in extreme environments."}
	},
	"Thief": {
		0: {"name": "Poison Dagger", "desc": "A small dagger coated with deadly poison. A stealthy weapon for swift and lethal strikes."},
		1: {"name": "Green Poison Bottle", "desc": "A deadly green poison stored in a small bottle. Just a few drops are enough to end the life of any living creature."},
		2: {"name": "Bow", "desc": "A strong yet lightweight flexible bow. The main weapon of archers for striking from afar with high accuracy."},
		3: {"name": "Voodoo Doll", "desc": "A mysterious food infused with dark energy. It’s said that anyone who eats it may fall under a deadly curse."},
		4: {"name": "Ancient Smoke Bomb", "desc": "An ancient smoke bomb crafted from traditional mixtures. When thrown, it erupts into a thick fog that shrouds the surrounding area."}
	}, }
var tools_job = {
	"farm":"A farmer skilled in cultivating the land and growing various crops. Requires little stamina but demands proper knowledge for the best results.",
	"fisher":"An angler skilled in waiting patiently in the right spot. Requires little stamina but great wisdom to catch the best fish.",
	"hunter":"A hunter who faces wild beasts in the wilderness. Must possess great strength and wisdom to survive and conquer their prey.",
	"miner":"A miner who digs deep into the earth in search of valuable minerals. Requires immense strength and sufficient intellect to operate in extreme environments.",
	"assassin":"An assassin who moves in the shadows. Requires no great strength—only exceptional intellect and communication skills to complete missions without a trace." }

func tools_path_img(job, item):
	var limit_item = clamp(item, 0, 4)
	var main_code = str("res://img/Gate/Job Icon/",tools_code[job],"_",limit_item,".png")
	return main_code

func dg_break_path(code):
	var limit_code = clamp(code, 1, 20)
	return str( "res://img/Gate/Monster Icon/",limit_code,".png" )
var dg_break_data = {
	1:{
		"name":"Gloomcap Sprout",
		"desc":"A glowing mushroom creature from the wet forest, weak but multiplies quickly.",
		"power":randi_range(2000, 3000),
		"rwd":randi_range(200, 300),
		"img":dg_break_path(1)
	},
	2:{
		"name":"Cragback Mauler",
		"desc":"A giant rat monster lurking in the ruins, strikes with savage desperation.",
		"power":randi_range(3000, 4500),
		"rwd":randi_range(300, 450),
		"img":dg_break_path(2)
	},
	3:{
		"name":"Sewer Fangmutt",
		"desc":"A foul mutated rodent that rules the city's ancient sewer lines.",
		"power":randi_range(4500, 6000),
		"rwd":randi_range(450, 600),
		"img":dg_break_path(3)
	},
	4:{
		"name":"Moglin the Glutton",
		"desc":"A greedy forest goblin haunting the roots of fallen giants.",
		"power":randi_range(6000, 8000),
		"rwd":randi_range(600, 800),
		"img":dg_break_path(4)
	},
	5:{
		"name":"Frostwing Scout",
		"desc":"An icy wyvern that patrols the frozen peaks in small hunting packs.",
		"power":randi_range(8000, 11000),
		"rwd":randi_range(800, 1100),
		"img":dg_break_path(5)
	},
	6:{
		"name":"Ashclaw Raptor",
		"desc":"A fireborne predator that hunts the scorched lands with burning talons.",
		"power":randi_range(11000, 15000),
		"rwd":randi_range(1100, 1500),
		"img":dg_break_path(6)
	},
	7:{
		"name":"Shadehowler",
		"desc":"A shadow wolf from the misty valleys, howling only under moonless nights.",
		"power":randi_range(15000, 20000),
		"rwd":randi_range(1500, 2000),
		"img":dg_break_path(7)
	},
	8:{
		"name":"Cavern Siren",
		"desc":"A deep-sea dweller that lures intruders with its haunting, magical voice.",
		"power":randi_range(20000, 27000),
		"rwd":randi_range(2000, 2700),
		"img":dg_break_path(8)
	},
	9:{
		"name":"Maw of Rotgrove",
		"desc":"A massive carnivorous plant that rules the damp, toxic caves.",
		"power":randi_range(27000, 35000),
		"rwd":randi_range(2700, 3500),
		"img":dg_break_path(9)
	},
	10:{
		"name":"Cindermaw Behemoth",
		"desc":"A lava-forged beast dwelling in the heart of an active volcano.",
		"power":randi_range(35000, 44000),
		"rwd":randi_range(3500, 4400),
		"img":dg_break_path(10)
	},
	11:{
		"name":"Boneclad Charger",
		"desc":"An undead warhorse encased in bone armor, forever hunting lost souls.",
		"power":randi_range(44000, 53000),
		"rwd":randi_range(4400, 5300),
		"img":dg_break_path(11)
	},
	12:{
		"name":"Wraithbound Sentinel",
		"desc":"A cursed guardian haunting the ruins of forgotten temples.",
		"power":randi_range(53000, 63000),
		"rwd":randi_range(5300, 6300),
		"img":dg_break_path(12)
	},
	13:{
		"name":"Obsidian Colossus",
		"desc":"An ancient giant carved from black stone, awakened by war.",
		"power":randi_range(63000, 72000),
		"rwd":randi_range(6300, 7200),
		"img":dg_break_path(13)
	},
	14:{
		"name":"Phantom Dancer",
		"desc":"A swift shadow spirit that cuts through enemies in a blink.",
		"power":randi_range(72000, 80000),
		"rwd":randi_range(7200, 8000),
		"img":dg_break_path(14)
	},
	15:{
		"name":"Blizzard Serpent",
		"desc":"An ice dragon whose gaze freezes even the fiercest flames.",
		"power":randi_range(80000, 88000),
		"rwd":randi_range(8000, 8800),
		"img":dg_break_path(15)
	},
	16:{
		"name":"Sandhowl Warbrute",
		"desc":"A desert juggernaut with skin like stone and strength like a storm.",
		"power":randi_range(88000, 96000),
		"rwd":randi_range(8800, 9600),
		"img":dg_break_path(16)
	},
	17:{
		"name":"Cryo Shardling",
		"desc":"A living crystal born from eternal frost, radiating deadly cold.",
		"power":randi_range(96000, 104000),
		"rwd":randi_range(9600, 10400),
		"img":dg_break_path(17)
	},
	18:{
		"name":"Netherroot Tyrant",
		"desc":"A tyrant of twisted roots, feeding on life essence beneath the earth.",
		"power":randi_range(104000, 112000),
		"rwd":randi_range(10400, 11200),
		"img":dg_break_path(18)
	},
	19:{
		"name":"Stormcall Leviathan",
		"desc":"An ancient sea beast that commands storms with a roar.",
		"power":randi_range(112000, 125000),
		"rwd":randi_range(11200, 12500),
		"img":dg_break_path(19)
	},
	20:{
		"name":"Celestial Abysswyrm",
		"desc":"A cosmic serpent from the void, seen only at the world's end.",
		"power":randi_range(125000, 150000),
		"rwd":randi_range(12500, 15000),
		"img":dg_break_path(20)
	}, }
