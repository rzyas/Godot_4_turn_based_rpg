extends Node2D
class_name Base_card

var basic_stat = Base_stat.new()

var get_card_node:String

var skill_0_code: int
var skill_0_dmg
var skill_1_dmg
var skill_2_dmg
var skill_ulti_dmg

var skill_0_hit
var skill_1_hit
var skill_2_hit
var skill_3_hit

var skill_confirm = "skill_0"

var skill_0_target
var skill_1_target
var skill_2_target
var skill_ulti_target

var skill_1_cd
var skill_2_cd
var skill_ulti_cd
var _default_skill_1_cd
var _default_skill_2_cd
var _default_skill_ulti_cd

var own_name
var card_type_confirm

var get_attack
var get_deffense
var get_health
var get_speed
var get_cost
var get_card_name
var get_crit_rate
var get_crit_dmg
var get_speed_atk
var get_evation
var get_crit_deff

var _default_atk
var _default_deff
var _default_hp
var _default_spd
var _default_cst
var _default_crit_rate
var _default_crit_dmg
var _default_speed_atk
var _default_evation
var _default_crit_deff

var _heatlh_limit:int = 0

var turn_action = false
var card_code = null

var psv_attack = true
var psv_defense = true
var psv_health = true
var psv_speed = true
var psv_cost = true
var psv_evation = true
var psv_crit_rate = true
var psv_crit_dmg = true
var psv_crit_deff = true
var psv_speed_attack = true

var dmg_dealt = 0
var dmg_taken = 0
var total_heal = 0
var total_heal_recived = 0
var total_turn = 0
var total_crit = 0
var total_dodge = 0
var exp_get = 0
var elim_card = ""
var elim_card_count:int=0
var elim_by = ""

var default_pos_x
var default_pos_y
var pos_lock = false
func _ready():
	set_main_attr()
	main_desc.visible = false
	class_desc.visible = false

func ai_skill_select():
	var select = "skill_0"
	if skill_ulti_cd == 0: skill_confirm = "skill_ulti"
	elif skill_2_cd == 0: skill_confirm= "skill_2"
	elif skill_1_cd == 0: skill_confirm = "skill_1"
	else: skill_confirm = select

func ai_skill_select_notused_rmdebuff(code):
	var select_activeskill = "skill_0"
	if skill_ulti_cd == 0 and code != "skill_ulti": select_activeskill = "skill_ulti"
	elif skill_2_cd == 0 and code != "skill_2": select_activeskill= "skill_2"
	elif skill_1_cd == 0 and code != "skill_1": select_activeskill = "skill_1"
	skill_confirm = select_activeskill
	
func is_active_col(_bool:bool):
	$CardTransSelect.visible = _bool

enum ENUM_ICON_TURN{ATTACKER, ATTACKED, HEAL, BUFF}
func enable_icon_turn(_bool:bool, _icon:ENUM_ICON_TURN):
	var set_icon_turn: Sprite2D = $class_job/icon_turn
	set_icon_turn.visible = _bool
	
	match _icon:
		ENUM_ICON_TURN.ATTACKER:set_icon_turn.frame = 0
		ENUM_ICON_TURN.ATTACKED:set_icon_turn.frame = 1
		ENUM_ICON_TURN.HEAL:set_icon_turn.frame = 2
		ENUM_ICON_TURN.BUFF:set_icon_turn.frame = 3

# BUFF ICON
@onready var parent_buff = $main_buff
@onready var main_vbox = $Main_desc/Scroll/Main_vbox

# Dictionary to track icons and their counters
var icon_dict := {}
var main_desc_container
	
func update_icon_counter(icon_data):
	if not icon_data is Dictionary:
		print("Error: icon_data bukan sebuah Dictionary")
		return
	
	if not "icon" in icon_data:
		print("Error: Kunci 'icon' tidak ditemukan dalam icon_data")
		return
	
	if not "counter" in icon_data:
		print("Error: Kunci 'counter' tidak ditemukan dalam icon_data")
		return
	
	var icon = icon_data.icon
	var counter = icon_data.counter
	
	if not icon is Node:
		print("Error: 'icon' bukan sebuah Node")
		return
	
	var label = icon.get_node("counter_label")
	if label:
		if label is Label:
			label.text = str(counter)
		else:
			print("Error: 'counter_label' bukan sebuah Label")
	else:
		print("Error: Node 'counter_label' tidak ditemukan")

func set_icon_buff(code: int):
	# Check if the icon already exists
	if icon_dict.has(code):
		var icon_data = icon_dict[code]
		match code:
			0: icon_data.counter = _counter_attack_count
			1: icon_data.counter = _evation_count
			2: icon_data.counter = _defense_breaker_count
			3: icon_data.counter = skill_lock_count
			4: icon_data.counter = _weakaning_count
			5: icon_data.counter = _burn_count
			6: icon_data.counter = _poison_count
			7: icon_data.counter = _heal_count
			8: icon_data.counter = _vampire_count
			9: icon_data.counter = _echo_shiled_count
			10: icon_data.counter = _crit_dmg_count
			11: icon_data.counter = _crit_rate_count
			12: icon_data.counter = _turn_speed_count
			13: icon_data.counter = _defense_up_count
			14: icon_data.counter = _speed_attack_count
			15: icon_data.counter = _attack_up_count
			18: icon_data.counter = _rage_count
			19: icon_data.counter = _grim_reaper_count
			78: icon_data.counter = skill_refcd_dec_count
			79: icon_data.counter = skill_stun_enemy_count
			_: icon_data.counter = ""
		update_icon_counter(icon_data)
	else:
		var own_texture_rect = TextureRect.new()
		var main_icon: Texture
		parent_buff.add_child(own_texture_rect)
		
		var desc_header = "NULL"
		var desc_body = "No Description"
			
		# Set name to delete by name then (ICON)
		match code:
			0: own_texture_rect.name = "icon_counter_attack"
			1: own_texture_rect.name = "icon_evation"
			2: own_texture_rect.name = "icon_dec_deff"
			3: own_texture_rect.name = "icon_lock_skill"
			4: own_texture_rect.name = "icon_weakening"
			5: own_texture_rect.name = "icon_burnt"
			6: own_texture_rect.name = "icon_poison"
			7: own_texture_rect.name = "icon_heal"
			8: own_texture_rect.name = "icon_vampire"
			9: own_texture_rect.name = "icon_echo_shield"
			10: own_texture_rect.name = "icon_crit_dmg"
			11: own_texture_rect.name = "icon_crit_rate"
			12: own_texture_rect.name = "icon_turn_speed"
			13: own_texture_rect.name = "icon_deff"
			14: own_texture_rect.name = "icon_attk_spd"
			15: own_texture_rect.name = "icon_attk_up"
			16: own_texture_rect.name = "icon_more_turn"
			17: own_texture_rect.name = "icon_rebirth"
			18: own_texture_rect.name = "icon_rage"
			19: own_texture_rect.name = "icon_grim"
			78: own_texture_rect.name = "icon_refcd_dec"
			79: own_texture_rect.name = "icon_stun"
			80: own_texture_rect.name = "icon_amimir"
		# Store unique desc
		match code:
			0: 
				main_icon = load("res://img/Base Card/Separate_buff/0.png")
				desc_header = "Counter Attack"
				desc_body = "When the attacker successfully deals damage, they will receive 100% of the total damage dealt. The buff will only decrease by 1 when attacked or successfully dodging (max stacks: 10)."
			1: 
				main_icon = load("res://img/Base Card/Separate_buff/1.png")
				desc_header = "Evation"
				desc_body = str(
					"As long as this buff is active, it grants a chance to dodge attacks. The evasion rate depends on the level. If a dodge is successful, no damage is taken, but enemy debuffs cannot be avoided. The buff decreases by 1 when attacked and when your turn begins (max stacks: 10).",
				)
			2: 
				main_icon = load("res://img/Base Card/Separate_buff/2.png")
				desc_header = "Reduces defense"
				desc_body = str(
					"Temporarily reduces current defense (based on level%). Defense returns to normal after debuff end. The debuff only decreases at the start of the caster turn. Maximum stacks: 5."
				)
			3: 
				main_icon = load("res://img/Base Card/Separate_buff/3.png")
				desc_header = "Skill Lock"
				desc_body = str(
					"Cannot use any skills except red debuff Lock Skill Removed"
				)
			4: 
				main_icon = load("res://img/Base Card/Separate_buff/4.png")
				desc_header = "Weakening"
				desc_body = str(
					"Reduces basic attack, attack speed, turn speed, and evasion based on level. The debuff decreases at the start of the caster's turn. Maximum stacks: 10."
				)
			5: 
				main_icon = load("res://img/Base Card/Separate_buff/5.png")
				desc_header = "Burnt"
				desc_body = str(
					"Deals fixed damage (random 1,000-10,000) + bonus damage per burn stack. Burn debuff have no stack limit."
				)
			6: 
				main_icon = load("res://img/Base Card/Separate_buff/6.png")
				desc_header = "Poison"
				desc_body = "Each time attacking, poison activates, dealing fixed damage based on health condition. The lower the health, the higher the damage dealt"
			7: 
				main_icon = load("res://img/Base Card/Separate_buff/7.png")
				desc_header = "Heal"
				desc_body = str(
					"Heals a portion of health based on base health, with the amount of healing depending on the level. This effect activates at the start of a turn and when receiving an attack (maximum 10 stacks).\n"
				)
			8: 
				main_icon = load("res://img/Base Card/Separate_buff/8.png")
				desc_header = "Vampire"
				desc_body = str(
					"Converts a portion of damage taken from enemies into health recovery (based on level). Maximum stacks: 20.\n"
				)
			9:
				main_icon = load("res://img/Base Card/Separate_buff/9.png")
				desc_header = "Echo Shield"
				desc_body = str(
					"Restores a portion of health (% of current health) and defense (fixed) based on level. Activates when attacked. No stack limit.\n"
				)
			10: 
				main_icon = load("res://img/Base Card/Separate_buff/10.png")
				desc_header = "Critical Damage"
				desc_body = str(
					"Increases additional damage when a critical hit is triggered \n"
					)
			11: 
				main_icon = load("res://img/Base Card/Separate_buff/11.png")
				desc_header = "Critical Hit"
				desc_body = str(
					"When a critical is successfully triggered, you get additional damage according to the critical damage points\n"
				)
			12: 
				main_icon = load("res://img/Base Card/Separate_buff/12.png")
				desc_header = "Turn Speed"
				desc_body = str(
					"The higher the turn speed points, the faster your turn will start, even surpassing the expected turn order.\n"
				)
			13: 
				main_icon = load("res://img/Base Card/Separate_buff/13.png")
				desc_header = "Defense Up"
				desc_body = str(
					"Increase defense by MAX defense.\n"
				)
			14: 
				main_icon = load("res://img/Base Card/Separate_buff/14.png")
				desc_header = "Attack Speed"
				desc_body = str(
					"Increases the potential for dealing damage to enemies who have a high level of evasion\n"
				)
			15: 
				main_icon = load("res://img/Base Card/Separate_buff/15.png")
				desc_header = "Attack Up"
				desc_body = str(
					"Increases a number of MAX attack points\n"
				)
			16: 
				main_icon = load("res://img/Base Card/Separate_buff/16.png")
				desc_header = "More Turn"
				desc_body = str(
					"At the end of their own turn, gains an additional turn\n"
				)
			17: 
				main_icon = load("res://img/Base Card/Separate_buff/17.png")
				desc_header = "Rebirth"
				desc_body = str("Will rebirth after a certain number of turns, after turn Rebirth become 0 restoring 20% of base health")
			18: 
				main_icon = load("res://img/Base Card/Separate_buff/18.png")
				desc_header = "Rage"
				desc_body = str(
					"When health drops to a certain threshold, gain bonus Attack, Attack Speed, and Evasion (based on level). Increases with each stack (maximum stacks: 10). Critical Hit bonus cannot be stacked. The curse disappears when health is restored.\nCan only be activated once in battle\n"
				)
			19: 
				main_icon = load("res://img/Base Card/Separate_buff/19.png")
				desc_header = "Grim Reaper"
				desc_body = str("When health = 0, activate Grim Reaper's Death Curse, surviving with 1 health when attacked (stacks depend on level). The curse decreases when attacked or at the start of the turn.\n")
			63:
				main_icon = load("res://img/Base Card/Separate_buff/63.png")
				desc_header = "Defense Penetration"
				desc_body = str("[Permanent Buff] Each attack ignores 50% of the enemy's defense points.")
			64:
				main_icon = load("res://img/Base Card/Separate_buff/64.png")
				desc_header = "Focus"
				desc_body = str("[Permanent Buff] Ignores enemy taunt effects.")
			65:
				main_icon = load("res://img/Base Card/Separate_buff/65.png")
				desc_header = "Taunt"
				desc_body = str("[Permanent Buff] Enemies will consistently focus on attacking whoever has this buff, ignoring all other opponents.")
			66:
				main_icon = load("res://img/Base Card/Separate_buff/66.png")
				desc_header = "Perfect Defense"
				desc_body = str("[Permanent buff] Immune to defense reduction debuff")
			67:
				main_icon = load("res://img/Base Card/Separate_buff/67.png")
				desc_header = "Happiness"
				desc_body = str("[Permanent buff] Immune to Weakening debuff")
			68:
				main_icon = load("res://img/Base Card/Separate_buff/68.png")
				desc_header = "Fire Fighter"
				desc_body = str("[Permanent buff] Immune to Burn debuff debuff")
			69:
				main_icon = load("res://img/Base Card/Separate_buff/69.png")
				desc_header = "Antidote"
				desc_body = str("[Permanent buff] Immune to Poison debuff debuff")
			70:
				main_icon = load("res://img/Base Card/Separate_buff/70.png")
				desc_header = "Last Cursed"
				desc_body = str("[Permanent cursed] Upon defeat, grants 2x random blue buffs to remaining allies")
			71:
				main_icon = load("res://img/Base Card/Separate_buff/71.png")
				desc_header = "Soul Cursed"
				desc_body = str("[Permanent cursed] When health reaches a certain threshold, the inherent curse will activate, granting a specific blue buff. Only activated 1 time")
			72:
				main_icon = load("res://img/Base Card/Separate_buff/72.png")
				desc_header = "Reflect heal"
				desc_body = str("[Permanent heal] Each time attacked, heals the teammate with the lowest health")
			73:
				main_icon = load("res://img/Base Card/Separate_buff/73.png")
				desc_header = "Reflect Burn"
				desc_body = str("[Permanent counter] Each attacked applies burn to enemy, with random stacks amount (1-5 stacks)")
			74:
				main_icon = load("res://img/Base Card/Separate_buff/74.png")
				desc_header = "Toxic Armor"
				desc_body = str("[Permanent counter] Each attacked applies poison to enemy, with random stacks amount (3-6 stacks)")
			75:
				main_icon = load("res://img/Base Card/Separate_buff/75.png")
				desc_header = "Reflect Attack"
				desc_body = str("[Permanent counter] Each incoming attack deals 20% of the total damage back to the attacker")
			78:
				main_icon = load("res://img/Base Card/Separate_buff/78.png")
				desc_header = "Reflect Cooldown"
				desc_body = str("Each time an attack is received, self-cooldown is reduced. The amount of cooldown reduction depends on the level of the set owned.")
			79:
				main_icon = load("res://img/Base Card/Separate_buff/79.png")
				desc_header = "Stun"
				desc_body = str("When inflicted with a stun debuff, the user's turn will be skipped. The stun duration decreases by 1 turn after each enemy or ally turn ends. Maximum stacks: 15")
			80:
				main_icon = load("res://img/Base Card/Separate_buff/80.png")
				desc_header = "A Mimir"
				desc_body = str("Enemies inflicted with the [A Mimir] debuff will permanently lose their turn unless hit by an enemy. Additionally, there is a 15% chance to remove this debuff(all ally) at the end of each ally's turn.")
			_:
				print("ada yang salah (DESC)")
				return
		own_texture_rect.texture = main_icon
		
		# BUFF DESC
		var vbox_0 = VBoxContainer.new()
		var hbox_0 = HBoxContainer.new()
		var main_body = Label.new()
		var header_icon = TextureRect.new()
		var header_desc = Label.new()
		var header_desc_level = Label.new()
		
		main_vbox.add_child(vbox_0)
		vbox_0.add_child(hbox_0)
		vbox_0.add_child(main_body)
		vbox_0.add_child(header_desc_level)
		hbox_0.add_child(header_icon)
		hbox_0.add_child(header_desc)
		
		header_icon.texture = main_icon
		header_desc.text = str(desc_header)
		main_body.text = str(desc_body)
		header_desc_level.modulate = Color.DEEP_SKY_BLUE
		
		var font_head = load("res://Themes/Font_Header.tres")
		var font_body = load("res://Themes/Font_Body.tres")
		header_desc.theme = font_head
		main_body.theme = font_body
		header_desc_level.theme = font_body
		main_body.autowrap_mode = TextServer.AUTOWRAP_WORD
		header_desc_level.autowrap_mode = TextServer.AUTOWRAP_WORD
		
		# Store unique name to del node then (DESC)
		match code:
			0: vbox_0.name = "Node_icon_counter_attack"
			1: 
				vbox_0.name = "Node_icon_evation"
				header_desc_level.name = "get_evation_desc"
				header_desc_level.text = _evation_desc
			2: 
				vbox_0.name = "Node_icon_dec_deff"
				header_desc_level.name = "get_def_dec_desc"
			3: 
				vbox_0.name = "Node_icon_lock_skill"
				header_desc_level.name = "get_lock_skill_desc"
			4: 
				vbox_0.name = "Node_icon_weakening"
				header_desc_level.name = "get_weak_desc"
			5: 
				vbox_0.name = "Node_icon_desc_burnt"
				header_desc_level.name = "get_burnt_desc"
			6: 
				vbox_0.name = "Node_icon_poison"
				header_desc_level.name = "get_poison_desc"
			7: 
				vbox_0.name = "Node_heal"
				header_desc_level.name = "get_heal_desc"
				header_desc_level.text = _heal_desc
			8: 
				vbox_0.name = "Node_icon_vampire"
				header_desc_level.name = "get_vamp_desc"
				header_desc_level.text = _vampire_desc
			9: 
				vbox_0.name = "Node_icon_echo_shield"
				header_desc_level.name = "get_echo_desc"
				header_desc_level.text = _echo_shield_desc
			10: 
				vbox_0.name = "Node_icon_crit_dmg"
				header_desc_level.name = "get_crit_dmg_desc"
				header_desc_level.text = _crit_dmg_desc
			11: 
				vbox_0.name = "Node_icon_crit_rate"
				header_desc_level.name = "get_crit_rate_desc"
				header_desc_level.text = _crit_rate_desc
			12: 
				vbox_0.name = "Node_icon_turn_speed"
				header_desc_level.name = "get_turn_speed_desc"
				header_desc_level.text = str(_turn_speed_desc)
			13: 
				vbox_0.name = "Node_icon_deff"
				header_desc_level.name = "get_deff_desc"
				header_desc_level.text = _defense_up_desc
			14: 
				vbox_0.name = "Node_icon_speed_attack"
				header_desc_level.name = "get_speed_attack_desc"
				header_desc_level.text = _speed_attack_desc
			15: 
				vbox_0.name = "Node_icon_attk_up"
				header_desc_level.name = "get_attack_up_desc"
				header_desc_level.text = _attack_up_desc
			16:
				vbox_0.name = "Node_more_time"
				header_desc_level.name = "get_more_time_desc"
			17:
				vbox_0.name = "Node_more_rebirth"
				header_desc_level.name = "get_rebith_desc"
			18: 
				vbox_0.name = "Node_icon_rage"
				header_desc_level.text = _rage_desc
			19: vbox_0.name = "Node_grim"
			63:
				vbox_0.name = "Node_defpen"
				header_desc_level.name = "get_defpen_desc"
			64:
				vbox_0.name = "Node_anti_taunt"
				header_desc_level.name = "get_anti_taunt_desc"
			65:
				vbox_0.name = "Node_taunt"
				header_desc_level.name = "get_taunt_desc"
			66:
				vbox_0.name = "Node_perfectdef"
				header_desc_level.name = "get_perfectdef_desc"
			66:
				vbox_0.name = "Node_happy"
				header_desc_level.name = "get_happy_desc"
			68:
				vbox_0.name = "Node_anti_burn"
				header_desc_level.name = "get_anti_burn_desc"
			69:
				vbox_0.name = "Node_anti_poison"
				header_desc_level.name = "get_anti_poison_desc"
			70:
				vbox_0.name = "Node_lastcursed"
				header_desc_level.name = "get_lastcursed_desc"
			71:
				vbox_0.name = "Node_oneshot"
				header_desc_level.name = "get_oneshot_desc"
			72:
				vbox_0.name = "Node_infiheal"
				header_desc_level.name = "get_infiheal_desc"
			73: 
				vbox_0.name = "Node_ref_burn"
				header_desc_level.name = "get_ref_burn_desc"
			74: 
				vbox_0.name = "Node_ref_poison"
				header_desc_level.name = "get_ref_poison_desc"
			75: 
				vbox_0.name = "Node_ref_attack"
				header_desc_level.name = "get_ref_attack_desc"
			78: 
				vbox_0.name = "Node_refcd_dec"
				header_desc_level.name = "get_refcd_dec"
			79: 
				vbox_0.name = "Node_stun"
				header_desc_level.name = "get_stun_desc"
			80: 
				vbox_0.name = "Node_amimir"
				header_desc_level.name = "get_amimir_desc"
	
		# Create a label to display the counter in first activated
		var label = Label.new()
		label.name = "counter_label"
		match code:
			0: label.text = str(_counter_attack_count)
			1: label.text = str(_evation_count)
			2: label.text = str(_defense_breaker_count)
			3: label.text = str(skill_lock_count)
			4: label.text = str(_weakaning_count)
			5: label.text = str(_burn_count)
			6: label.text = str(_poison_count)
			7: label.text = str(_heal_count)
			8: label.text = str(_vampire_count)
			9: label.text = str(_echo_shiled_count)
			10: label.text = str(5)
			11: label.text = str(5)
			12: label.text = str(5)
			13: label.text = str(5)
			14: label.text = str(5)
			15: label.text = str(5)
			18: label.text = str(_rage_count)
			19: label.text = str("")
			78: label.text = str(skill_refcd_dec_count)
			79: label.text = str(skill_stun_enemy_count)
			_: label.text = "" 
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
		var theme = load("res://Themes/Font_buff_counter.tres")
		label.theme = theme
		own_texture_rect.add_child(label)
		icon_dict[code] = { "icon": own_texture_rect}
	update_desc(code)

func update_desc(code):
	var code_node: String
	var code_desc: String
	match code:
		1:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_evation/get_evation_desc"
			code_desc = str(_evation_desc)
		2:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_dec_deff/get_def_dec_desc"
			code_desc = str(_defense_breaker_desc)
		3:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_lock_skill/get_lock_skill_desc"
			code_desc = str("Only can using skill 0")
		4:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_weakening/get_weak_desc"
			code_desc = str(_weakening_desc)
		5:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_desc_burnt/get_burnt_desc"
			code_desc = str("1-10 stacks: take (2% of max HP) damages\n11-20 stacks: take (5% of max HP) damages\n20++ stacks: take (10% of max HP) damages")
		6:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_poison/get_poison_desc"
			code_desc = str("Health condition 100%: poison damage 5.000\nHealth more then 80%: poison damage 20.000\nHealth more then 60%: poison damage 50.000\nHealth more then 20%: poison damage 100.000\nHealth more then 5%: poison damage150.000\nHealth less then 5%: poison damage 300.000")
		7:
			code_node = "Main_desc/Scroll/Main_vbox/Node_heal/get_heal_desc"
			code_desc = str(_heal_desc)
		8:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_vampire/get_vamp_desc"
			code_desc = str(_vampire_desc)
		9:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_echo_shield/get_echo_desc"
			code_desc = str(_echo_shield_desc)
		10:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_crit_dmg/get_crit_dmg_desc"
			code_desc = str(_crit_dmg_desc)
		11:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_crit_rate/get_crit_rate_desc"
			code_desc = str(_crit_rate_desc)
		12: 
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_turn_speed/get_turn_speed_desc"
			code_desc = str(_turn_speed_desc)
		13:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_deff/get_deff_desc"
			code_desc = str(_defense_up_desc)
		14:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_speed_attack/get_speed_attack_desc"
			code_desc = str(_speed_attack_desc)
		15:
			code_node = "Main_desc/Scroll/Main_vbox/Node_icon_attk_up/get_attack_up_desc"
			code_desc = str(_attack_up_desc)
		16:
			code_node = "Main_desc/Scroll/Main_vbox/Node_more_time/get_more_time_desc"
			code_desc = str("Next turn is doublle")
		17:
			code_node = "Main_desc/Scroll/Main_vbox/Node_more_rebirth/get_rebith_desc"
			code_desc = str("Waiting before rebirth: ",skill_until_rebirth_count," turn")
		63:
			code_node = "Main_desc/Scroll/Main_vbox/Node_defpen/get_defpen_desc"
			code_desc = str("100% Ignored some enemy defense")
		64:
			code_node = "Main_desc/Scroll/Main_vbox/Node_anti_taunt/get_anti_taunt_desc"
			code_desc = str("100% Can ignored enemy Taunted")
		65:
			code_node = "Main_desc/Scroll/Main_vbox/Node_taunt/get_taunt_desc"
			code_desc = str("100% Taunt all enemy attack")
		66:
			code_node = "Main_desc/Scroll/Main_vbox/Node_perfectdef/get_perfectdef_desc"
			code_desc = str("100% Immune to Defense Breaker")
		67:
			code_node = "Main_desc/Scroll/Main_vbox/Node_happy/get_happy_desc"
			code_desc = str("100% Immune to Weakening. uwu")
		68:
			code_node = "Main_desc/Scroll/Main_vbox/Node_anti_burn/get_anti_burn_desc"
			code_desc = str("100% Immune to Burn")
		69:
			code_node = "Main_desc/Scroll/Main_vbox/Node_anti_poison/get_anti_poison_desc"
			code_desc = str("100% Immune to Poison")
		70:
			code_node = "Main_desc/Scroll/Main_vbox/Node_anti_poison/get_anti_poison_desc"
			code_desc = str("After die: 2x random bluebuff to survived ally")
		71:
			code_node = "Main_desc/Scroll/Main_vbox/Node_oneshot/get_oneshot_desc"
			code_desc = str(skill_oneshot_main_desc)
		72:
			code_node = "Main_desc/Scroll/Main_vbox/Node_infiheal/get_infiheal_desc"
			code_desc = str("Total heal: ", get_pct(_default_hp,2))
		73:
			code_node = "Main_desc/Scroll/Main_vbox/Node_ref_burn/get_ref_burn_desc"
			code_desc = str("Chance: ",skill_reflect_burn_pct,"%")
		74:
			code_node = "Main_desc/Scroll/Main_vbox/Node_ref_poison/get_ref_poison_desc"
			code_desc = str("Chance: ",skill_reflect_poison_pct,"%")
		75:
			code_node = "Main_desc/Scroll/Main_vbox/Node_ref_attack/get_ref_attack_desc"
			code_desc = str("Chance: 100% to counter with: ",skill_ref_attack_desc," damages.")
		78:
			code_node = "Main_desc/Scroll/Main_vbox/Node_refcd_dec/get_refcd_dec"
			code_desc = str(skill_refcd_dec_desc)
		79:
			code_node = "Main_desc/Scroll/Main_vbox/Node_stun/get_stun_desc"
			code_desc = str("Skip own turn")
		80:
			code_node = "Main_desc/Scroll/Main_vbox/Node_amimir/get_amimir_desc"
			code_desc = str("zzzzzzz.......")
			
	#var get_node_desc = get_node(code_node)
	var get_node_desc
	if has_node(code_node):
		get_node_desc = get_node(code_node)
		get_node_desc.text = str(code_desc)
	else:
		print("Error: Node with path '" + str(code_node) + "' does not exist.")
	
# After enemy attack than reduce debuff durations by turn
func remove_buff(code):
	if icon_dict.has(code):
		var icon_data = icon_dict[code]
		icon_dict.erase(code)
		search_node_to_del(code)
		update_icon_counter(icon_data)

func search_node_to_del(code):
	var code_name_0:String = ""
	var code_name_1:String = ""
	match code:
		0:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_counter_attack"
			code_name_1 = "main_buff/icon_counter_attack"
		1:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_evation"
			code_name_1 = "main_buff/icon_evation"
		2: 
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_dec_deff"
			code_name_1 = "main_buff/icon_dec_deff"
		3: 
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_lock_skill"
			code_name_1 = "main_buff/icon_lock_skill"
		4:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_weakening"
			code_name_1 = "main_buff/icon_weakening"
		5:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_desc_burnt"
			code_name_1 = "main_buff/icon_burnt"
		6:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_poison"
			code_name_1 = "main_buff/icon_poison"
		7:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_heal"
			code_name_1 = "main_buff/icon_heal"
		8:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_vampire"
			code_name_1 = "main_buff/icon_vampire"
		9:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_echo_shield"
			code_name_1 = "main_buff/icon_echo_shield"
		10:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_crit_dmg"
			code_name_1 = "main_buff/icon_crit_dmg"
		11:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_crit_rate"
			code_name_1 = "main_buff/icon_crit_rate"
		12:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_turn_speed"
			code_name_1 = "main_buff/icon_turn_speed"
		13:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_deff"
			code_name_1 = "main_buff/icon_deff"
		14:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_speed_attack"
			code_name_1 = "main_buff/icon_attk_spd"
		15:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_attk_up"
			code_name_1 = "main_buff/icon_attk_up"
		16:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_more_time"
			code_name_1 = "main_buff/icon_more_turn"
		17:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_more_rebirth"
			code_name_1 = "main_buff/icon_rebirth"
		18:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_icon_rage"
			code_name_1 = "main_buff/icon_rage"
		19:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_grim"
			code_name_1 = "main_buff/icon_grim"
		78:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_refcd_dec"
			code_name_1 = "main_buff/icon_refcd_dec"
		79:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_stun"
			code_name_1 = "main_buff/icon_stun"
		80:
			code_name_0 = "Main_desc/Scroll/Main_vbox/Node_amimir"
			code_name_1 = "main_buff/icon_amimir"
	var get_node_to_del_desc = get_node(code_name_0)
	var get_node_to_del_icon = get_node(code_name_1)
	if get_node_to_del_desc:
		get_node_to_del_desc.queue_free()
	else:
		pass
	if get_node_to_del_icon:
		get_node_to_del_icon.queue_free()

# contoh: 100, 20%-nya brp?
func get_pct(value, pct):
	return (value * pct) / 100
#contoh 10, brp persen dari 100?
func set_pct(value_ask, target_to_pct):
	if target_to_pct == 0:
		return 0
	return int((float(value_ask) / target_to_pct) * 100)

func get_random_int(rand_min: int, rand_max: int) -> int:
	return randi_range(rand_min, rand_max)

func mainFrame_change(code):
	var filter_code = clamp(code, 0, 5)
	var _getnode:Sprite2D = $main_frame
	_getnode.frame=filter_code
	
enum STAT_LIMIT {TURN_SPEED, CRIT_RATE, CRIT_DMG, SPD_ATK, EVA, CRIT_DEFF, ATTACK, DEFENSE}
func stat_limit(value, code:STAT_LIMIT):
	var limit_max
	var stat
	if code == STAT_LIMIT.TURN_SPEED:
		limit_max = basic_stat.max_turn_speed
		stat = get_speed
	elif code == STAT_LIMIT.CRIT_RATE:
		limit_max = basic_stat.max_crit_rate
		stat = get_crit_rate
	elif code == STAT_LIMIT.CRIT_DMG:
		limit_max = basic_stat.max_crit_dmg
		stat = get_crit_dmg
	elif code == STAT_LIMIT.SPD_ATK:
		limit_max = basic_stat.max_speed_attack
		stat = get_speed_atk
	elif code == STAT_LIMIT.EVA:
		limit_max = basic_stat.max_evation
		stat = get_evation
	elif code == STAT_LIMIT.CRIT_DEFF:
		limit_max = basic_stat.max_crit_def
		stat = get_crit_deff
	elif code == STAT_LIMIT.ATTACK:
		limit_max = basic_stat.max_attack
		stat = _default_atk
	elif code == STAT_LIMIT.DEFENSE:
		limit_max = basic_stat.max_defense
		stat = get_deffense
	else: print("ERROR FUNC: STAT LIMIT")
	
	var main_sim = stat + value
	if main_sim < limit_max:
		if code == STAT_LIMIT.TURN_SPEED: stat_speed(value)
		elif code == STAT_LIMIT.CRIT_RATE: stat_crit_rate(value)
		elif code == STAT_LIMIT.CRIT_DMG: stat_crit_dmg(value)
		elif code == STAT_LIMIT.SPD_ATK: stat_speed_atk(value)
		elif code == STAT_LIMIT.EVA: stat_evation(value)
		elif code == STAT_LIMIT.CRIT_DEFF: stat_crit_deff(value)
		elif code == STAT_LIMIT.ATTACK: stat_attack(value)
		elif code == STAT_LIMIT.DEFENSE: stat_deffense(value)
		return value
	elif main_sim > limit_max:
		var temp = 0
		if stat < limit_max:
			temp = limit_max - stat
			if value - temp >0:
				if code == STAT_LIMIT.TURN_SPEED: stat_speed(temp)
				elif code == STAT_LIMIT.CRIT_RATE: stat_crit_rate(temp)
				elif code == STAT_LIMIT.CRIT_DMG: stat_crit_dmg(temp)
				elif code == STAT_LIMIT.SPD_ATK: stat_speed_atk(temp)
				elif code == STAT_LIMIT.EVA: stat_evation(temp)
				elif code == STAT_LIMIT.CRIT_DEFF: stat_crit_deff(temp)
				elif code == STAT_LIMIT.ATTACK: stat_attack(temp)
				elif code == STAT_LIMIT.DEFENSE: stat_deffense(temp)
				return temp
			elif value - temp <0:
				if code == STAT_LIMIT.TURN_SPEED: stat_speed(value)
				elif code == STAT_LIMIT.CRIT_RATE: stat_crit_rate(value)
				elif code == STAT_LIMIT.CRIT_DMG: stat_crit_dmg(value)
				elif code == STAT_LIMIT.SPD_ATK: stat_speed_atk(value)
				elif code == STAT_LIMIT.EVA: stat_evation(value)
				elif code == STAT_LIMIT.CRIT_DEFF: stat_crit_deff(value)
				elif code == STAT_LIMIT.ATTACK: stat_attack(value)
				elif code == STAT_LIMIT.DEFENSE: stat_deffense(value)
				return value
		elif stat >= 500:
			if code == STAT_LIMIT.TURN_SPEED: set_fdmg("Turn Speed have MAX Power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.CRIT_RATE: set_fdmg("Crit Rate have MAX Power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.CRIT_DMG: set_fdmg("Crit Damage have MAX Power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.SPD_ATK: set_fdmg("Speed Attack have MAX Power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.EVA: set_fdmg("Evation have MAX Power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.CRIT_DEFF: set_fdmg("Critical Hit Defense have MAX Power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.ATTACK: set_fdmg("Attack have MAX power", STAT_DMG.BUFF)
			elif code == STAT_LIMIT.DEFENSE: set_fdmg("Defense have MAX power", STAT_DMG.BUFF)
			return 0
		else: print("ERROR LINE: 602")
	else: print("ERROR LINE: 603")

func filter_num_titik(_value: int) -> String:
	var num_str = str(abs(_value))
	var result = "-" if _value < 0 else ""
	
	var reversed_str = num_str.reverse()
	var chunks = []
	for i in range(0, reversed_str.length(), 3):
		chunks.append(reversed_str.substr(i, 3))
	
	# Menggabungkan menggunakan String.join()
	result += String(".").join(chunks).reverse()
	return result

func filter_num_k(value: int) -> String:
	if value >= 1000000000000000: # Quadrillion (Qa)
		return "%.2fQa" % (value / 1000000000000000.0)
	elif value >= 1000000000000: # Trillion (T)
		return "%.2fT" % (value / 1000000000000.0)
	elif value >= 1000000000: # Billion (B)
		return "%.2fB" % (value / 1000000000.0)
	elif value >= 1000000: # Million (M)
		return "%.2fM" % (value / 1000000.0)
	elif value >= 1000: # Thousand (K)
		return "%.2fK" % (value / 1000.0) # Memastikan angka tetap dua desimal
	return str(value)



func _color_desc(value_0, value_1, _link):
	# Check if _link is a valid object with modulate property
	if _link == null:
		return
	if not _link.has_method("set_modulate"):
		return

	# Ensure value_0 and value_1 are numbers
	if typeof(value_0) != TYPE_INT and typeof(value_0) != TYPE_FLOAT:
		return
	if typeof(value_1) != TYPE_INT and typeof(value_1) != TYPE_FLOAT:
		return

	# Compare values and set modulate color accordingly
	if value_0 > value_1:
		_link.modulate = Color(1.0, 0.5, 0.5)  # Equivalent to CRIMSON
	elif value_0 < value_1:
		_link.modulate = Color(0.196, 0.804, 0.196)  # Equivalent to LIME_GREEN
	else:
		_link.modulate = Color(0.678, 0.847, 0.902)  # Equivalent to LIGHT_BLUE

func _update_label():
	var attk = filter_num_titik(get_attack)
	$main_frame/LABEL_ATTACK.text = filter_num_k(get_attack)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/atk_value.text = attk
	_color_desc(_default_atk, get_attack, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/atk_value)
	var deff = filter_num_titik(get_deffense)
	$main_frame/LABEL_DEFFENSE.text = filter_num_k(get_deffense)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/defense_value.text = deff
	_color_desc(_default_deff, get_deffense, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/defense_value)
	var hp = filter_num_titik(get_health)
	$main_frame/LABEL_HEALTH.text = filter_num_k(get_health)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/health_value.text = hp
	_color_desc(_default_hp, get_health, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/health_value)
	var spd = str(get_speed)
	$main_frame/LABEL_SPEED.text = filter_num_k(get_speed)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/turn_spd_value.text = spd
	_color_desc(_default_spd, get_speed, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/turn_spd_value)
	var cst = str(get_cost)
	$main_frame/LABEL_COST.text = cst
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/cost_value.text = cst
	_color_desc(_default_cst, get_cost, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/cost_value)
	
	var eva = str(get_evation)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/eva_value.text = eva
	_color_desc(_default_evation, get_evation, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/eva_value)
	var c_rate = str(get_crit_rate,"%")
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/c_rate_value.text = c_rate 
	_color_desc(_default_crit_rate, get_crit_rate, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/c_rate_value)
	var c_dmg = str(get_crit_dmg,"%")
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/c_dmg_value.text = c_dmg
	_color_desc(_default_crit_dmg, get_crit_dmg, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/c_dmg_value)
	var c_deff = str(get_crit_deff,"%")
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/c_deff_value.text = c_deff
	_color_desc(_default_crit_deff, get_crit_deff, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/c_deff_value)
	var spd_atk = str(get_speed_atk)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/spd_atk.text = spd_atk
	_color_desc(_default_speed_atk, get_speed_atk, $Class_desc/ScrollContainer/class_desc_vbox_0/eva/VBoxContainer2/spd_atk)
	bar_hpdef()
	total_power()

var skill_0_debuff_confirm = false
var skill_1_debuff_confirm = false
var skill_2_debuff_confirm = false
var skill_3_debuff_confirm = false
func default_debuff_confrim(skill_0, skill_1, skill_2, skill_3):
	var all_debuff_code = [2, 3, 4, 5, 6]
	if skill_0 in all_debuff_code: skill_0_debuff_confirm = true
	if skill_1 in all_debuff_code: skill_1_debuff_confirm = true
	if skill_2 in all_debuff_code: skill_2_debuff_confirm = true
	if skill_3 in all_debuff_code: skill_3_debuff_confirm = true

func _default_stat_started():
	_default_stat_bool = false
	_default_atk = get_attack
	_default_deff = get_deffense
	_default_hp = get_health
	_default_spd = get_speed
	_default_cst = get_cost
	_default_crit_rate = get_crit_rate
	_default_crit_dmg = get_crit_dmg
	_default_evation = get_evation
	_default_speed_atk = get_speed_atk
	_default_crit_deff = get_crit_deff
	
	get_bar_hp = _default_hp
	get_bar_def = _default_deff
	
	_heatlh_limit = _default_hp
	
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_atk.text = str(filter_num_titik(_default_atk))
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_deff.text = str(filter_num_titik(_default_deff))
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_hp.text = str(filter_num_titik(_default_hp))
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_turn_spd.text = str(_default_spd)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_cst.text = str(_default_cst)
	
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_eva.text = str(_default_evation)
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_c_rate.text = str(_default_crit_rate,"%")
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_c_dmg.text = str(_default_crit_dmg,"%")
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_c_deff.text = str(_default_crit_deff,"%")
	$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_spd_atk.text = str(_default_speed_atk)
	_update_label()

func set_gearset_stat(get_card_code):
	if card_type_confirm == "hero" and card_code != null and AutoloadData.player_equiped.has(get_card_code):
		var data_equiped: Dictionary = AutoloadData.player_equiped[get_card_code]
		print(data_equiped)

		var stat_function_map = {
			0: stat_attack,
			1: stat_deffense,
			2: stat_health,
			3: stat_speed,
			5: stat_evation,
			6: stat_crit_rate,
			7: stat_crit_dmg,
			8: stat_crit_deff,
			9: stat_speed_atk,
		}

		for key in data_equiped.keys():
			if stat_function_map.has(key):
				stat_function_map[key].call(data_equiped[key])


var _default_stat_bool = true
func _default_stat():
	_update_label()
	if _default_stat_bool:
		_default_stat_bool = false
		_default_atk = get_attack
		_default_deff = get_deffense
		_default_hp = get_health
		_default_spd = get_speed
		_default_cst = get_cost
		_default_crit_rate = get_crit_rate
		_default_crit_dmg = get_crit_dmg
		_default_evation = get_evation
		_default_speed_atk = get_speed_atk
		_default_crit_deff = get_crit_deff
		
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_atk.text = str(filter_num_titik(_default_atk))
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_deff.text = str(filter_num_titik(_default_deff))
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_hp.text = str(filter_num_titik(_default_hp))
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_turn_spd.text = str(_default_spd)
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_cst.text = str(_default_cst)
		
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_eva.text = str(_default_evation)
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_c_rate.text = str(_default_crit_rate,"%")
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_c_dmg.text = str(_default_crit_dmg,"%")
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_c_deff.text = str(_default_crit_deff,"%")
		$Class_desc/ScrollContainer/class_desc_vbox_0/eva/default_stat/default_spd_atk.text = str(_default_speed_atk)

func _default_custom_rank(stat, value: int):
	if stat == ENUM_CUSTOM_RANK.ATTACKER:
		if value == ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV1:
			stat_attack(get_pct(_default_atk, 20))
			stat_health(get_pct(_default_hp, 10))
			stat_deffense(get_pct(_default_deff, 10))
		elif value == ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV2:
			stat_attack(get_pct(_default_atk, 30))
			stat_health(get_pct(_default_hp, 5))
			stat_deffense(get_pct(_default_deff, 5))
		elif value == ENUM_CUSTOM_RANK_LEVEL.ATTACKER_LV3:
			stat_attack(get_pct(_default_atk, 40))
	if stat == ENUM_CUSTOM_RANK.AGILITY:
		if value == ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV1:
			stat_crit_rate(5)
			stat_crit_dmg(50)
			stat_speed(20)
		elif value == ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV2:
			stat_crit_rate(10)
			stat_crit_dmg(30)
			stat_speed(10)
		elif value == ENUM_CUSTOM_RANK_LEVEL.AGILITY_LV3:
			stat_crit_rate(15)
	if stat == ENUM_CUSTOM_RANK.DEFENDER:
		if value == ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV1:
			stat_health(get_pct(_default_hp, 30))
			stat_deffense(300)
			stat_crit_deff(30)
		elif value == ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV2:
			stat_health(get_pct(_default_hp, 60))
			stat_deffense(150)
			stat_crit_deff(15)
		elif value == ENUM_CUSTOM_RANK_LEVEL.DEFENDER_LV3:
			stat_health(get_pct(_default_hp, 100))
	if stat == ENUM_CUSTOM_RANK.UNIVERSAL:
		if value == ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV1:
			stat_attack(get_pct(_default_atk, 20))
			stat_health(get_pct(_default_hp, 20))
			stat_speed(20)
		elif value == ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV2:
			stat_attack(get_pct(_default_atk, 25))
			stat_health(get_pct(_default_hp, 25))
			stat_speed(25)
		elif value == ENUM_CUSTOM_RANK_LEVEL.UNIVERSAL_LV3:
			stat_attack(get_pct(_default_atk, 30))
			stat_health(get_pct(_default_hp, 30))
			stat_speed(30)

var _hero_elemen
var _hero_job
enum ENUM_CUSTOM_RANK {ATTACKER, AGILITY, DEFENDER, UNIVERSAL}
enum ENUM_CUSTOM_RANK_LEVEL {ATTACKER_LV1, ATTACKER_LV2, ATTACKER_LV3, AGILITY_LV1, AGILITY_LV2, AGILITY_LV3, DEFENDER_LV1, DEFENDER_LV2, DEFENDER_LV3,
UNIVERSAL_LV1, UNIVERSAL_LV2, UNIVERSAL_LV3}
func default_attribute(element, job, rank, mob_name, c_rank_s, c_rank_v):
	$main_frame/LABEL_NAME.text = mob_name
	$element.frame = element
	$class_job.frame = job
	$rank.frame = rank
	get_card_name = $main_frame/LABEL_NAME.text
	own_name = mob_name
	_hero_elemen = element
	_hero_job = job
	_class_job(job, rank) # SET BASIC STAT BASE ON RANK
	_default_stat()
	_default_custom_rank(c_rank_s, c_rank_v)
	
	match job:
		0:
			stat_attack(get_pct(get_attack, 60))
			stat_health(get_pct(get_health, 30))
			stat_deffense(get_pct(get_deffense, 15))
			stat_speed(get_pct(get_speed, 5))
		1:
			stat_attack(get_pct(get_attack, 40))
			stat_health(get_pct(get_health, 5))
			stat_deffense(get_pct(get_deffense, 5))
			stat_speed(get_pct(get_speed, 50))
		2:
			stat_attack(get_pct(get_attack, 5))
			stat_health(get_pct(get_health, 90))
			stat_deffense(get_pct(get_deffense, 150))
			stat_speed(get_pct(get_speed, 5))
		3:
			stat_attack(get_pct(get_attack, 40))
			stat_health(get_pct(get_health, 5))
			stat_deffense(get_pct(get_deffense, 5))
			stat_speed(get_pct(get_speed, 50))
		4:
			stat_attack(get_pct(get_attack, 5))
			stat_health(get_pct(get_health, 100))
			stat_deffense(get_pct(get_deffense, 50))
			stat_speed(get_pct(get_speed, 80))
		5:
			stat_attack(get_pct(get_attack, 25))
			stat_health(get_pct(get_health, 25))
			stat_deffense(get_pct(get_deffense, 25))
			stat_speed(get_pct(get_speed, 25))
		6:
			stat_attack(get_pct(get_attack, 40))
			stat_health(get_pct(get_health, 40))
			stat_deffense(get_pct(get_deffense, 10))
			stat_speed(get_pct(get_speed, 10))
		7:
			stat_attack(get_pct(get_attack, 85))
			stat_health(get_pct(get_health, 5))
			stat_deffense(get_pct(get_deffense, 5))
			stat_speed(get_pct(get_speed, 5))
		8:
			stat_attack(get_pct(get_attack, 5))
			stat_health(get_pct(get_health, 100))
			stat_deffense(get_pct(get_deffense, 100))
			stat_speed(get_pct(get_speed, 5))

	match element:
		0:
			stat_deffense(get_pct(get_deffense, 20))
			stat_speed(get_pct(get_speed, 20))
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element.texture = load("res://img/Icon Jobs/New icon elements/icn_class_light.png")
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element_desc.text = str("Light")
		1: 
			stat_health(get_pct(get_health, 20))
			stat_deffense(get_pct(get_deffense, 20))
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element.texture = load("res://img/Icon Jobs/New icon elements/icn_class_nature.png")
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element_desc.text = str("Nature")
		2:
			stat_attack(get_pct(get_attack, 20))
			stat_deffense(get_pct(get_deffense, 20))
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element.texture = load("res://img/Icon Jobs/New icon elements/icn_class_water.png")
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element_desc.text = str("Water")
		3:
			stat_attack(get_pct(get_attack, 20))
			stat_speed(get_pct(get_speed, 20))
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element.texture = load("res://img/Icon Jobs/New icon elements/icn_class_dark.png")
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element_desc.text = str("Dark")
		4:
			stat_attack(get_pct(get_attack,20))
			stat_health(get_pct(get_health, 20))
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element.texture = load("res://img/Icon Jobs/New icon elements/icn_class_fire.png")
			$Class_desc/ScrollContainer/class_desc_vbox_0/icon_element/icon_element_desc.text = str("Fire")
	
func default_img(img_link):
	$mobs.texture = load(img_link)
# SKILL RESUME 0
func default_desc(desc :String):
	$main_frame/ScrollContainer2/VScrollBar/SKILL_0_DESC.text = desc
func default_skill_0_desc(value_0, value_1, value_2, value_3):
	$main_frame/HBoxContainer/resume_0.texture = load(value_0)
	$main_frame/HBoxContainer/resume_1.texture = load(value_1)
	$main_frame/HBoxContainer/resume_2.texture = load(value_2)
	$main_frame/HBoxContainer/resume_3.texture = load(value_3)

# SKILL RESUME 1
func default_skill_1_desc(desc :String):
	$con_skill_1/VBoxContainer/ScrollContainer/VScrollBar/desc_skill_1.text = desc
func default_skill_1_icon(img_0, img_1):
	$con_skill_1/VBoxContainer/HBoxContainer/resume_0.texture = load(img_0)
	$con_skill_1/VBoxContainer/HBoxContainer/resume_1.texture = load(img_1)
func default_skill_1_icon_2N3(img_0, img_1):
	$con_skill_1/VBoxContainer/HBoxContainer/resume_2.texture = load(img_0)
	$con_skill_1/VBoxContainer/HBoxContainer/resume_3.texture = load(img_1)

# SKILL RESUME 2
func default_skill_2_desc(desc):
	$con_skill_2/VBoxContainer/ScrollContainer/VScrollBar/desc_skill_2.text = desc
func default_skill_2_icon(img_0, img_1):
	$con_skill_2/VBoxContainer/HBoxContainer/resume_0.texture = load(img_0)
	$con_skill_2/VBoxContainer/HBoxContainer/resume_1.texture = load(img_1)
func default_skill_2_icon_2N3(img_0, img_1):
	$con_skill_2/VBoxContainer/HBoxContainer/resume_2.texture = load(img_0)
	$con_skill_2/VBoxContainer/HBoxContainer/resume_3.texture = load(img_1)

# SKILL RESUME ULTI
func default_ulti_desc(desc):
	$con_skill_ulti/VBoxContainer/ScrollContainer/VScrollBar/desc_ulti.text = desc
func default_skill_ulti_icon(img_0, img_1):
	$con_skill_ulti/VBoxContainer/HBoxContainer/resume_0.texture = load(img_0)
	$con_skill_ulti/VBoxContainer/HBoxContainer/resume_1.texture = load(img_1)
func default_skill_ulti_icon_2N3(img_0, img_1):
	$con_skill_ulti/VBoxContainer/HBoxContainer/resume_2.texture = load(img_0)
	$con_skill_ulti/VBoxContainer/HBoxContainer/resume_3.texture = load(img_1)

func default_icon_skill(code_skill, code_stat):
	match code_skill:
		0: ss_skill_basic.frame = code_stat
		1: ss_skill_1.frame = code_stat
		2: ss_skill_2.frame = code_stat
		3: ss_skill_ulti.frame = code_stat
	
func default_skill_target(s0, s1, s2, ulti):
	skill_0_target = s0
	skill_1_target = s1
	skill_2_target = s2
	skill_ulti_target = ulti
	
func default_cooldown(s1, s2, ulti):
	skill_1_cd = s1
	skill_2_cd = s2
	skill_ulti_cd = ulti
	
	$cd_skill_1.frame = skill_1_cd
	$cd_skill_2.frame = skill_2_cd
	$cd_skill_3.frame = skill_ulti_cd
	_set_default_cooldown()

var _default_bool_cooldown = true
func _set_default_cooldown():
	if _default_bool_cooldown:
		_default_bool_cooldown = false
		_default_skill_1_cd = skill_1_cd
		_default_skill_2_cd = skill_2_cd
		_default_skill_ulti_cd = skill_ulti_cd
		
		$con_skill_ulti/VBoxContainer/turn_ulti.text = str("Cooldown: ", _default_skill_ulti_cd, " turn")
		$con_skill_2/VBoxContainer/turn_skill_2.text = str("Cooldown: ", _default_skill_2_cd, " turn")
		$con_skill_1/VBoxContainer/turn_skill_1.text = str("Cooldown: ", _default_skill_1_cd, " turn")
		
#func _update_cd():
	#if skill_1_cd <= 0: skill_1_cd = 0
	#if skill_1_cd >= _default_skill_1_cd: skill_1_cd = _default_skill_1_cd
	#if skill_2_cd <= 0: skill_2_cd = 0
	#if skill_2_cd >= _default_skill_2_cd: skill_2_cd = _default_skill_2_cd
	#if skill_ulti_cd <= 0: skill_ulti_cd = 0
	#if skill_ulti_cd >= _default_skill_ulti_cd: skill_ulti_cd = _default_skill_ulti_cd
	#$cd_skill_1.frame = skill_1_cd
	#$cd_skill_2.frame = skill_2_cd
	#$cd_skill_3.frame = skill_ulti_cd
func _update_cd():
	skill_1_cd = clamp(skill_1_cd, 0, _default_skill_1_cd)
	skill_2_cd = clamp(skill_2_cd, 0, _default_skill_2_cd)
	skill_ulti_cd = clamp(skill_ulti_cd, 0, _default_skill_ulti_cd)
	
	$cd_skill_1.frame = skill_1_cd
	$cd_skill_2.frame = skill_2_cd
	$cd_skill_3.frame = skill_ulti_cd


func skill_cd_increase():
	skill_1_cd += 1
	skill_2_cd += 1
	_update_cd()
	
func skill_cd_decrease():
	skill_1_cd -= 1
	skill_2_cd -= 1
	_update_cd()

func skill_cd_started():
	skill_1_cd = 0
	skill_2_cd = 0
	_update_cd()

func _update_cooldown_icon():
	skill_1_cd -= 1
	skill_2_cd -= 1
	skill_ulti_cd -= 1
	_update_cd()

func get_anim_ulti():
	var ss_anim_ulti: AnimatedSprite2D = $ss_skill_ulti/ss_on_ulti
	var _bool = skill_ulti_cd == 0
	ss_anim_ulti.visible = _bool
	if _bool: ss_anim_ulti.play("blue_energy_0")
	else: ss_anim_ulti.stop()

func acak_icon():
	var skill_basic = get_random_int(0, 5)
	ss_skill_basic.frame = skill_basic
	var skill_1 = get_random_int(6, 11)
	ss_skill_1.frame = skill_1
	var skill_2 = get_random_int(12, 17)
	ss_skill_2 = skill_2
	var skill_ulti = get_random_int(18, 23)
	ss_skill_ulti.frame = skill_ulti

func _class_job(_main_class, _rank):
	# SET ICON
	var icons = [
	"res://img/Icon Class/icn_job_warr.png",
	"res://img/Icon Class/icn_job_arch.png",
	"res://img/Icon Class/icn_job_deff.png",
	"res://img/Icon Class/icn_job_assa.png",
	"res://img/Icon Class/icn_job_supp.png",
	"res://img/Icon Class/icn_job_mech.png",
	"res://img/Icon Class/icn_job_abbys.png",
	"res://img/Icon Class/icn_job_wiz.png",
	"res://img/Icon Class/icn_job_heal.png"
	]
	$Class_desc/ScrollContainer/class_desc_vbox_0/icon_class_con/icon_class.texture = load(icons[_main_class])
	# SET NAME CLASS
	var arr_name = ["Warrior", "Archer", "Tank", "Assasin", "Support", "Mech", "Beast", "Wizzard", "Healer"]
	$Class_desc/ScrollContainer/class_desc_vbox_0/icon_class_con/icon_name.text = str(arr_name[_main_class])
	# SET MAIN ATTR
	var set_attk = [1000, 2000, 4000, 10000, 20000, 50000]
	var set_deff = [100, 200, 300, 500, 700, 3000]
	var set_hp = [5000, 10000, 20000, 50000, 100000, 300000]
	var set_turn_speed = [20, 30, 50, 80, 120, 200]
	var set_cost = [1, 2, 4, 8, 15, 25]
	stat_attack(set_attk[_rank])
	stat_deffense(set_deff[_rank])
	stat_health(set_hp[_rank])
	stat_speed(set_turn_speed[_rank])
	stat_cost(set_cost[_rank])
	# SET SPECIAL ATTR
	var set_eva = [5, 10, 0, 50, 0, 50, 100, 0, 0]
	var set_c_rate = [10, 5, 0, 10, 0, 5, 6, 0, 0]
	var set_c_dmg = [200, 200, 150, 150, 150, 150, 200, 300, 150]
	var set_c_deff = [20, 1, 30, 1, 1, 30, 20, 1, 20]
	var set_spd_atk = [100, 300, 100, 200, 100, 200, 150, 100, 100]
	stat_evation(set_eva[_main_class])
	stat_crit_rate(set_c_rate[_main_class])
	stat_crit_dmg(set_c_dmg[_main_class])
	stat_crit_deff(set_c_deff[_main_class])
	stat_speed_atk(set_spd_atk[_main_class])
	# SET SPECIAL CLASS BUFF DESC
	var set_desc_arr = [
		"Ignored 50% defense enemy when attacking (all skill)", #0
		"Ignored Taunt by enemies", #1
		"Taunt all single attack on enemy" , #2
		"10% chance to activated Critical Damage (Level 1)", #3
		"10% chance inflict enemy debuff poison (Level 1)", #4
		"Immune with Poison", #5
		"10% chance to activated Vampire buff (Level 1)", #6
		"Immune with Burn", #7
		"10% chance to activated Defense Up (Level 1)" #8
	]
	$Class_desc/ScrollContainer/class_desc_vbox_0/full_desc2.text = str("1. ",set_desc_arr[_main_class])
	# SET SPECIAL CLASS BUF
	match _main_class:
		0:_skill_passive_buff(13) # WARR - DEFENSE PENETRATION
		1:_skill_passive_buff(12) # ARC - ANTI TAUNT
		2:_skill_passive_buff(11) # DEF - TAUNT
		3:_skill_passive_buff(0) # ASSA - CRIT DMG BUFF
		4:_skill_passive_debuff(1) # SUPP - POISON DEBUFF
		5:_skill_passive_immune(1) # MECH - IMMUNE POISON
		6:_skill_passive_buff(6) # BEAST - VAMPIRE BUFF
		7:_skill_passive_immune(2) # MAG - IMMUNE BURN
		8:_skill_passive_buff(3) # HEAL - DEFENSE UP BUFF
	
	# ------------------ SPECIAL SKILL 2------------------
	var special_buff_desc={
		0: "10% chance to activated Counter Attack (Level 1)", # COUNTER ATTACK: 0
		1: "10% chance to activated Evation (Level 1)", # EVA: 1
		2: "10% chance to reduce enemy defense (Level 1)", # DEFF BREAK: 2
		3: "",
		4: "10% chance inflict enemy debuff Weakening (Level 1)", # WEAK: 4
		5: "10% chance inflict enemy debuff burn (Level 1)", # BURN: 5
		6: "10% chance inflict enemy debuff poison (Level 1)", # POISON: 6
		7: "10% chance to activated Heal (Level 1)", # HEAL: 7
		8: "10% chance to activated Vampire buff (Level 1)", # VAMP: 8
		9: "10% chance to activated Echo Heal (Level 1)", # ECHO HEAL: 9
		10: "10% chance to activated Critical Damage (Level 1)", # C.DMG: 10
		11: "10% chance to activated Critical Changes (Level 1)", # C.RATE: 11
		12: "10% chance to activated Turn Speed (Level 1)", # TURN SPEED: 12
		13: "10% chance to activated Defense Up (Level 1)", # DEFF UP: 13
		14: "10% chance to activated Speed Attack (Level 1)", # SPEED ATTACK: 14
		15: "10% chance to activated Attack Up (Level 1)", # ATTACK UP: 15
		16: "",
		17: "",
		18: "10% chance trigger cursed Rage (Level 1)", # RAGE: 18
		19: "10% chance trigger cursed Grim Reaper (Level 1)", # GRIM: 19
	}
	var special_immune_desc = {
		0: "Immune with Decrease Defense", # IMMUNE DEF BREAK: 0
		1: "Immune with Weakening", # IMMUNE WEAK: 1
		2: "Immune with Burn", # IMMUNE BURN: 2
		3: "Immune with Poison", # IMMUNE POISON: 3
	}
	
	var special_desc
	if _hero_elemen == 0:
		if _main_class == 0:
			_skill_passive_buff(0)
			special_desc = special_buff_desc[10]
		elif _main_class == 1:
			_skill_passive_buff(7)
			special_desc = special_buff_desc[1]
		elif _main_class == 2:
			_skill_passive_buff(5)
			special_desc = special_buff_desc[15]
		elif _main_class == 3:
			_skill_passive_buff(7)
			special_desc = special_buff_desc[1]
		elif _main_class == 4:
			_skill_passive_buff(8)
			special_desc = special_buff_desc[0]
		elif _main_class == 5:
			_skill_passive_buff(2)
			special_desc = special_buff_desc[12]
		elif _main_class == 6:
			_skill_passive_buff(4)
			special_desc = special_buff_desc[14]
		elif _main_class == 7:
			_skill_passive_buff(4)
			special_desc = special_buff_desc[14]
		elif _main_class == 8:
			_skill_passive_buff(8)
			special_desc = special_buff_desc[0]
	elif _hero_elemen == 1:
		if _main_class == 0:
			_skill_passive_buff(0)
			special_desc = special_buff_desc[10]
		elif _main_class == 1:
			_skill_passive_immune(1)
			special_desc = special_immune_desc[3]
		elif _main_class == 2:
			_skill_passive_buff(3)
			special_desc = special_buff_desc[13]
		elif _main_class == 3:
			_skill_passive_debuff(1)
			special_desc = special_buff_desc[6]
		elif _main_class == 4:
			_skill_passive_immune(3)
			special_desc = special_immune_desc[1]
		elif _main_class == 5:
			_skill_passive_buff(10)
			special_desc = special_immune_desc[9]
		elif _main_class == 6:
			_skill_passive_debuff(1)
			special_desc = special_buff_desc[6]
		elif _main_class == 7:
			_skill_passive_buff(5)
			special_desc = special_buff_desc[15]
		elif _main_class == 8:
			_skill_passive_buff(10)
			special_desc = special_buff_desc[9]
	elif _hero_elemen == 2:
		if _main_class == 0:
			_skill_passive_buff(1)
			special_desc = special_buff_desc[11]
		elif _main_class == 1:
			_skill_passive_buff(5)
			special_desc = special_buff_desc[15]
		elif _main_class == 2:
			_skill_passive_immune(2)
			special_desc = special_immune_desc[2]
		elif _main_class == 3:
			_skill_passive_buff(1)
			special_desc = special_buff_desc[11]
		elif _main_class == 4:
			_skill_passive_immune(2)
			special_desc = special_immune_desc[2]
		elif _main_class == 5:
			_skill_passive_buff(5)
			special_desc = special_buff_desc[15]
		elif _main_class == 6:
			_skill_passive_buff(3)
			special_desc = special_buff_desc[13]
		elif _main_class == 7:
			_skill_passive_buff(1)
			special_desc = special_buff_desc[11]
		elif _main_class == 8:
			_skill_passive_debuff(1)
			special_desc = special_buff_desc[6]
	elif _hero_elemen == 3:
		if _main_class == 0:
			_skill_passive_debuff(4)
			special_desc = special_buff_desc[4]
		elif _main_class == 1:
			_skill_passive_buff(4)
			special_desc = special_buff_desc[14]
		elif _main_class == 2:
			_skill_passive_buff(8)
			special_desc = special_buff_desc[0]
		elif _main_class == 3:
			_skill_passive_immune(3)
			special_desc = special_immune_desc[1]
		elif _main_class == 4:
			_skill_passive_immune(0)
			special_desc = special_immune_desc[0]
		elif _main_class == 5:
			_skill_passive_debuff(4)
			special_desc = special_buff_desc[4]
		elif _main_class == 6:
			_skill_passive_buff(1)
			special_desc = special_buff_desc[11]
		elif _main_class == 7:
			_skill_passive_buff(5)
			special_desc = special_buff_desc[15]
		elif _main_class == 8:
			_skill_passive_buff(8)
			special_desc = special_buff_desc[0]
	elif _hero_elemen == 4:
		if _main_class == 0:
			_skill_passive_debuff(3)
			special_desc = special_buff_desc[5]
		elif _main_class == 1:
			_skill_passive_debuff(3)
			special_desc = special_buff_desc[5]
		elif _main_class == 2:
			_skill_passive_immune(2)
			special_desc = special_immune_desc[2]
		elif _main_class == 3:
			_skill_passive_debuff(3)
			special_desc = special_buff_desc[5]
		elif _main_class == 4:
			_skill_passive_buff(3)
			special_desc = special_buff_desc[13]
		elif _main_class == 5:
			_skill_passive_buff(8)
			special_desc = special_buff_desc[0]
		elif _main_class == 6:
			_skill_passive_buff(3)
			special_desc = special_buff_desc[5]
		elif _main_class == 7:
			_skill_passive_buff(3)
			special_desc = special_buff_desc[5]
		elif _main_class == 8:
			_skill_passive_buff(10)
			special_desc = special_buff_desc[9]
	
	$Class_desc/ScrollContainer/class_desc_vbox_0/full_desc3.text = str("2. ",special_desc)
	
	
var _defense_breaker_immune_bool = true
var _poison_immune_bool = true
var _burn_immune_bool = true
var _weakening_immune_bool = true
func _skill_passive_immune(code):
	match  code:
		0:
			_defense_breaker_immune = true
			if _defense_breaker_immune_bool:
				_defense_breaker_immune = false
				set_icon_buff(66)
		1: 
			_poison_immune = true
			if _poison_immune_bool:
				_poison_immune_bool = false
				set_icon_buff(69)
		2:
			_burn_immune = true
			if _burn_immune_bool:
				_burn_immune_bool = false
				set_icon_buff(68)
		3:
			_weakening_immune = true
			if _weakening_immune_bool:
				_weakening_immune_bool = false
				set_icon_buff(67)
func _skill_passive_debuff(code):
	match code:
		0: _defense_breaker_passive = true
		1: _poison_passive = true
		3: _burn_passive = true
		4: _weakening_passive = true
		
var _defense_taunt = false
var _defense_taunt_bool = true
var _anti_taunt = false
var _anti_taunt_bool = true
var _defense_penetration = false
var _defense_penetration_bool = true
func _skill_passive_buff(code):
	match code:
		0: _crit_dmg_passive = true
		1: _crit_rate_passive = true
		2: _turn_speed_passive = true
		3: _defense_up_passive = true
		4: _speed_attack_passive = true
		5: _attack_up_passive = true
		6: _vampire_passive = true
		7: _evation_passive = true
		8: _counter_attack_passive = true
		9: _heal_passive = true
		10: _echo_shield_passive = true
		11:
			_defense_taunt = true
			if _defense_taunt_bool:
				_defense_taunt_bool = false
				set_icon_buff(65)
		12:
			_anti_taunt = true
			if _anti_taunt_bool:
				_anti_taunt_bool = false
				set_icon_buff(64)
		13:
			_defense_penetration = true
			if _defense_penetration_bool:
				_defense_penetration_bool = false
				set_icon_buff(63)

func default_position(x, y):
	$".".position = Vector2(x, y)
	
func stat_elem_pairs(main_pct):
	stat_attack(get_pct(_default_atk, main_pct))
	stat_health(get_pct(_default_hp, main_pct))
	
func stat_elem_light(main_pct):
	stat_speed(get_pct(_default_spd, main_pct))
	stat_speed_atk(get_pct(_default_speed_atk, main_pct))
func stat_elem_nature(main_pct):
	stat_health(get_pct(_default_hp, main_pct))
	stat_attack(get_pct(_default_atk, main_pct))
func stat_elem_water(main_pct):
	stat_health(get_pct(_default_hp, main_pct))
	stat_crit_deff(main_pct)
func stat_elem_dark(main_pct):
	stat_crit_rate(main_pct)
	stat_evation(get_pct(_default_evation, main_pct))
func stat_elem_fire(main_pct):
	stat_crit_dmg(get_pct(_default_crit_dmg, main_pct)*10)
	stat_crit_rate(main_pct)

func stat_attack(value):
	basic_stat.attack += value
	get_attack = basic_stat.attack
	return _update_label()
	
func stat_deffense(value):
	basic_stat.deffense += value
	get_deffense = basic_stat.deffense
	return _update_label()
	
func stat_health(value):
	basic_stat.health += value
	get_health = basic_stat.health
	return _update_label()
	
func stat_speed(value):
	basic_stat.speed += value
	get_speed = basic_stat.speed
	return _update_label()
	
func stat_cost(value):
	basic_stat.cost += value
	get_cost = basic_stat.cost
	return _update_label()
	
func stat_evation(value):
	basic_stat.evation += value
	get_evation = basic_stat.evation
	_update_label()
	
func stat_crit_rate(value):
	basic_stat.crit_rate += value
	get_crit_rate = basic_stat.crit_rate
	_update_label()

func stat_crit_dmg(value):
	basic_stat.crit_dmg += value
	get_crit_dmg = basic_stat.crit_dmg
	_update_label()
	
func stat_crit_deff(value):
	basic_stat.crit_deff += value
	get_crit_deff = basic_stat.crit_deff
	_update_label()
	
func stat_speed_atk(value):
	basic_stat.speed_atk += value
	get_speed_atk = basic_stat.speed_atk
	_update_label()

# PLAY ANIM SELECT WHEN HAVE THEY TURN
enum ENUM_SELECT_HERO {HERO, ENEMY}
func enable_anim_turn_begin(_enable:bool, _enum:ENUM_SELECT_HERO):
	var main_select: AnimatedSprite2D = $main_frame/main_select
	if _enable:
		main_select.visible = true
		match _enum:
			ENUM_SELECT_HERO.HERO: main_select.play("main_select")
			ENUM_SELECT_HERO.ENEMY: main_select.play("enemy_select")
	elif _enable == false:
		main_select.visible = false
		main_select.stop()

# PLAY ANIM ATTACK AND ATTACKED
func anim_attack(code):
	var get_anim = $anim_player_attak
	match code:
		0: get_anim.play("anim_char_attacked")
		1: get_anim.play("anim_char_attack")

var get_vfx2dhit_scn = preload("res://scenes/Vfx2d.tscn")
func play_vfx2dhit(_elem, _class):
	var get_parent_vfxhit = $mobs  # Pastikan node ini ada
	var vfx_instance = get_vfx2dhit_scn.instantiate()
	get_parent_vfxhit.add_child(vfx_instance)
	# Atur posisi VFX jika diperlukan
	vfx_instance.global_position = global_position
	# Panggil fungsi get_vfxhit pada instance VFX
	vfx_instance.get_vfxhit(_elem, _class)
	# Buat timer untuk menghapus VFX setelah beberapa waktu
	var timer = get_tree().create_timer(1.0)  # Sesuaikan durasi sesuai kebutuhan
	await timer.timeout
	# Hapus instance VFX setelah timer selesai
	if is_instance_valid(vfx_instance): vfx_instance.queue_free()

var hp_dmg_total: int 
enum ELEM{LIGHT=0, NATURE, WATER, DARK, FIRE}
enum JOB{WARR=0, ARC, KNI, ASSA, SUPP, MECH, BEAST, WIZZ, HEAL}

func attack_to(pct_dmg, enemy):
	enemy.play_vfx2dhit(_hero_elemen, _hero_job)
	
	# ----- SKILL AREA PRIORITY -----
	# 07 HEAL
	skill_heal_activated(_heal_level_temp)
	enemy.skill_heal_activated(enemy._heal_level_temp)
	# 40 MULTI COOLDOWN
	skill_multi_cooldown_trigger(enemy)
	
	# HP BEFORE
	var hp_caster_before = get_health
	var hp_enemy_before = enemy.get_health
	var hit_crit = false
	var hit_dodge = false
	var _hp_dmg_befor: int
	var _hp_dmg_after: int
	var _hp_dmg_total: int
	_hp_dmg_befor = enemy.get_health
	
	# ATTACK TEMP
	var final_crit_dmg = get_pct(get_attack, pct_dmg)
	
	# WHEN CRITCAL HIT TRIGGER
	var on_crit = get_random_int(1, 100)
	var enemy_crit_deff = enemy.get_crit_deff
	if on_crit <= get_crit_rate:
		hit_crit = true
		total_crit+=1
		final_crit_dmg = get_pct(final_crit_dmg, get_crit_dmg)
		# CRIT DEFF
		var total_crit_count = final_crit_dmg - get_attack
		var total_crit_reduce = get_pct(total_crit_count, enemy_crit_deff)
		final_crit_dmg -= total_crit_reduce
	
	# ADDITIONAL RANDOM DAMAGE
	var rng_dmg = get_random_int(1, 10)
	final_crit_dmg += get_pct(final_crit_dmg,rng_dmg)
	
	# ELEMEN DMG
	# 0: LIGHT, 1: NATURE, 3: WATER, 4: DARK, 5: FIRE
	var caster_elem = _hero_elemen
	var enemy_elem = enemy._hero_elemen
	var elem_up = get_pct(final_crit_dmg, 30)
	var elem_down = get_pct(-final_crit_dmg, 30)
	
	# LIGHT
	if caster_elem == ELEM.LIGHT: if enemy_elem == ELEM.DARK: final_crit_dmg += elem_up
	# DRAK
	elif caster_elem == ELEM.DARK: if enemy_elem == ELEM.LIGHT: final_crit_dmg += elem_up
	# NATURE
	elif caster_elem == ELEM.NATURE:
		if enemy_elem == ELEM.WATER: final_crit_dmg += elem_up
		elif enemy_elem == ELEM.FIRE: final_crit_dmg += elem_down
	# WATER
	elif caster_elem == ELEM.WATER:
		if enemy_elem == ELEM.FIRE: final_crit_dmg += elem_up
		elif enemy_elem == ELEM.NATURE: final_crit_dmg += elem_down
	# FIRE
	elif caster_elem == ELEM.FIRE:
		if enemy_elem == ELEM.NATURE: final_crit_dmg += elem_up
		elif enemy_elem == ELEM.WATER: final_crit_dmg += elem_down
		
	# SET EVA AND SPEED ATTACK
	#var rng_eva = get_random_int(1, 100)
	#var enemy_eva = enemy.get_evation * 2 / 10
	#var caster_spd_attk = get_speed_atk * 2 / 10
	#var enemy_dodge = enemy_eva - caster_spd_attk
	
	var rng_caster_speed = randi_range(0, get_speed_atk) + get_pct(get_speed_atk, 50)
	var rng_enemy_eva = randi_range(0, enemy.get_evation) + get_pct(enemy.get_evation, 50)
	if rng_enemy_eva > rng_caster_speed:
		final_crit_dmg = 0
		hit_dodge = true
		total_dodge+=1
	
	# REDUCE ENEMY HP (ATTACKING)
	if enemy.get_deffense >= get_pct(basic_stat.max_defense, 90):
		if final_crit_dmg != 0:
			var count = 20
			if _defense_penetration:
				count = 30
				enemy.set_fdmg("Defense Penetration.", STAT_DMG.DEBUFF)
			var dmg = get_pct(final_crit_dmg, count)
			enemy.stat_health(-dmg)
	elif enemy.get_deffense >= get_pct(basic_stat.max_defense, 70):
		if final_crit_dmg != 0:
			var count = 30
			if _defense_penetration:
				count = 45
				enemy.set_fdmg("Defense Penetration.", STAT_DMG.DEBUFF)
			var dmg = get_pct(final_crit_dmg, count)
			enemy.stat_health(-dmg)
	elif enemy.get_deffense >= get_pct(basic_stat.max_defense, 40):
		if final_crit_dmg != 0:
			var count = 40
			if _defense_penetration:
				count = 60
				enemy.set_fdmg("Defense Penetration.", STAT_DMG.DEBUFF)
			var dmg = get_pct(final_crit_dmg, count)
			enemy.stat_health(-dmg)
	elif enemy.get_deffense >= get_pct(basic_stat.max_defense, 20):
		if final_crit_dmg != 0:
			var count = 60
			if _defense_penetration:
				count = 90
				enemy.set_fdmg("Defense Penetration.", STAT_DMG.DEBUFF)
			var dmg = get_pct(final_crit_dmg, count)
			enemy.stat_health(-dmg)
	elif enemy.get_deffense >= get_pct(basic_stat.max_defense, 10):
		if final_crit_dmg != 0:
			var count = 70
			if _defense_penetration:
				count = 100
				enemy.set_fdmg("Defense Penetration.", STAT_DMG.DEBUFF)
			var dmg = get_pct(final_crit_dmg, count)
			enemy.stat_health(-dmg)
	elif enemy.get_deffense >= get_pct(basic_stat.max_defense, 5):
		if final_crit_dmg != 0:
			var count = 90
			if _defense_penetration:
				count = 100
				enemy.set_fdmg("Defense Penetration.", STAT_DMG.DEBUFF)
			var dmg = get_pct(final_crit_dmg, count)
			enemy.stat_health(-dmg)
	else:
		if final_crit_dmg != 0:
			enemy.stat_health(-final_crit_dmg)
	
	# REDUCE DEFENSE
	var enemy_deff_before = enemy.get_deffense
	if final_crit_dmg != 0:
		_hp_dmg_after = enemy.get_health
		_hp_dmg_total = _hp_dmg_befor - _hp_dmg_after
		if _hp_dmg_total == 0: _hp_dmg_total = 1
		hp_dmg_total = _hp_dmg_total
			
		var raw_attack = enemy.get_health - get_attack
		var raw_final_dmg = set_pct(raw_attack, enemy.get_health)
	
		if raw_final_dmg >= 99:
			enemy.stat_deffense(-1)
		elif raw_final_dmg >= 90:
			enemy.stat_deffense(-get_random_int(get_pct(enemy.get_deffense, 1), get_pct(enemy.get_deffense, 5)))
		elif raw_final_dmg >= 70:
			enemy.stat_deffense(-get_random_int(get_pct(enemy.get_deffense, 5), get_pct(enemy.get_deffense, 10)))
		elif raw_final_dmg >= 60:
			enemy.stat_deffense(-get_random_int(get_pct(enemy.get_deffense, 20), get_pct(enemy.get_deffense, 30)))
		elif raw_final_dmg >= 40:
			enemy.stat_deffense(-get_random_int(get_pct(enemy.get_deffense, 40), get_pct(enemy.get_deffense, 60)))
		else:
			enemy.stat_deffense(-get_random_int(get_pct(enemy.get_deffense, 80), get_pct(enemy.get_deffense, 100)))
			
	# FDMG HP
	var hp_enemy_after = enemy.get_health
	var dmg_hp_enemy = hp_enemy_after - hp_enemy_before
	
	if hit_dodge: enemy.set_fdmg("", STAT_DMG.DODGE)
	elif dmg_hp_enemy <0:
		if hit_crit: enemy.set_fdmg(dmg_hp_enemy, STAT_DMG.CRITICAL)
		elif hit_dodge == false and hit_crit == false: enemy.set_fdmg(dmg_hp_enemy, STAT_DMG.HIT)
	elif dmg_hp_enemy >0: enemy.set_fdmg(dmg_hp_enemy, STAT_DMG.HEAL)
	# FDMG DEFENSE
	var enemy_def_after = enemy.get_deffense
	var dmg_def = enemy_def_after - enemy_deff_before
	if dmg_def == 0: pass
	elif dmg_def <0: enemy.set_fdmg(dmg_def, STAT_DMG.DEF_DEC)
	elif dmg_def >0: enemy.set_fdmg(dmg_def, STAT_DMG.DEF_UP)
	
	# -------------------- Skill Confirm -------------------- 
	
	## ---------- ONESHOT ----------
	# 28 ONESHOT CDMG
	skill_oneshot_cdmg_trigger()
	enemy.skill_oneshot_cdmg_trigger()
	# 29 ONESHOT CRATE
	skill_oneshot_crate_trigger()
	enemy.skill_oneshot_crate_trigger()
	# 30 TURN SPEED
	skill_oneshot_turnspeed_trigger()
	enemy.skill_oneshot_turnspeed_trigger()
	# 31 DEFENSE UP
	skill_oneshot_defenseup_trigger()
	enemy.skill_oneshot_defenseup_trigger()
	# 32 SPEED ATTACK
	skill_oneshot_speedattack_trigger()
	enemy.skill_oneshot_speedattack_trigger()
	# 33 ATTACK UP
	skill_oneshot_attackup_trigger()
	enemy.skill_oneshot_attackup_trigger()
	# 34 COUNTER
	skill_oneshot_counter_trigger()
	enemy.skill_oneshot_counter_trigger()
	# 35 EVA
	skill_oneshot_eva_trigger()
	enemy.skill_oneshot_eva_trigger()
	# 36 GRIM
	skill_oneshot_grim_trigger()
	enemy.skill_oneshot_grim_trigger()
	## ---------- ONESHOT ----------
	
	# 0 COUNTER ATTACK
	if _counter_attack_passive: skill_counter_attack_activated(10)
	enemy.skill_counter_attack()
	skill_counter_attack_trigger(enemy, -dmg_hp_enemy)
	enemy.skill_counter_attack_reset()
	# 01 EVATION
	skill_evation()
	enemy.skill_evation()
	if _evation_passive: skill_evation_activated(1, 10)
	# 02 DECREASE DEFENSE
	skill_defense_breaker_trigger(enemy)
	# 03 SKILL LOCK
	skill_lock_trigger(enemy)
	# 04 WEAKENING
	skill_weakening_trigger(enemy)
	# 05 BURN
	skill_reflect_burn_trigger(enemy)
	if _burn_passive: skill_burn_activated(10)
	skill_burn_trigger(enemy)
	# 06 POISON
	skill_reflect_poison_trigger(enemy)
	if _poison_passive: skill_poison_activated(10)
	skill_poison_trigger(enemy)
	# 08 VAMPIRE
	if _vampire_passive: skill_vampire_activated(1, 10)
	skill_vampire_trigger(dmg_hp_enemy)
	# 09 ECHO SHIELD
	if _echo_shield_passive: skill_echo_shield_activated(1, 10)
	skill_echo_shield_trigger(enemy)
	# 10 PASSIVE CRIT DMG
	if _crit_dmg_passive: skill_crit_dmg_activated(1, 10)
	skill_crit_dmg_trigger()
	# 11 PASSIVE CRIT RATE
	if _crit_rate_passive: skill_crit_rate_activated(1, 10)
	skill_crit_rate_trigger()
	# 12 TURN SPEED
	if _turn_speed_passive: skill_turn_speed_activated(1, 10)
	skill_turn_speed_trigger()
	# 13 PASSIVE DEFESNE UP
	if _defense_up_passive: skill_defense_up_activated(1, 10)
	skill_defense_up_trigger()
	# 14 PASSIVE SPEED ATTACK
	if _speed_attack_passive: skill_speed_attack_activated(1, 10)
	skill_speed_aattack_trigger()
	# 15 PASSIVE ATTACKUP
	if _attack_up_passive: skill_attack_up_activated(1, 10)
	skill_attack_up_trigger()
	# 18 RAGE
	skill_rage_trigger()
	enemy.skill_rage_trigger()
	# 19 PASSIVE GRIM
	grim_reaper_trigger()
	enemy.grim_reaper_trigger()
	# 21 TRIGGER REMOVVE BLUE BUFF
	skill_remove_blue_buff_trigger(enemy)
	# 22 TRIGGER REMOVE GREEN BUFF
	skill_remove_green_buff_trigger(enemy)
	# 23 TRIGGER REMOVE GOLD BUFF
	skill_remove_gold_buff_trigger(enemy)
	# 24 INCREASES COOLDOWN
	skill_cd_increase_trigger(enemy)
	# 70 LAST CURSED
	enemy.skill_last_cursed_trigger()
	# 72 INFINITE HEAL
	enemy.skill_infinite_heal_trigger()
	# 75 REFLECT ATTACK
	skill_ref_atttack_trigger(enemy)
	# 78 COOLDOWN DEC
	enemy.skill_refcd_dec_trigger()
	# 79 STUN
	skill_stun_trigger(enemy)
	# AMIMIR
	skill_amimir_trigger(enemy)
	
	# ---------- ANIM & FDMG AREA ----------
	anim_attack(1)
	enemy.anim_attack(0)
	fdmg()
	enemy.fdmg()
	
	# -------------- SLOW MO --------------
	if enemy.get_health == 0: slow_mo()
	# ------------- ANIM ULTI ------------- 
	get_anim_ulti()
	# ------------- BATTLE INFO ------------- 
	var hp_caster_after = get_health
	if hp_enemy_after < hp_enemy_before:
		dmg_dealt+=dmg_hp_enemy
		enemy.dmg_taken+=dmg_hp_enemy
		
		# CURRENT SCORE
		var final_hp_enemy = hp_enemy_after-hp_enemy_before
		if abs(final_hp_enemy)>=25: final_hp_enemy/=25
		if card_type_confirm == "hero" and abs(final_hp_enemy) > 0:
			var battle_scene_node = get_node("/root/Battle_scene")
			var temp_score = battle_scene_node.current_score + abs(final_hp_enemy)
			battle_scene_node.tween_score(temp_score, 1.0)
			battle_scene_node.current_score += abs(final_hp_enemy)
	elif hp_enemy_after > hp_enemy_before:
		var _heal = hp_enemy_after - hp_enemy_before
		enemy.total_heal+=_heal
	if hp_caster_before < hp_caster_after:
		total_heal+=hp_caster_after-hp_caster_before
	elif hp_caster_before > hp_caster_after:
		enemy.dmg_dealt+=hp_caster_before-hp_caster_after
	if get_health == 0:
		elim_by+=str(enemy.own_name,"\n")
		enemy.elim_card+=str(own_name,"\n")
	if enemy.get_health == 0:
		elim_card+=str(enemy.own_name,"\n")
		enemy.elim_by+=str(own_name,"\n")
		elim_card_count+=1
	
# FREEZE TIME
var normal_time_scale = Engine.time_scale
func slow_mo(duration: float = 0.5):
	var slow_mo_scale = 0.1
	Engine.time_scale = slow_mo_scale
	var tween = create_tween()
	tween.tween_property(Engine, "time_scale", normal_time_scale, duration)
	await tween.finished
	Engine.time_scale = normal_time_scale

func total_power():
	var pwr_attack = get_attack * 10
	var pwr_deff = get_deffense * 100
	var pwr_hp = get_health * 2
	var pwr_spd = get_speed * 300
	$main_frame/LABEL_POWER.text = str(filter_num_titik(pwr_attack + pwr_deff + pwr_hp + pwr_spd))
	if get_health == 0:
		$main_frame/LABEL_POWER.text = "0"
	return total_power

# Skill container
@onready var main_desc = $Main_desc
@onready var class_desc = $Class_desc
@onready var btn_stat_menu = $stat_menu

# --- COUPLE
func btn_show_card_info() -> void:
	class_desc.visible = true
	btn_stat_menu.visible=false
	main_desc.visible=false
	SfxManager.play_item_open()
func btn_cls_stat() -> void:
	class_desc.visible = false
	SfxManager.play_item_close()
# --- COUPLE
func btn_show_buff() -> void:
	main_desc.visible=true
	class_desc.visible=false
	btn_stat_menu.visible=false
	SfxManager.play_item_open()
func btn_main_desc_cls() -> void:
	main_desc.visible=false
	SfxManager.play_item_close()
# --- COUPLE
func btn_stat_menu_cls() -> void:
	btn_stat_menu.visible = false
	SfxManager.play_item_close()
func btn_stat_menu_show() -> void:
	btn_stat_menu.visible = true
	class_desc.visible=false
	main_desc.visible=false
	SfxManager.play_item_open()
	disable_all_skill_icon()

# SET MAIN ATTR
func set_main_attr():
	get_attack = basic_stat.attack
	get_deffense = basic_stat.deffense
	get_health = basic_stat.health
	get_speed = basic_stat.speed
	get_cost = basic_stat.cost
	get_crit_rate = basic_stat.crit_rate
	get_crit_dmg = basic_stat.crit_dmg
	get_crit_deff = basic_stat._crit_deff
	get_evation = basic_stat.evation
	get_speed_atk = basic_stat.speed_atk
func set_skill_indic_stat(code_skill, code_frame):
	var arr = [$skill_indic_3, $skill_indic_1, $skill_indic_2, $skill_indic_3]
	match code_skill:
		0:arr[0].frame = code_frame
		1:arr[1].frame = code_frame
		2:arr[2].frame = code_frame
		3:arr[3].frame = code_frame
# ----------SKILL AREA----------

# 0 COUNTER ATTACK
var _counter_attack_count = 0
var _counter_attack_setup = true
var _counter_attack_activated = false
var _counter_attack_passive = false
var _counter_attack_turn_dec = true

func skill_counter_instant_reset():
	_counter_attack_count = 0
	_counter_attack_setup = true
	_counter_attack_activated = false
	_counter_attack_turn_dec = true
	remove_buff(0)

func skill_counter_attack_reset():
	if _counter_attack_activated and _counter_attack_count == 0:
		_counter_attack_count = 0
		_counter_attack_setup = true
		_counter_attack_activated = false
		_counter_attack_turn_dec = true
		remove_buff(0)

func skill_counter_attack_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_counter_attack_count += 5
		if _counter_attack_count >= 10: _counter_attack_count = 10
		_counter_attack_turn_dec = false
		set_icon_buff(0)
		if _counter_attack_setup:
			_counter_attack_setup = false
			_counter_attack_activated = true

func skill_counter_attack():
	if _counter_attack_activated:
		if _counter_attack_turn_dec: _counter_attack_count -= 1
		if _counter_attack_turn_dec == false: _counter_attack_turn_dec = true
		if _counter_attack_count <=0: _counter_attack_count = 0
		set_icon_buff(0)
		
func skill_counter_attack_trigger(enemy, dmg):
	if enemy._counter_attack_activated:
		stat_health(dmg*-1)
		if dmg !=0 :set_fdmg(dmg*-1, STAT_DMG.COUNTER)

# 01 EVATION
var _evation_desc = ""
var _evation_count = 0
var _evation_level_temp = 0
var _evation_storage = 0
var _evation_activated = false
var _evation_setup = true
var _evation_passive = false
var _evation_dict = {
	1:  "Level 1: Increases evation by 50\n",
	2:  "Level 2: Increases evation by 100\n",
	3:  "Level 3: Increases evation by 150\n"
}

func skill_evation_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		set_fdmg("Increase Evation", STAT_DMG.BUFF)
		_evation_count += 5
		if _evation_count >=10: _evation_count = 10
		set_icon_buff(1)
		if _evation_setup:
			_evation_setup = false
			_evation_activated = true
			_evation_level_temp = level
			match level:
				1: 
					_evation_storage += stat_limit(50, STAT_LIMIT.EVA)
					_evation_desc = _evation_dict[1]
				2: 
					_evation_storage += stat_limit(100, STAT_LIMIT.EVA)
					_evation_desc = _evation_dict[2]
				3: 
					_evation_storage += stat_limit(150, STAT_LIMIT.EVA)
					_evation_desc = _evation_dict[3]
		if level > _evation_level_temp:
			stat_evation(-_evation_storage)
			_evation_storage = 0
			match level:
				1: _evation_storage += stat_limit(50, STAT_LIMIT.EVA)
				2: 
					_evation_desc = _evation_dict[2]
					update_desc(0)
					set_fdmg("Evation Upgraded Level.2", STAT_DMG.BUFF)
					_evation_storage += stat_limit(100, STAT_LIMIT.EVA)
				3: 
					_evation_desc = _evation_dict[3]
					update_desc(0)
					set_fdmg("Evation Upgraded Level.3", STAT_DMG.BUFF )
					_evation_storage += stat_limit(150, STAT_LIMIT.EVA)
			_evation_level_temp = level

func skill_evation_reset():
	stat_evation(-_evation_storage)
	_evation_storage = 0
	_evation_count = 0
	_evation_level_temp = 0
	_evation_activated = false
	_evation_setup = true
	remove_buff(1)

func skill_evation():
	if _evation_activated:
		_evation_count -= 1
		if _evation_count <=0: _evation_count = 0
		set_icon_buff(1)
	if _evation_activated and _evation_count == 0:
		skill_evation_reset()
		
# 02 DEFENSE BREAKEER
## ONLY CASTER
var _defense_breaker = false
var _defense_breaker_level = 0
## ONLY ENEMY
var _defense_breaker_level_temp = 0
var _defense_breaker_count = 0
var _defense_breaker_storage = 0
var _defense_breaker_desc = ""
## TOGETHER
var _defense_breaker_passive = false
var _defense_breaker_isactive = false
var _defense_breaker_immune = false
var _defense_breaker_dict = {
	1: "Reduce 20% defense",
	2: "Reduce 50% defense",
	3: "Reduce 100% defense"
}
func skill_defense_breaker_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_defense_breaker = true
		_defense_breaker_level = level

func skill_defense_breaker_trigger(enemy):
	if _defense_breaker_passive: skill_defense_breaker_activated(1, 10)
	if _defense_breaker:
		enemy.skill_defense_breaker_activated_self(_defense_breaker_level)
		_defense_breaker_level = 0
		_defense_breaker = false
	skill_defense_breaker_trigger_self()

func skill_defense_breaker_trigger_self():
	if _defense_breaker_level_temp != 0:
		_defense_breaker_count -= 1
		set_icon_buff(2)
		if _defense_breaker_count == 0:
			skill_defense_breaker_reset()

func skill_defense_breaker_activated_self(level):
	_defense_breaker_count += 5
	_defense_breaker_count = clamp(_defense_breaker_count, 0, 10)
	set_icon_buff(2)
	_defense_breaker_isactive = true
	var def_before = get_deffense
	if level > _defense_breaker_level_temp:
		_defense_breaker_level_temp = level
		stat_deffense(_defense_breaker_storage)
		match _defense_breaker_level_temp:
			1: 
				_defense_breaker_storage += abs(stat_limit(-get_pct(_default_deff, 20), STAT_LIMIT.DEFENSE))
				_defense_breaker_desc = _defense_breaker_dict[1]
			2: 
				_defense_breaker_storage += abs(stat_limit(-get_pct(_default_deff, 50), STAT_LIMIT.DEFENSE))
				_defense_breaker_desc = _defense_breaker_dict[2]
			3: 
				_defense_breaker_storage += abs(stat_limit(-get_pct(_default_deff, 100), STAT_LIMIT.DEFENSE))
				_defense_breaker_desc = _defense_breaker_dict[3]
		update_desc(2)
	var def_after = get_deffense
	set_fdmg(def_before-def_after, STAT_DMG.DEF_DEC)
	fdmg()
	
func skill_defense_breaker_reset():
	stat_deffense(_defense_breaker_storage)
	set_fdmg(_defense_breaker_storage, STAT_DMG.DEF_UP)
	fdmg()
	_defense_breaker_isactive = false
	_defense_breaker_level_temp = 0
	_defense_breaker_storage = 0
	_defense_breaker_count = 0
	_defense_breaker_desc = ""
	remove_buff(2)

# 03 SKILL LOCK
var skill_lock = false
var skill_lock_own = false
var skill_lock_count = 0
var skill_lock_count_temp = 0
var skill_lock_level = 0
var skill_lock_isactive = false
func skill_lock_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_lock_own = true
		match level:
			1: skill_lock_count_temp = 1
			2: skill_lock_count_temp = 2
			3: skill_lock_count_temp = 3
func skill_lock_trigger(enemy):
	if skill_lock_own:
		skill_lock_own = false
		enemy.skill_lock = true
		enemy.skill_lock_count += skill_lock_count_temp
		skill_lock_count_temp = 0
		enemy.skill_lock_isactive = true
		enemy.set_icon_buff(3)
		enemy.update_desc(3)
	if skill_lock:
		skill_lock_count -= 1
		if skill_lock_count <= 0: skill_lock_reset()
func skill_lock_reset():
	skill_lock = false
	skill_lock_count = 0
	skill_lock_isactive = false
	remove_buff(3)
		

# 04 WEAKENING
var _weakening_passive = false
var _weakening_immune = false

var _weakening_caster_activated = false
var _weakening_caster_level = 0

var _weakening_enem_attack_storage = 0
var _weakening_enem_spda_storage = 0
var _weakening_enem_spdt_storage = 0
var _weakening_enem_eva_storage = 0
var _weakening_enem_crit_storage = 0

var _weakening_isactive = false
var _weakaning_count = 0
var _weakening_enem_level = 0
var _weakening_desc = ""

var _weakening_dict = {
	1:"Decrease Attack -10%\nDecrease Speed Attack -10%\nDecrease Turn Speed -10%\nDecrease Evation -10%\nDecrease Critical Rate -30%",
	2:"Decrease Attack -20%\nDecrease Speed Attack -20%\nDecrease Turn Speed -20%\nDecrease Evation -20%\nDecrease Critical Rate -60%",
	3:"Decrease Attack -50%\nDecrease Speed Attack -50%\nDecrease Turn Speed -50%\nDecrease Evation -50%\nDecrease Critical Rate -100%"
}

func skill_weakening_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_weakening_caster_activated = true
		_weakening_caster_level = level
func skill_weakening_trigger(enemy):
	if _weakening_passive: skill_weakening_activated(1, 10)
	if _weakening_caster_activated:
		_weakening_caster_activated = false
		enemy.skill_weakening_inflict(_weakening_caster_level)
		_weakening_caster_level = 0
	skill_weakening_trigger_self()
func skill_weakening_inflict(level):
	_weakaning_count += 5
	_weakaning_count = clamp(_weakaning_count, 0, 10)
	set_icon_buff(4)
	_weakening_isactive = true
	if level > _weakening_enem_level:
		_weakening_enem_level = level
		stat_attack(_weakening_enem_attack_storage)
		stat_speed(_weakening_enem_spdt_storage)
		stat_speed_atk(_weakening_enem_spda_storage)
		stat_evation(_weakening_enem_eva_storage)
		stat_crit_rate(_weakening_enem_crit_storage)
		match _weakening_enem_level:
			1:
				_weakening_enem_attack_storage += abs(stat_limit(-get_pct(_default_atk, 10), STAT_LIMIT.ATTACK))
				_weakening_enem_spdt_storage += abs(stat_limit(-get_pct(_default_spd, 10), STAT_LIMIT.TURN_SPEED))
				_weakening_enem_spda_storage += abs(stat_limit(-get_pct(_default_speed_atk, 10), STAT_LIMIT.SPD_ATK))
				_weakening_enem_eva_storage += abs(stat_limit(-get_pct(_default_speed_atk, 10), STAT_LIMIT.EVA))
				_weakening_enem_crit_storage += abs(stat_limit(-get_pct(_default_crit_rate, 30), STAT_LIMIT.CRIT_RATE))
				_weakening_desc = _weakening_dict[1]
			2:
				_weakening_enem_attack_storage += abs(stat_limit(-get_pct(_default_atk, 20), STAT_LIMIT.ATTACK))
				_weakening_enem_spdt_storage += abs(stat_limit(-get_pct(_default_spd, 20), STAT_LIMIT.TURN_SPEED))
				_weakening_enem_spda_storage += abs(stat_limit(-get_pct(_default_speed_atk, 20), STAT_LIMIT.SPD_ATK))
				_weakening_enem_eva_storage += abs(stat_limit(-get_pct(_default_speed_atk, 20), STAT_LIMIT.EVA))
				_weakening_enem_crit_storage += abs(stat_limit(-get_pct(_default_crit_rate, 60), STAT_LIMIT.CRIT_RATE))
				_weakening_desc = _weakening_dict[2]
			3:
				_weakening_enem_attack_storage += abs(stat_limit(-get_pct(_default_atk, 50), STAT_LIMIT.ATTACK))
				_weakening_enem_spdt_storage += abs(stat_limit(-get_pct(_default_spd, 50), STAT_LIMIT.TURN_SPEED))
				_weakening_enem_spda_storage += abs(stat_limit(-get_pct(_default_speed_atk, 50), STAT_LIMIT.SPD_ATK))
				_weakening_enem_eva_storage += abs(stat_limit(-get_pct(_default_speed_atk, 50), STAT_LIMIT.EVA))
				_weakening_enem_crit_storage += abs(stat_limit(-get_pct(_default_crit_rate, 100), STAT_LIMIT.CRIT_RATE))
				_weakening_desc = _weakening_dict[3]
		update_desc(4)
		set_fdmg("Attack descresed", STAT_DMG.DEBUFF)
		set_fdmg("Speed Attack descresed", STAT_DMG.DEBUFF)
		set_fdmg("Turn Speed descresed", STAT_DMG.DEBUFF)
		set_fdmg("Evation descresed", STAT_DMG.DEBUFF)
		set_fdmg("Critical Rate descresed", STAT_DMG.DEBUFF)
		fdmg()
func skill_weakening_trigger_self():
	if _weakening_enem_level !=0:
		_weakaning_count -= 1
		_weakaning_count = clamp(_weakaning_count, 0, 10)
		set_icon_buff(4)
		if _weakaning_count == 0: skill_weakening_reset()
func skill_weakening_reset():
	stat_attack(_weakening_enem_attack_storage)
	stat_speed(_weakening_enem_spdt_storage)
	stat_speed_atk(_weakening_enem_spda_storage)
	stat_evation(_weakening_enem_eva_storage)
	remove_buff(4)
	_weakaning_count = 0
	_weakening_enem_level = 0
	_weakening_enem_attack_storage = 0
	_weakening_enem_eva_storage = 0
	_weakening_enem_spdt_storage = 0
	_weakening_enem_spda_storage = 0
	_weakening_isactive = false
	set_fdmg("Attack Increased", STAT_DMG.BUFF)
	set_fdmg("Speed Attack Increased", STAT_DMG.BUFF)
	set_fdmg("Turn Speed Increased", STAT_DMG.BUFF)
	set_fdmg("Evation Increased", STAT_DMG.BUFF)
	fdmg()

# 05 BURN > SET ICON BUFF, REMOVE BUFF
# ENEMY
var _burn_count = 0
var _burn_activated = false
# CASTER
var _burn_trigger = false
var _burn_rng_temp = 0
# TOGETHER
var _burn_immune = false
var _burn_passive = false

func skill_burn_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_burn_trigger = true
		var rng_burn = get_random_int(5, 15)
		_burn_rng_temp = rng_burn

func skill_burn_reset():
	_burn_activated = false
	skill_burn_isactive = false
	_burn_count = 0
	remove_buff(5)

var skill_burn_isactive = false
func skill_burn():
	if _burn_activated and _burn_immune == false:
		var rng_dmg = get_random_int(1000, 10000)
		_burn_count -= 1
		if _burn_count <=0: _burn_count = 0
		set_icon_buff(5)
		skill_burn_isactive = true
		var hp_before = get_health
		stat_health(-rng_dmg)
		if _burn_count >= 20: stat_health(-get_pct(_default_hp, 30))
		elif _burn_count >= 10: stat_health(-get_pct(_default_hp, 20))
		else: stat_health(-get_pct(_default_hp, 10))
		var hp_after = get_health
		var hp_total = hp_after-hp_before
		if hp_total <0:
			set_fdmg(hp_total, STAT_DMG.BURN)
			set_fdmg(rng_dmg, STAT_DMG.BURN)
	if _burn_activated and _burn_count == 0:
		skill_burn_reset()
	if _burn_immune:
		skill_burn_reset()

func skill_burn_trigger(enemy):
	if _burn_trigger:
		enemy._burn_count += _burn_rng_temp
		enemy._burn_activated = true
		_burn_trigger = false
		_burn_rng_temp = 0
	skill_burn()
	enemy.skill_burn()

# 06 POISON
# ENEMY VAR
var _poison_count = 0
var _poison_activated = false
# CASTER VAR
var _poison_trigger = false
# TOGETHER
var _poison_passive = false
var _poison_immune = false

func skill_poison_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct: _poison_trigger = true

func skill_poison_reset():
	_poison_count = 0
	_poison_activated = false
	_skill_poison_isactive = false
	remove_buff(6)

var _skill_poison_isactive = false
func skill_poison():
	if _poison_activated:
		_poison_count -=1
		if _poison_count <= 0: _poison_count = 0
		_skill_poison_isactive = true
		set_icon_buff(6)
		var current_hp = set_pct(get_health, _default_hp)
		var hp_before = get_health
		if current_hp >= 100: stat_health(-2000)
		elif current_hp >= 80: stat_health(-10000)
		elif current_hp >= 60: stat_health(-25000)
		elif current_hp >= 20: stat_health(-40000)
		elif current_hp >= 5: stat_health(-50000)
		else: stat_health(-75000)
		var hp_after = get_health
		var hp_total = hp_after-hp_before
		set_fdmg(hp_total, STAT_DMG.POISON)
	if _poison_activated and _poison_count == 0:
		skill_poison_reset()

func skill_poison_trigger(enemy):
	if _poison_trigger:
		var rng_count = get_random_int(1, 5)
		if enemy._poison_immune == false:
			enemy._poison_activated = true
			enemy._poison_count += rng_count
			enemy.set_icon_buff(6)
		_poison_trigger = false
	skill_poison()

# 07 HEAL
var _heal_desc = ""
var _heal_count = 0
var _heal_level_temp = 0
var _heal_activated = false
var _heal_passive = false
var _heal_setup = true
	
func skill_heal(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_heal_count += 5
		if _heal_setup:
			_heal_setup = false
			_heal_activated = true
			_heal_level_temp = level
			set_fdmg("Heal activated", STAT_DMG.BUFF)
			match level:
				1: _heal_desc = "Level 1: Recovers 2% of total base health."
				2: _heal_desc = "Level 2: Recovers 5% of total base health."
				3: _heal_desc = "Level 3: Recovers 10% of total base health."
			update_desc(7)
		if level > _heal_level_temp:
			_heal_level_temp = level
			match level:
				1: _heal_desc = "Level 1: Recovers 2% of total base health."
				2: _heal_desc = "Level 2: Recovers 5% of total base health."
				3: _heal_desc = "Level 3: Recovers 10% of total base health."
			update_desc(7)
		if _heal_count <=0: _heal_count = 0
		if _heal_count >=10: _heal_count =10
		set_icon_buff(7)
	elif rng >= pct: set_fdmg("Heal failed.", STAT_DMG.DEBUFF) 
			
func skill_heal_activated(level):
	if _heal_activated:
		_heal_count -= 1
		if _heal_count <=0: _heal_count = 0
		if _heal_count >=10: _heal_count =10
		var hp_before = get_health
		match level:
			1: stat_health(get_pct(_default_hp, 2))
			2: stat_health(get_pct(_default_hp, 5))
			3: stat_health(get_pct(_default_hp, 10))
		var hp_after = get_health
		var heal_total = hp_after - hp_before
		set_fdmg(heal_total, STAT_DMG.HEAL)
		set_icon_buff(7)
		if _heal_count == 0: skill_heal_reset()
		SfxManager.play_heal()
	
func skill_heal_reset():
	_heal_count = 0
	_heal_level_temp = 0
	_heal_activated = false
	_heal_setup= true
	remove_buff(7)

# 08 VAMPIRE
# CASTER
var _vampire_count = 0
var _vampire_level_temp = 0
var _vampire_activated = false
var _vampire_desc = ""
var _vampire_setup = true
# TOGETHER
var _vampire_passive = false
var _vampire_dict = {
	1: "Level 1: Absorb 40% of damage as health\n",
	2: "Level 2: Absorb 70% of damage as health\n",
	3: "Level 3: Absorb 100% of damage as health\n"
}

func skill_vampire_reset():
	_vampire_count = 0
	_vampire_level_temp = 0
	_vampire_activated = false
	_vampire_setup = true
	remove_buff(8)

func skill_vampire_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_vampire_level_temp = level
		_vampire_activated = true
		_vampire_count += 5
		if _vampire_count >= 20: _vampire_count = 20
		set_icon_buff(8)
		if _vampire_setup:
			_vampire_setup = false
			match _vampire_level_temp:
				1: _vampire_desc = _vampire_dict[1]
				2: _vampire_desc = _vampire_dict[2]
				3: _vampire_desc = _vampire_dict[3]
			update_desc(8)
	if level > _vampire_level_temp: 
		_vampire_level_temp = level
		match _vampire_level_temp:
			1: _vampire_desc = _vampire_dict[1]
			2: _vampire_desc = _vampire_dict[2]
			3: _vampire_desc = _vampire_dict[3]

func skill_vampire_trigger(dmg):
	if _vampire_activated:
		_vampire_count -= 1
		if _vampire_count <= 0: _vampire_count = 0
		set_icon_buff(8)
		var hp_before = get_health
		match _vampire_level_temp:
			1: stat_health(get_pct(abs(dmg), 40))
			2: stat_health(get_pct(abs(dmg), 70))
			3: stat_health(get_pct(abs(dmg), 100))
		SfxManager.play_heal()
		var hp_after = get_health
		var hp_total = hp_after - hp_before
		hp_total = abs(hp_total)
		if hp_total >0: set_fdmg(hp_total, STAT_DMG.HEAL)
	if _vampire_activated and _vampire_count == 0:
		skill_vampire_reset()

# 09. ECHO SHIELD
var _echo_shiled_count = 0
var _echo_shiled_level_temp = 0
var _echo_shield_activated = false
var _echo_shield_passive = false
var _echo_shiled_setup = true
var _echo_shield_desc = ""
var _echo_shield_dict = {
	1: "Level 1: Gain 50 defense points and restore 2% of base health.\n",
	2: "Level 2: Gain 50 defense points and restore 4% of base health.\n",
	3: "Level 3: Gain 50 defense points and restore 6% of base health.\n"
}

func skill_echo_shield_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_echo_shiled_count += 5
		set_icon_buff(9)
		if _echo_shiled_setup:
			_echo_shiled_setup = false
			_echo_shield_activated = true
			_echo_shiled_level_temp = level
			match _echo_shiled_level_temp:
				1: _echo_shield_desc = _echo_shield_dict[1]
				2: _echo_shield_desc = _echo_shield_dict[2]
				3: _echo_shield_desc = _echo_shield_dict[3]
			update_desc(9)
		if level > _echo_shiled_level_temp: 
			_echo_shiled_level_temp = level
			match _echo_shiled_level_temp:
				1: _echo_shield_desc = _echo_shield_dict[1]
				2: _echo_shield_desc = _echo_shield_dict[2]
				3: _echo_shield_desc = _echo_shield_dict[3]
			update_desc(9)

func skill_echo_shield_reset():
	_echo_shiled_count = 0
	_echo_shiled_level_temp = 0
	_echo_shiled_setup = true
	_echo_shield_activated = false
	remove_buff(9)

func skill_echo_shiled():
	_echo_shiled_count -= 1
	if _echo_shiled_count <=0: _echo_shiled_count = 0
	set_icon_buff(9)
	var hp_before = get_health
	var def_before = get_deffense
	match _echo_shiled_level_temp:
		1: 
			stat_deffense(50)
			stat_health(get_pct(_default_hp, 2))
		2: 
			stat_deffense(100)
			stat_health(get_pct(_default_hp, 4))
		3: 
			stat_deffense(150)
			stat_health(get_pct(_default_hp, 6))
	SfxManager.play_heal()
	var hp_after = get_health
	var deff_after = get_deffense
	if hp_after - hp_before >0: set_fdmg(hp_after-hp_before, STAT_DMG.HEAL)
	if deff_after - def_before >0: set_fdmg(deff_after - def_before, STAT_DMG.DEF_UP)
	
	if _echo_shield_activated and _echo_shiled_count == 0:
		skill_echo_shield_reset()

func skill_echo_shield_trigger(enemy):
	if enemy._echo_shield_activated:
		enemy.skill_echo_shiled()

# 10 CRIT DMG
var _crit_dmg_desc = ""
var _crit_dmg_count = 0 
var _crit_dmg_level_temp = 0
var _crit_dmg_storage = 0
var _crit_dmg_activated = false
var _crit_dmg_setup = true
var _crit_dmg_passive = false
var _crit_dmg_dict = {
	1: "Level 1: Increase Critical Damage by 150%\n",
	2: "Level 2: Increase Critical Damage by 250%\n",
	3: "Level 3: Increase Critical Damage by 500%\n"
}

func skill_crit_dmg_reset():
	stat_crit_dmg(-_crit_dmg_storage)
	_crit_dmg_storage = 0
	_crit_dmg_count = 0
	_crit_dmg_level_temp = 0
	_crit_dmg_setup = true
	_crit_dmg_activated = false
	remove_buff(10)

func skill_crit_dmg_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_crit_dmg_count += 5
		if _crit_dmg_count >= 10: _crit_dmg_count = 10
		_crit_dmg_activated = true
		if _crit_dmg_setup:
			_crit_dmg_setup = false
			_crit_dmg_level_temp = level
			match _crit_dmg_level_temp:
				1: 
					_crit_dmg_desc = "Level 1: Increase Critical Damage by 150%"
					_crit_dmg_storage += stat_limit(150, STAT_LIMIT.CRIT_DMG)
					set_fdmg("Increase Critical Damage Level.1", STAT_DMG.BUFF)
				2: 
					_crit_dmg_desc = "Level 2: Increase Critical Damage by 250%"
					_crit_dmg_storage += stat_limit(250, STAT_LIMIT.CRIT_DMG)
					set_fdmg("Increase Critical Damage Level.2", STAT_DMG.BUFF)
				3: 
					_crit_dmg_desc = "Level 3: Increase Critical Damage by 500%"
					_crit_dmg_storage += stat_limit(500, STAT_LIMIT.CRIT_DMG)
					set_fdmg("Increase Critical Damage Level.3", STAT_DMG.BUFF)
		set_icon_buff(10)
		if level > _crit_dmg_level_temp:
			stat_crit_dmg(-_crit_dmg_storage)
			_crit_dmg_storage = 0
			match level:
				1: 
					_crit_dmg_desc = _crit_dmg_dict[1]
					update_desc(10)
					set_fdmg("Ciritcal Damage Upgraded Level.1", STAT_DMG.BUFF)
					_crit_dmg_storage += stat_limit(150, STAT_LIMIT.CRIT_DMG)
				2: 
					_crit_dmg_desc = _crit_dmg_dict[2]
					update_desc(10)
					set_fdmg("Ciritcal Damage Upgraded Level.2", STAT_DMG.BUFF)
					_crit_dmg_storage += stat_limit(250, STAT_LIMIT.CRIT_DMG)
				3: 
					_crit_dmg_desc = _crit_dmg_dict[3]
					update_desc(10)
					set_fdmg("Ciritcal Damage Upgraded Level.3", STAT_DMG.BUFF)
					_crit_dmg_storage += stat_limit(500, STAT_LIMIT.CRIT_DMG)
			_crit_dmg_level_temp = level
		
func skill_crit_dmg_trigger():
	if _crit_dmg_activated:
		_crit_dmg_count -= 1
		if _crit_dmg_count <= 0: _crit_dmg_count = 0
		set_icon_buff(10)
	if _crit_dmg_activated and _crit_dmg_count == 0:
		skill_crit_dmg_reset()
		
# 11 CRIT RATE
var _crit_rate_desc = ""
var _crit_rate_count = 0
var _crit_rate_level_temp = 0
var _crit_rate_storage = 0
var _crit_rate_activated = false
var _crit_rate_setup = true
var _crit_rate_passive = false
var _crit_rate_dict = {
	1: "Level 1: Increase Critical hit by 30%\n",
	2: "Level 2: Increase Critical hit by 50%\n",
	3: "Level 3: Increase Critical hit by 70%\n"
}

func skill_crit_rate_reset():
	stat_crit_rate(-_crit_rate_storage)
	_crit_rate_storage = 0
	_crit_rate_count = 0
	_crit_rate_level_temp = 0
	_crit_rate_activated = false
	_crit_rate_setup = true
	remove_buff(11)

func skill_crit_rate_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		set_fdmg("Increase Critical Hit Changes", STAT_DMG.BUFF)
		_crit_rate_count += 5
		if _crit_rate_count >=10: _crit_rate_count = 10
		if _crit_rate_setup:
			_crit_rate_setup = false
			_crit_rate_activated = true
			_crit_rate_level_temp = level
			match _crit_rate_level_temp:
				1: 
					_crit_rate_storage += stat_limit(30, STAT_LIMIT.CRIT_RATE)
					_crit_rate_desc = "Level 1: Increase Critical hit by 30%"
				2: 
					_crit_rate_storage += stat_limit(50, STAT_LIMIT.CRIT_RATE)
					_crit_rate_desc = "Level 2: Increase Critical hit by 50%"
				3: 
					_crit_rate_storage += stat_limit(70, STAT_LIMIT.CRIT_RATE)
					_crit_rate_desc = "Level 3: Increase Critical hit by 70%"
		set_icon_buff(11)
	if _crit_rate_activated and level > _crit_rate_level_temp:
		stat_crit_rate(-_crit_rate_storage)
		_crit_rate_storage = 0
		match level:
			1: stat_crit_rate(30)
			2: 
				_crit_rate_desc = _crit_rate_dict[2]
				update_desc(11)
				set_fdmg("Critical Hit: Upgraded Level.2", STAT_DMG.BUFF)
				_crit_rate_storage += stat_limit(50, STAT_LIMIT.CRIT_RATE)
			3: 
				_crit_rate_desc = _crit_rate_dict[3]
				update_desc(11)
				set_fdmg("Critical Hit: Upgraded Level.3", STAT_DMG.BUFF)
				_crit_rate_storage += stat_limit(70, STAT_LIMIT.CRIT_RATE)
		_crit_rate_level_temp = level

func skill_crit_rate_trigger():
	if _crit_rate_activated:
		_crit_rate_count -= 1
		if _crit_rate_count <= 0: _crit_rate_count = 0
		set_icon_buff(11)
	if _crit_rate_activated and _crit_rate_count <= 0:
		skill_crit_rate_reset()
		

# 12 TURN SPEED
var _turn_speed_desc = ""
var _turn_speed_storage = 0
var _turn_speed_count = 0
var _turn_speed_level_temp = 0
var _turn_speed_activated = false 
var _turn_speed_setup = true 
var _turn_speed_passive = false 
var _turn_speed_level = {
	1: "Level 1: Increase Turn Speed by: 100",
	2: "Level 2: Increase Turn Speed by: 200",
	3: "Level 3: Increase Turn Speed by: 300"
}

func skill_turn_speed_reset():
	stat_speed(-_turn_speed_storage)
	_turn_speed_storage = 0
	_turn_speed_count = 0
	_turn_speed_level_temp = 0
	_turn_speed_activated = false
	_turn_speed_setup = true
	_turn_speed_desc = ""
	remove_buff(12)

func skill_turn_speed_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		set_fdmg("Increase Turn Speed", STAT_DMG.BUFF)
		_turn_speed_count += 5
		if _turn_speed_count >=10: _turn_speed_count = 10
		if _turn_speed_setup:
			_turn_speed_setup = false
			_turn_speed_level_temp = level
			_turn_speed_activated = true
			match _turn_speed_level_temp:
				1:
					_turn_speed_storage += stat_limit(100, STAT_LIMIT.TURN_SPEED)
					_turn_speed_desc = _turn_speed_level[1]
				2:
					_turn_speed_storage += stat_limit(200, STAT_LIMIT.TURN_SPEED)
					_turn_speed_desc = _turn_speed_level[2]
				3:
					_turn_speed_storage += stat_limit(300, STAT_LIMIT.TURN_SPEED)
					_turn_speed_desc = _turn_speed_level[3]
		set_icon_buff(12)
		if level > _turn_speed_level_temp:
			stat_speed(-_turn_speed_storage)
			_turn_speed_storage = 0
			match level:
				1:stat_speed(100)
				2:
					_turn_speed_storage += stat_limit(200, STAT_LIMIT.TURN_SPEED)
					set_fdmg("Upgraded Turn Speed to Level.2", STAT_DMG.BUFF)
					_turn_speed_desc = _turn_speed_level[2]
					update_desc(12)
				3:
					_turn_speed_storage += stat_limit(300, STAT_LIMIT.TURN_SPEED)
					set_fdmg("Upgraded Turn Speed to Level.3", STAT_DMG.BUFF)
					_turn_speed_desc = _turn_speed_level[3]
					update_desc(12)
			_turn_speed_level_temp = level
		
func skill_turn_speed_trigger():
	if _turn_speed_activated:
		_turn_speed_count -= 1
		if _turn_speed_count <= 0: _turn_speed_count = 0
		set_icon_buff(12)
	if _turn_speed_activated and _turn_speed_count == 0:
		skill_turn_speed_reset()
			
# 13 DEFENSE UP
var _defense_up_desc = "" 
var _defense_up_count = 0
var _defense_up_level_temp = 0
var _defense_up_storage = 0
var _defense_up_activated = false 
var _defense_up_setup = true 
var _defense_up_passive = false
var _defense_up_dict = {
	1: "Level 1: Defense increased by 50% from max defense\n",
	2: "Level 2: Defense increased by 100% from max defense\n",
	3: "Level 3: Defense increased by 200% from max defense\n"
}

func skill_defense_up_reset():
	var deff_before = get_deffense
	stat_deffense(-_defense_up_storage)
	var deff_after = get_deffense
	set_fdmg(deff_after-deff_before, STAT_DMG.DEF_DEC)
	_defense_up_storage = 0
	_defense_up_count = 0
	_defense_up_level_temp = 0
	_defense_up_setup = true
	_defense_up_activated = false
	_defense_up_desc = ""
	remove_buff(13)

func skill_defense_up_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		_defense_up_count += 5
		if _defense_up_count >=10: _defense_up_count = 10
		if _defense_up_setup:
			_defense_up_setup = false
			_defense_up_activated = true
			_defense_up_level_temp = level
			var deff_before = get_deffense
			match _defense_up_level_temp:
				1: 
					set_fdmg("Increase Defense Level.1", STAT_DMG.BUFF)
					_defense_up_storage += stat_limit(get_pct(_default_deff, 50), STAT_LIMIT.DEFENSE)
					_defense_up_desc = _defense_up_dict[1]
				2: 
					set_fdmg("Increase Defense Level.2", STAT_DMG.BUFF)
					_defense_up_storage += stat_limit(get_pct(_default_deff, 100), STAT_LIMIT.DEFENSE)
					_defense_up_desc = _defense_up_dict[2]
				3: 
					set_fdmg("Increase Defense Level.3", STAT_DMG.BUFF)
					_defense_up_storage += stat_limit(get_pct(_default_deff, 200), STAT_LIMIT.DEFENSE)
					_defense_up_desc = _defense_up_dict[3]
			var deff_after = get_deffense
			set_fdmg(deff_after-deff_before, STAT_DMG.DEF_UP)
		set_icon_buff(13)
	if _defense_up_activated and level > _defense_up_level_temp:
		var deff_before = get_deffense
		stat_deffense(-_defense_up_storage)
		_defense_up_storage = 0
		match level:
			2: 
				set_fdmg("Upgraded Defense Level.2", STAT_DMG.BUFF)
				_defense_up_storage += stat_limit(get_pct(_default_deff, 100), STAT_LIMIT.DEFENSE)
				_defense_up_desc = _defense_up_dict[2]
				update_desc(13)
			3: 
				set_fdmg("Upgraded Defense Level.3", STAT_DMG.BUFF)
				_defense_up_storage += stat_limit(get_pct(_default_deff, 200), STAT_LIMIT.DEFENSE)
				_defense_up_desc = _defense_up_dict[3]
				update_desc(13)
		var deff_after = get_deffense
		set_fdmg(deff_after-deff_before, STAT_DMG.DEF_UP)
		_defense_up_level_temp = level
		
func skill_defense_up_trigger():
	if _defense_up_activated:
		_defense_up_count -= 1
		if _defense_up_count <= 0: _defense_up_count = 0
		set_icon_buff(13)
	if _defense_up_activated and _defense_up_count == 0:
		skill_defense_up_reset()

# 14 SPEED ATTACK
var _speed_attack_desc = "" 
var _speed_attack_storage = 0
var _speed_attack_count = 0
var _speed_attack_level_temp = 0
var _speed_attack_activated = false
var _speed_attack_setup = true 
var _speed_attack_passive = false
var _speed_attack_dict = {
	1: "Level 1: Speed attack increased by 20%\n",
	2: "Level 2: Speed attack increased by 30%\n",
	3: "Level 3: Speed attack increased by 50%\n"
}

func skill_speed_attack_reset():
	stat_speed_atk(-_speed_attack_storage)
	_speed_attack_storage = 0
	_speed_attack_count = 0
	_speed_attack_level_temp = 0
	_speed_attack_activated = false
	_speed_attack_setup = true
	_speed_attack_desc = ""
	remove_buff(14)

func skill_speed_attack_activated(level, pct): 
	var rng = get_random_int(1, 100)
	if rng <= pct:
		set_fdmg("Increase Speed Attack", STAT_DMG.BUFF)
		_speed_attack_count += 5
		if _speed_attack_count >=10: _speed_attack_count = 10
		if _speed_attack_setup:
			_speed_attack_setup = false
			_speed_attack_activated = true
			_speed_attack_level_temp = level
			match _speed_attack_level_temp:
				1: 
					_speed_attack_storage += stat_limit(get_pct(_default_speed_atk, 20), STAT_LIMIT.SPD_ATK)
					_speed_attack_desc = _speed_attack_dict[1]
				2: 
					_speed_attack_storage += stat_limit(get_pct(_default_speed_atk, 30), STAT_LIMIT.SPD_ATK)
					_speed_attack_desc = _speed_attack_dict[2]
				3: 
					_speed_attack_storage += stat_limit(get_pct(_default_speed_atk, 50), STAT_LIMIT.SPD_ATK)
					_speed_attack_desc = _speed_attack_dict[3]
		set_icon_buff(14)
	if _speed_attack_activated and level > _speed_attack_level_temp:
		stat_speed_atk(-_speed_attack_storage)
		_speed_attack_storage = 0
		match level:
			1: stat_speed_atk(get_pct(_default_speed_atk, 20))
			2: 
				_speed_attack_desc = _speed_attack_dict[2]
				update_desc(14)
				set_fdmg("Upgraded Speed Attack Level.2", STAT_DMG.BUFF)
				_speed_attack_storage += stat_limit(get_pct(_default_speed_atk, 30), STAT_LIMIT.SPD_ATK)
			3: 
				_speed_attack_desc = _speed_attack_dict[3]
				update_desc(14)
				set_fdmg("Upgraded Speed Attack Level.3", STAT_DMG.BUFF)
				_speed_attack_storage += stat_limit(get_pct(_default_speed_atk, 50), STAT_LIMIT.SPD_ATK)
		_speed_attack_level_temp = level
				
func skill_speed_aattack_trigger():
	if _speed_attack_activated:
		_speed_attack_count -= 1
		if _speed_attack_count <=0: _speed_attack_count = 0
		set_icon_buff(14)
	if _speed_attack_activated and _speed_attack_count == 0:
		skill_speed_attack_reset()
		
# 15 ATTACK UP
var _attack_up_desc = ""
var _attack_up_storage = 0
var _attack_up_count = 0
var _attack_up_level_temp = 0
var _attack_up_activated = false 
var _attack_up_setup = true
var _attack_up_passive = false
var _attack_up_dict = {
	1: "Level 1: Increase Attack by 50%",
	2: "Level 2: Increase Attack by 100%",
	3: "Level 3: Increase Attack by 200%"
}

func skill_attack_up_reset():
	stat_attack(-_attack_up_storage)
	_attack_up_count = 0
	_attack_up_level_temp = 0
	_attack_up_activated = false
	_attack_up_setup = true
	remove_buff(15)

func skill_attack_up_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		set_fdmg("Increase Attack", STAT_DMG.BUFF)
		_attack_up_count += 5
		if _attack_up_count >= 10: _attack_up_count = 10
		if _attack_up_setup:
			_attack_up_setup = false
			_attack_up_activated = true
			_attack_up_level_temp = level
			match _attack_up_level_temp:
				1: 
					_attack_up_desc = _attack_up_dict[1]
					_attack_up_storage += stat_limit(get_pct(_default_atk, 50), STAT_LIMIT.ATTACK)
				2: 
					_attack_up_desc = _attack_up_dict[2]
					_attack_up_storage += stat_limit(get_pct(_default_atk, 100), STAT_LIMIT.ATTACK)
				3: 
					_attack_up_desc = _attack_up_dict[3]
					_attack_up_storage += stat_limit(get_pct(_default_atk, 200), STAT_LIMIT.ATTACK)
		set_icon_buff(15)
	if _attack_up_activated and level > _attack_up_level_temp:
		stat_attack(-_attack_up_storage)
		match level:
			1: _attack_up_storage += stat_limit(get_pct(_default_atk, 50), STAT_LIMIT.ATTACK)
			2: 
				_attack_up_desc = _attack_up_dict[2]
				update_desc(15)
				set_fdmg("Upgraded Attack Level.2", STAT_DMG.BUFF)
				_attack_up_storage += stat_limit(get_pct(_default_atk, 100), STAT_LIMIT.ATTACK)
			3: 
				_attack_up_desc = _attack_up_dict[3]
				update_desc(15)
				set_fdmg("Upgraded Attack Level.3", STAT_DMG.BUFF)
				_attack_up_storage += stat_limit(get_pct(_default_atk, 200), STAT_LIMIT.ATTACK)
		_attack_up_level_temp = level
		
func skill_attack_up_trigger():
	if _attack_up_activated:
		_attack_up_count -= 1
		if _attack_up_count <= 0: _attack_up_count = 0
		set_icon_buff(15)
	if _attack_up_activated and _attack_up_count == 0:
		skill_attack_up_reset()

# 18 RAGE

var _rage_desc = ""
var _rage_count = 0
var _rage_level_temp = 0
var _rage_hpmin_temp = 0
var _rage_activated = false
var _rage_setup = true
var _rage_oneshot = false
var _rage_attack_storage = 0
var _rage_speedattack_storage = 0
var _rage_eva_storage = 0
var _rage_crit_rate_storage = 0
var _rage_dict = {
	1: "Level 1: Critial Hit: 30%\nAttack: 10%\nSpeed Attack: 10%\nTurn Speed: 10%\nEvation: 10%\n",
	2: "Level 2: Critial Hit: 50%\nAttack: 15%\nSpeed Attack: 15%\nTurn Speed: 15%\nEvation: 15%\n",
	3: "Level 3: Critial Hit: 70%\nAttack: 20%\nSpeed Attack: 20%\nTurn Speed: 20%\nEvation: 20%\n"
}

func skill_rage_reset():
	print("RAGE RESET")
	match _rage_level_temp:
		1: 
			stat_crit_rate(-_rage_crit_rate_storage)
			stat_attack(-_rage_attack_storage)
			stat_speed_atk(-_rage_speedattack_storage)
			stat_evation(-_rage_eva_storage)
		2:
			stat_crit_rate(-_rage_crit_rate_storage)
			stat_attack(-_rage_attack_storage)
			stat_speed_atk(-_rage_speedattack_storage)
			stat_evation(-_rage_eva_storage)
		3:
			stat_crit_rate(-_rage_crit_rate_storage)
			stat_attack(-_rage_attack_storage)
			stat_speed_atk(-_rage_speedattack_storage)
			stat_evation(-_rage_eva_storage)
	_rage_desc = ""
	_rage_count = 0
	_rage_level_temp = 0
	_rage_hpmin_temp = 0
	_rage_crit_rate_storage = 0
	_rage_eva_storage = 0
	_rage_speedattack_storage = 0
	_rage_activated = false
	_rage_setup = true
	_rage_oneshot = true
	remove_buff(18)

func skill_rage_activated(level, hpmin):
	if _rage_oneshot == false:
		var hp_min = get_pct(_default_hp, hpmin)
		_rage_level_temp = level
		_rage_hpmin_temp = hp_min
		_rage_activated = true
		match level:
			1:_rage_desc = _rage_dict[1]
			2:_rage_desc = _rage_dict[2]
			3:_rage_desc = _rage_dict[3]

func skill_rage_trigger():
	if _rage_activated:
		if get_health <= _rage_hpmin_temp:
			_rage_count += 1
			if _rage_count >= 10: _rage_count = 10
			set_icon_buff(18)
			set_fdmg("Rage Activated", STAT_DMG.BUFF)
			if _rage_setup:
				_rage_setup = false
				set_fdmg("Increase Critical Hit", STAT_DMG.BUFF)
				match _rage_level_temp:
					1: _rage_crit_rate_storage += stat_limit(30, STAT_LIMIT.CRIT_RATE)
					2: _rage_crit_rate_storage += stat_limit(50, STAT_LIMIT.CRIT_RATE)
					3: _rage_crit_rate_storage += stat_limit(70, STAT_LIMIT.CRIT_RATE)
			match _rage_level_temp:
				1: 
					_rage_attack_storage += stat_limit(get_pct(_default_atk, 10), STAT_LIMIT.ATTACK)
					_rage_speedattack_storage += stat_limit(get_pct(_default_speed_atk, 10), STAT_LIMIT.SPD_ATK)
					_rage_eva_storage += stat_limit(get_pct(_default_evation, 10), STAT_LIMIT.EVA)
					set_fdmg("Increase Attack Level.1", STAT_DMG.BUFF)
					set_fdmg("Increase Speed Attack Level.1", STAT_DMG.BUFF)
					set_fdmg("Increase Evation Level.1", STAT_DMG.BUFF)
				2:
					_rage_attack_storage += stat_limit(get_pct(_default_atk, 15), STAT_LIMIT.ATTACK)
					_rage_speedattack_storage += stat_limit(get_pct(_default_speed_atk, 15), STAT_LIMIT.SPD_ATK)
					_rage_eva_storage += stat_limit(get_pct(_default_evation, 15), STAT_LIMIT.EVA)
					set_fdmg("Increase Attack Level.2", STAT_DMG.BUFF)
					set_fdmg("Increase Speed Attack Level.2", STAT_DMG.BUFF)
					set_fdmg("Increase Evation Level.2", STAT_DMG.BUFF)
				3:
					_rage_attack_storage += stat_limit(get_pct(_default_atk, 20), STAT_LIMIT.ATTACK)
					_rage_speedattack_storage += stat_limit(get_pct(_default_speed_atk, 20), STAT_LIMIT.SPD_ATK)
					_rage_eva_storage += stat_limit(get_pct(_default_evation, 20), STAT_LIMIT.EVA)
					set_fdmg("Increase Attack Level.3", STAT_DMG.BUFF)
					set_fdmg("Increase Speed Attack Level.3", STAT_DMG.BUFF)
					set_fdmg("Increase Evation Level.3", STAT_DMG.BUFF)
	print(_rage_count)
	if _rage_count == 10: skill_rage_reset()

# 19 GRIM REAPER
var _grim_reaper_onshot = false
var _grim_reaper_activated = false
var _grim_reaper_count = 0
	
func grim_reaper_reset():
	_grim_reaper_count =  0
	_grim_reaper_activated = false
	_grim_reaper_onshot = false
	print("RESET")
	remove_buff(19)
	
func grim_reaper_activated(level):
	if _grim_reaper_onshot == false:
		_grim_reaper_onshot= true
		_grim_reaper_activated = true
		match level:
			1: _grim_reaper_count = 5
			2: _grim_reaper_count = 10
			3: _grim_reaper_count = 15
		set_icon_buff(19)
		print(level)
	print(str("GRIM: ", _grim_reaper_count))

func grim_reaper_trigger():
	if get_health <= 1 and _grim_reaper_onshot and _grim_reaper_activated:
		_grim_reaper_count -= 1
		if _grim_reaper_count <=0: _grim_reaper_count = 0
		set_icon_buff(19)
		stat_health(1)
	if _grim_reaper_activated and _grim_reaper_count == 0:
		grim_reaper_reset()
		
# RESET ALL DEBUFF
# 21
var skill_remove_debuff_passive = false
var skill_remove_debuff_isactiv = false
func skill_remove_debuff_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_remove_debuff_isactiv = true
		skill_defense_breaker_reset()
		skill_weakening_reset()
		skill_burn_reset()
		skill_poison_reset()
		skill_lock_reset()
		set_fdmg("All debuffs successfully removed", STAT_DMG.BUFF)
	else: set_fdmg("Failed to remove debuff", STAT_DMG.DEBUFF)

# 22	
var skill_remove_blue_buff_passive = false
var skill_remove_blue_buff_bool = false
func skill_remove_blue_buff_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct: skill_remove_blue_buff_bool = true
func skill_remove_blue_buff_trigger(enemy):
	if skill_remove_blue_buff_bool:
		enemy.skill_blue_remove_buff()
		skill_remove_blue_buff_bool = false
func skill_blue_remove_buff():
	skill_crit_dmg_reset()
	skill_crit_rate_reset()
	skill_turn_speed_reset()
	skill_defense_up_reset()
	skill_speed_attack_reset()
	skill_attack_up_reset()
	
# 23
var skill_remove_green_buff_passive = false
var skill_remove_green_buff_bool = false
func skill_remove_green_buff_activateed(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct: skill_remove_green_buff_bool = true
func skill_remove_green_buff_trigger(enemy):
	if skill_remove_green_buff_bool:
		enemy.skill_remove_green_buff()
		skill_remove_green_buff_bool = false
func skill_remove_green_buff():
	skill_heal_reset()
	skill_vampire_reset()
	skill_echo_shield_reset()
	
# 24
var skill_remove_gold_buff_passive = false
var skill_remove_gold_bool = false
func skill_remove_gold_buff_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct: skill_remove_gold_bool = true
func skill_remove_gold_buff_trigger(enemy):
	if skill_remove_gold_bool:
		enemy.skill_remove_gold_buff()
		skill_remove_gold_bool = false
func skill_remove_gold_buff():
	skill_evation_reset()
	skill_counter_instant_reset()
	
# 25
var skill_cd_increase_passive = false
var skill_cd_increases_bool = false
func skill_cd_increase_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_cd_increases_bool = true
		set_fdmg("Skill increased cooldown activated.", STAT_DMG.BUFF)
	elif rng >= pct: set_fdmg("Skill increased cooldown failed.", STAT_DMG.DEBUFF)
func skill_cd_increase_trigger(enemy):
	if skill_cd_increases_bool:
		enemy.skill_cd_increase()
		enemy.set_fdmg("Increased cooldown 1 turn", STAT_DMG.DEBUFF)
		skill_cd_increases_bool = false
#26
var skill_cd_descrease_passive = false
func skill_cd_descrease_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_cd_decrease()
		set_fdmg("Decreased cooldown 1 turn", STAT_DMG.BUFF)
	elif rng >= pct: set_fdmg("Skill decreased cooldown failed.", STAT_DMG.DEBUFF)
	
# 27 --- PASSIVE HP TRIGGER ---
func skill_random_bluebuff_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		var _rng = get_random_int(0, 5)
		match _rng:
			0: return skill_crit_dmg_activated(level, 100)
			1: return skill_crit_rate_activated(level, 100)
			2: return skill_turn_speed_activated(level, 100)
			3: return skill_defense_up_activated(level, 100)
			4: return skill_speed_attack_activated(level, 100)
			5: return skill_attack_up_activated(level, 100)
		set_fdmg("Random blue buff activated", STAT_DMG.BUFF)
	elif rng >= pct: set_fdmg("Random blue buff failed. ", STAT_DMG.DEBUFF)

# 27 INSTANT HEAL
var skill_instant_heal_passive = false
var skill_instant_heal_bool = false
func skill_instant_heal_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		var battle_scene_node = get_node("/root/Battle_scene")
		if battle_scene_node.instant_heal_bool:
			battle_scene_node.instant_heal = get_pct(_default_hp,pct)
			battle_scene_node.instant_heal_bool = false
		skill_instant_heal_bool = true
		
func skill_instant_heal_trigger():
	var battle_scene_node = get_node("/root/Battle_scene")
	var instant_heal_amount = battle_scene_node.instant_heal
	if instant_heal_amount !=0 and skill_instant_heal_bool:
		skill_instant_heal_bool = false
		if get_health < _default_hp:
			var heal_needed = _default_hp - get_health
			if instant_heal_amount > heal_needed:
				stat_health(heal_needed)
				set_fdmg(heal_needed, STAT_DMG.HEAL)
			elif instant_heal_amount < heal_needed:
				stat_health(instant_heal_amount)
				set_fdmg(instant_heal_amount, STAT_DMG.HEAL)
			SfxManager.play_heal()
		elif get_health > _default_hp: set_fdmg(0, STAT_DMG.HEAL)

## ONESHOT MAIN DESC
var skill_oneshot_main_desc

# 28 ONESHOT CDMG
var skill_oneshot_cdmg = true
var skill_oneshot_cdmg_icon = true
var skill_oneshot_cdmg_bool = false
var skill_oneshot_cdmg_level_storage = 0
func skill_oneshot_cdmg_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_cdmg_bool = true
		if skill_oneshot_cdmg: set_fdmg("Oneshot Critical Damages avtivated", STAT_DMG.BUFF)
	if skill_oneshot_cdmg_icon:
		skill_oneshot_cdmg_icon = false
		skill_oneshot_cdmg_level_storage = level
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Critical Damage level: ",level)
		set_icon_buff(71)

func skill_oneshot_cdmg_trigger():
	if skill_oneshot_cdmg_bool and skill_oneshot_cdmg:
		skill_crit_dmg_activated(skill_oneshot_cdmg_level_storage, 100)
		update_desc(10)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)	
		skill_oneshot_cdmg_bool = false
		skill_oneshot_cdmg = false
		skill_oneshot_cdmg_level_storage = 0

# 29 ONESHOT CRATE
var skill_oneshot_crate = true
var skill_oneshot_crate_icon = true
var skill_oneshot_crate_bool = false
var skill_oneshot_crate_level_storage = 0
func skill_oneshot_crate_acticvated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req: 
		skill_oneshot_crate_bool = true
		if skill_oneshot_crate: set_fdmg("Oneshot Critical Rate activated.", STAT_DMG.BUFF)
	if skill_oneshot_crate_icon:
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Critical Rate level: ",level)
		skill_oneshot_crate_icon = false
		skill_oneshot_crate_level_storage = level
		set_icon_buff(71)
	
func skill_oneshot_crate_trigger():
	if skill_oneshot_crate_bool and skill_oneshot_crate:
		skill_crit_rate_activated(skill_oneshot_crate_level_storage,100)
		update_desc(11)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_crate_bool = false
		skill_oneshot_crate = false
		skill_oneshot_crate_level_storage = 0
		
# 30 ONESHIT TURN SPEED
var skill_oneshot_turnspeed = true
var skill_oneshot_turnspeed_icon = true
var skill_oneshot_turnspeed_bool = false
var skill_oneshot_turnspeed_level_storage = 0
func skill_oneshot_turnspeed_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_turnspeed_bool = true
		if skill_oneshot_turnspeed: set_fdmg("Oneshot Turn Speed activated.", STAT_DMG.BUFF)
	if skill_oneshot_turnspeed_icon:
		skill_oneshot_turnspeed_icon = false
		skill_oneshot_turnspeed_level_storage = level
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Turn Speed level: ",level)
		set_icon_buff(71)

func skill_oneshot_turnspeed_trigger():
	if skill_oneshot_turnspeed and skill_oneshot_turnspeed_bool:
		skill_oneshot_turnspeed = false
		skill_turn_speed_activated(skill_oneshot_turnspeed_level_storage, 100)
		update_desc(12)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_turnspeed_bool = false
		skill_oneshot_turnspeed = false
		skill_oneshot_turnspeed_level_storage = 0
		
# 31 ONESHOT DEFENSE UP
var skill_oneshot_defenseup = true
var skill_oneshot_defenseup_icon = true
var skill_oneshot_defenseup_bool = false
var skill_oneshot_defenseup_level_storage = 0
func skill_oneshot_defenseup_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_defenseup_bool = true
		if skill_oneshot_defenseup: set_fdmg("Oneshot Defense Up activated.", STAT_DMG.BUFF)
	if skill_oneshot_defenseup_icon:
		skill_oneshot_defenseup_icon = false
		skill_oneshot_defenseup_level_storage = level
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Defense Up level: ",level)
		set_icon_buff(71)

func skill_oneshot_defenseup_trigger():
	if skill_oneshot_defenseup_bool and skill_oneshot_defenseup:
		skill_defense_up_activated(skill_oneshot_defenseup_level_storage, 100)
		update_desc(13)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_defenseup = false
		skill_oneshot_defenseup_bool = false
		skill_oneshot_defenseup_level_storage = 0
		
# 32 ONESHOT SPEED ATTACK
var skill_oneshot_speedattack = true
var skill_oneshot_speedattack_icon = true
var skill_oneshot_speedattack_bool = false
var skill_oneshot_speedattack_level_storage = 0
func skill_oneshot_speedattack_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_speedattack_bool = true
		if skill_oneshot_speedattack: set_fdmg("Oneshot Speed Attack activated.", STAT_DMG.BUFF)
	if skill_oneshot_speedattack_icon:
		skill_oneshot_speedattack_icon = false
		skill_oneshot_speedattack_level_storage = level
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Speed Attack level: ",level)
		set_icon_buff(71)
		
func skill_oneshot_speedattack_trigger():
	if skill_oneshot_speedattack and skill_oneshot_speedattack_bool:
		skill_speed_attack_activated(skill_oneshot_speedattack_level_storage, 100)
		update_desc(14)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_speedattack = false
		skill_oneshot_speedattack_bool = false
		skill_oneshot_speedattack_level_storage = 0
		
# 33 ONESHOT ATTACK UP
var skill_oneshot_attackup = true
var skill_oneshot_attackup_icon = true
var skill_oneshot_attackup_bool = false
var skill_oneshot_attackup_level_storage = 0
func skill_oneshot_attackup_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_attackup_bool = true
		if skill_oneshot_attackup: set_fdmg("Oneshot Attack Up activated.", STAT_DMG.BUFF)
	if skill_oneshot_attackup_icon:
		skill_oneshot_attackup_icon = false
		skill_oneshot_attackup_level_storage = level
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Attack Up level: ",level)
		set_icon_buff(71)

func skill_oneshot_attackup_trigger():
	if skill_oneshot_attackup and skill_oneshot_attackup_bool:
		skill_attack_up_activated(skill_oneshot_attackup_level_storage, 100)
		update_desc(15)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_attackup = false
		skill_oneshot_attackup_bool = false
		skill_oneshot_attackup_level_storage = 0
		
# 34 ONECHOT COUNTER ATTACK
var skill_oneshot_counter = true
var skill_oneshot_counter_icon = true
var skill_oneshot_counter_bool = false
func skill_oneshot_counter_activated(pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_counter_bool = true
		if skill_oneshot_counter: set_fdmg("Oneshot Counter Attack activated.", STAT_DMG.BUFF)
	if skill_oneshot_counter_icon:
		skill_oneshot_counter_icon = false
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Counter Attack")
		set_icon_buff(71)
		
func skill_oneshot_counter_trigger():
	if skill_oneshot_counter and skill_oneshot_counter_bool:
		skill_counter_attack_activated(100) 
		update_desc(0)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_counter = false
		skill_oneshot_counter_bool = false
		
# 35 EVA
var skill_oneshot_eva = true
var skill_oneshot_eva_bool = false
var skill_oneshot_eva_icon = true
var skill_oneshot_eva_level_storage = 0
func skill_oneshot_eva_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_eva_bool = true
		if skill_oneshot_eva: set_fdmg("Oneshot Evation activated.", STAT_DMG.BUFF)
	if skill_oneshot_eva_icon:
		skill_oneshot_eva_icon = false
		skill_oneshot_eva_level_storage = level
		skill_oneshot_main_desc = str("When HP under: ",filter_num_titik(hp_req)," grant Evation Level: ",level)
		set_icon_buff(71)
		
func skill_oneshot_eva_trigger():
	if skill_oneshot_eva and skill_oneshot_eva_bool:
		skill_evation_activated(skill_oneshot_eva_level_storage, 100)
		update_desc(1)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_eva = false
		skill_oneshot_eva_bool = false
		skill_oneshot_eva_level_storage = 0
		
# 36 GRIM
var skill_oneshot_grim = true
var skill_oneshot_grim_bool = false
var skill_oneshot_grim_icon = true
var skill_oneshot_grim_level_storage = 0
func skill_oneshot_grim_activated(level, pct):
	var hp_req = get_pct(_default_hp, pct)
	if get_health <= hp_req:
		skill_oneshot_grim_bool = true
		if skill_oneshot_grim: set_fdmg("Oneshot Grim activated.", STAT_DMG.BUFF)
	if skill_oneshot_grim_icon:
		skill_oneshot_grim_icon = false
		skill_oneshot_grim_level_storage = level
		set_icon_buff(71)

func skill_oneshot_grim_trigger():
	if skill_oneshot_grim and skill_oneshot_grim_bool:
		grim_reaper_activated(skill_oneshot_grim_level_storage)
		update_desc(19)
		skill_oneshot_main_desc = "Already used."
		update_desc(71)
		skill_oneshot_grim = false
		skill_oneshot_grim_bool = false
		skill_oneshot_grim_level_storage = 0

# MULTI C_RATE & C_DMG
func skill_multi_crate_cdmg_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_crit_rate_activated(level, 100)
		skill_crit_dmg_activated(level, 100)
		
# MULTI ATTACKUP & DEFENSE
func skill_multi_attack_defense_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_attack_up_activated(level, 100)
		skill_defense_up_activated(level, 100)
		
# MULTI SOEED ATTACJ TURN SPEED
func skill_multi_spda_spdt_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_turn_speed_activated(level, 100)
		skill_speed_attack_activated(level, 100)
		
# MULTI COODLOWN
var skill_multi_cooldown = false
var skill_multi_cooldown_level = 0
func skill_multi_cooldown_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_multi_cooldown = true
		skill_multi_cooldown_level = level
		set_fdmg("Multiple Cooldown activated.", STAT_DMG.BUFF)
func skill_multi_cooldown_trigger(enemy):
	if skill_multi_cooldown:
		skill_multi_cooldown = false
		var cd_count = 0
		match skill_multi_cooldown_level:
			1: cd_count = 1
			2: cd_count = 2
			3: cd_count = 3
		for value in cd_count:
			skill_cd_decrease()
			set_fdmg("Cooldown -1 turn", STAT_DMG.BUFF)
		for value in cd_count:
			enemy.skill_cd_increase()
			enemy.set_fdmg("Cooldown +1 turn", STAT_DMG.DEBUFF)
			enemy.fdmg()
		skill_multi_cooldown_level = 0

# 70 LAST CURSED
var skill_last_cursed = false
var skill_last_cursed_icon = true
var skill_last_cursed_level = 0
var skill_last_cursed_oneshot = true
func skill_last_cursed_set(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct: skill_last_cursed = true
	if skill_last_cursed_icon:
		skill_last_cursed_level = level
		skill_last_cursed_icon = false
		set_icon_buff(70)
func skill_last_cursed_activated(level):
	for value in range(2): skill_random_bluebuff_activated(level, 100)
func skill_last_cursed_trigger():
	if skill_last_cursed and get_health == 0 and skill_last_cursed_oneshot:
		var battle_scene_node = get_node("/root/Battle_scene")
		if battle_scene_node and battle_scene_node.has_method("check_skill_last_cursed"): battle_scene_node.check_skill_last_cursed(self.card_type_confirm, self)
		skill_last_cursed_oneshot = false
		skill_last_cursed = false
		skill_last_cursed_level = 0
		
# 72 INFINITE HEAL
var skill_infinite_heal = false
var skill_infinite_heal_icon = true
func skill_infinite_heal_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_infinite_heal = true
		if skill_infinite_heal_icon:
			skill_infinite_heal_icon = false
			set_icon_buff(72)
			set_fdmg("Infinite Heal Activated.", STAT_DMG.BUFF)
func skill_infinite_heal_trigger():
	if skill_infinite_heal and get_health > 0 and get_health < _default_hp:
		var hp_before = get_health
		var heal_total = get_pct(_default_hp, 2)
		var heal_after = min(hp_before + heal_total, _default_hp)
		stat_health(heal_after - hp_before)
		set_fdmg(get_health - hp_before, STAT_DMG.HEAL)
		SfxManager.play_heal()

# 73 REFLECT HEAL
var skill_reflect_burn = false
var skill_reflect_burn_pct = 0
var skill_reflect_burn_icon = true
func skill_reflect_burn_activated(pct):
	skill_reflect_burn_pct = pct
	if skill_reflect_burn_icon:
		skill_reflect_burn_icon = false
		set_icon_buff(73)
		skill_reflect_burn = true
func skill_reflect_burn_trigger(enemy):
	if enemy.skill_reflect_burn:
		var rng = get_random_int(1, 100)
		if rng <= enemy.skill_reflect_burn_pct:
			var rng_burn = get_random_int(1, 5)
			_burn_count += rng_burn
			_burn_activated = true
			
var skill_reflect_poison = false
var skill_reflect_poison_pct = 0
var skill_reflect_poison_icon = true
func skill_reflect_poison_activated(pct):
	skill_reflect_poison_pct = pct
	if skill_reflect_poison_icon:
		skill_reflect_poison_icon = false
		set_icon_buff(74)
		skill_reflect_poison = true
func skill_reflect_poison_trigger(enemy):
	if enemy.skill_reflect_poison:
		var rng = get_random_int(1, 100)
		if rng <= enemy.skill_reflect_poison_pct:
			var rng_poison = get_random_int(3, 6)
			_poison_count += rng_poison
			_poison_activated = true

# 75 Reflect attack
var skill_ref_attack = false
var skill_ref_attack_icon = true
var skill_ref_attack_desc = ""
func skill_ref_attack_activated():
	if skill_ref_attack_icon:
		skill_ref_attack_icon = false
		skill_ref_attack = true
		set_icon_buff(75)
		skill_ref_attack_desc = str(filter_num_titik(get_pct(_default_atk, 20)))
		update_desc(75)
		set_fdmg("Reflect attack activated.", STAT_DMG.BUFF)
		fdmg()
	
func skill_ref_atttack_trigger(enemy):
	if enemy.skill_ref_attack:
		var before_counter = get_health
		stat_health(-get_pct(enemy._default_atk, 20))
		var after_counter = get_health
		set_fdmg(after_counter-before_counter, STAT_DMG.COUNTER)

# 76 MORE TURN
var skill_more_turn = false
func skill_more_turn_activated(pct):
	# THIS SKILL ACTIVATED AND TRIGGERED IN BTN ATTACK HERO/ENEMY + ATTACK TO (SKILL TRIGGER)
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_more_turn = true
		set_icon_buff(16)
		
# 77 REBIRTH
var skill_rebrith = false
var skill_until_rebirth_count = 10
func skill_rebrith_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct and skill_until_rebirth_count == 10:
		skill_rebrith = true
		set_icon_buff(17)
		update_desc(17)
		set_fdmg("Rebirth activated", STAT_DMG.BUFF)
		fdmg()
func skill_rebirth_trigger():
	skill_until_rebirth_count -= 1
	update_desc(17)
	if skill_until_rebirth_count == 0:
		stat_health(get_pct(_default_hp, 20))
		set_fdmg(get_pct(_default_hp, 20), STAT_DMG.HEAL)
		fdmg()
		skill_rebrith = false
		skill_until_rebirth_count = 10
		remove_buff(17)

# 78 REFLECT COOLDOWN
var skill_refcd_dec = false
var skill_refcd_dec_level = 0
var skill_refcd_dec_count = 3
var skill_refcd_dec_desc = ""
var skill_refcd_dec_dict = {
	1: "Decrease cooldown: -1 turn",
	2: "Decrease cooldown: -2 turn",
	3: "Decrease cooldown: -3 turn"
}
func skill_refcd_dec_activated(level, pct):
	var rng = get_pct(1, 100)
	if rng <= pct:
		skill_refcd_dec = true
		skill_refcd_dec_desc = skill_refcd_dec_dict[level]
		if level > skill_refcd_dec_level: skill_refcd_dec_level = level
		skill_refcd_dec_count += 3
		skill_refcd_dec_count = clamp(skill_refcd_dec_count, 0, 3)
		set_icon_buff(78)
func skill_refcd_dec_trigger():
	if skill_refcd_dec_level !=0:
		skill_refcd_dec_count -=1
		skill_refcd_dec_count = clamp(skill_refcd_dec_count, 0, 3)
		set_icon_buff(78)
		for value in skill_refcd_dec_level:
			skill_cd_decrease()
			set_fdmg("Cooldown decrease -1 turn", STAT_DMG.BUFF)
		fdmg()
		if skill_refcd_dec_count == 0: skill_refcd_dec_reset()
func skill_refcd_dec_reset():
	remove_buff(78)
	skill_refcd_dec_count = 0
	skill_refcd_dec_level = 0
	skill_refcd_dec_desc = ""
	skill_refcd_dec = false
	
# 79 STUN
var skill_stun = false
var skill_stun_caster_level = 0
var skill_stun_enemy_count = 0
var skill_stun_inflict = false
func skill_stun_activated(level, pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_stun = true
		level = clamp(level, 1, 3)
		match level:
			1: skill_stun_caster_level = 5
			2: skill_stun_caster_level = 10
			3: skill_stun_caster_level = 15
func skill_stun_trigger(enemy):
	if skill_stun:
		skill_stun = false
		enemy.skill_stun_inflict = true
		enemy.skill_stun_enemy_count += skill_stun_caster_level
		enemy.skill_stun_enemy_count = clamp(enemy.skill_stun_enemy_count, 0, 15)
		skill_stun_caster_level = 0
		enemy.set_icon_buff(79)
		enemy.update_desc(79)
		enemy.turn_action = true
		enemy.set_fdmg("STUN !", STAT_DMG.DEBUFF)
		enemy.fdmg()
func skill_stun_trigger_self():
	if skill_stun_inflict:
		skill_stun_enemy_count -= 1
		skill_stun_enemy_count = clamp(skill_stun_enemy_count, 0, 15)
		set_icon_buff(79)
		update_desc(79)
		if skill_stun_enemy_count == 0: skill_stun_reset()
func skill_stun_reset():
	turn_action = false
	skill_stun_inflict = false
	skill_stun_enemy_count = 0
	remove_buff(79)
	
# AMIMIR
var skill_amimir = false
var skill_amimir_inflict = false
func skill_amimir_activated(pct):
	var rng = get_random_int(1, 100)
	if rng <= pct:
		skill_amimir = true
func skill_amimir_trigger(enemy):
	enemy.skill_amimir_reset()
	if skill_amimir:
		skill_amimir = false
		enemy.skill_amimir_self_trigger()
func skill_amimir_self_trigger():
	skill_amimir_inflict = true
	turn_action = true
	set_icon_buff(80)
	update_desc(80)
func skill_amimir_reset():
	if skill_amimir_inflict:
		skill_amimir_inflict = false
		set_fdmg("Debuff a mimir removed", STAT_DMG.BUFF)
		fdmg()
		turn_action = false
		remove_buff(80)
# -------------- END SKILL --------------

@onready var ss_skill_basic = $ss_skill_basic
@onready var ss_skill_1 = $ss_skill_1
@onready var ss_skill_2 = $ss_skill_2
@onready var ss_skill_ulti = $ss_skill_ulti

@onready var ui_select_0 = $ui_select_0
@onready var ui_select_1 = $ui_select_1
@onready var ui_select_2 = $ui_select_2
@onready var ui_select_3 = $ui_select_3

@onready var con_skill_1 = $con_skill_1
@onready var con_skill_2 = $con_skill_2
@onready var con_skill_ulti = $con_skill_ulti

# FLOATING DMG
var fdmg_arr = []
@onready var class_job = $class_job
@onready var basic_stat_info = $LevelBorder/CARD_LEVEL_INDIC
enum STAT_DMG {HIT, CRITICAL, HEAL, DEF_UP, DEF_DEC, BURN, POISON, COUNTER, DODGE, BUFF, DEBUFF}
func set_fdmg(value, status:STAT_DMG):
	var get_fdmg_scn = preload("res://scenes/Floating_damages.tscn")
	var dummy_var = get_fdmg_scn.instantiate()
	dummy_var.changes_fdmg(value, status)
	fdmg_arr.append(dummy_var)
	
func play_sfx_buff():
	var get_sfx = preload("res://scenes/sfx_manager.tscn")
	var dummy_var = get_sfx.instantiate()
	basic_stat_info.add_child(dummy_var)
	dummy_var.get_buff_sfx()
	await get_tree().create_timer(.5).timeout
	dummy_var.queue_free()

func fdmg_duplicate():
	var new_arr = fdmg_arr.duplicate(true)
	fdmg_arr = []
	for value in new_arr:
		basic_stat_info.add_child(value)
		value.play_anim_fdmg()
		SfxManager.play_sfx_buff()
		await get_tree().create_timer(.2).timeout

func fdmg():
	if fdmg_arr.size() != 0:
		fdmg_duplicate()
	
@onready var anim_player_attak = $anim_player_attak

@onready var btn_skill_select = [$ui_select_0, $ui_select_1, $ui_select_2, $ui_select_3]
@onready var btn_skill_desc = [$con_skill_1, $con_skill_2, $con_skill_ulti]
const btn_skill_anim = ["skill_select_0", "skill_select_1", "skill_select_2", "skill_select_3"]
func disable_all_skill_icon():
	for value in btn_skill_select: value.visible = false
	for value in btn_skill_desc: value.visible = false
	anim_player_attak.stop()

func enable_skill_info(_num: int):
	if _num < 0 or _num >= btn_skill_select.size():
		return
	var battle_scene_node = get_node("/root/Battle_scene")
	if btn_skill_select[_num].visible:
		disable_all_skill_icon()
		battle_scene_node.caster_activated_select = false
		print(str("BATTLE INFO : ",battle_scene_node.caster_activated_select))
		return
	elif btn_skill_select[_num].visible == false:
		var get_validation = false
		if battle_scene_node.battle_started and self == battle_scene_node.arr_turn[battle_scene_node.turn_begin_main]: get_validation = true
		else: get_validation = false
		battle_scene_node.caster_activated_select = get_validation
		print(str("BATTLE INFO : ",battle_scene_node.caster_activated_select))
		
	for i in btn_skill_select.size():
		btn_skill_select[i].visible = (i == _num)
	anim_player_attak.stop()
	anim_player_attak.play(btn_skill_anim[_num])
	for i in btn_skill_desc.size():
		btn_skill_desc[i].visible = (i + 1 == _num)

@onready var warning_cooldown:AnimatedSprite2D = $skill_cooldown_warning
func disabale_warning_cd(_bool:bool):
	warning_cooldown.visible = !_bool
	if _bool: warning_cooldown.stop()
	else: warning_cooldown.play("cooldown_warning")
const skill_confirm_data = ["skill_0", "skill_1", "skill_2", "skill_ulti"]
func set_skill_confirm_battleinfo():
	var battle_scene_node = get_node("/root/Battle_scene")
	if battle_scene_node.has_method("battle_info_skill_confirm"):
		battle_scene_node.battle_info_skill_confirm(self)
	else: print("func battle_info_skill_confirm ilang")
	
func check_skill_confirm(_code:int):
	warning_cooldown.visible = false
	if _code == 1:
		if skill_1_cd == 0:
			if card_type_confirm == "hero":disabale_warning_cd(true)
			skill_confirm = skill_confirm_data[_code]
		else:
			skill_confirm = skill_confirm_data[0]
			if card_type_confirm == "hero":disabale_warning_cd(false)
	elif _code == 2:
		if skill_2_cd == 0:
			if card_type_confirm == "hero":disabale_warning_cd(true)
			skill_confirm = skill_confirm_data[_code]
		else:
			if card_type_confirm == "hero":disabale_warning_cd(false)
			skill_confirm = skill_confirm_data[0]
	elif _code == 3:
		if skill_ulti_cd == 0:
			if card_type_confirm == "hero":disabale_warning_cd(true)
			skill_confirm = skill_confirm_data[_code]
		else:
			if card_type_confirm == "hero":disabale_warning_cd(false)
			skill_confirm = skill_confirm_data[0]
	else: skill_confirm = skill_confirm_data[0]

var beginning_turn = false
#! TO BATTLE SCENE
func access_battle_scene(_code):
	var battle_scene_node = get_node("/root/Battle_scene")
	if battle_scene_node.btn_turn == true:
		if battle_scene_node and battle_scene_node.has_method("indicator_skill_confrim"): battle_scene_node.indicator_skill_confrim(_code, self)
		else: print("Node Battle_scene not found or func does not exist.")
	else: print("Battle not strat, yet !")

@onready var get_skill_confirm: AnimatedSprite2D = $mobs/skill_confirm
var indicator_skill_confirm_temp
enum ENUM_SKILL_CONFRIM{BUFF_SINGLE, BUFF_AOE, DEBUFF_SINGLE, DEBUFF_AOE, HEAL_SINGLE, HEAL_AOE, FOCUS_SINGLE, FOCUS_AOE}
func enable_skill_confirm(_bool:bool, _code:ENUM_SKILL_CONFRIM):
	if _bool:
		get_skill_confirm.visible = _bool
		get_skill_confirm.stop()
		match _code:
			ENUM_SKILL_CONFRIM.BUFF_AOE: get_skill_confirm.play("buff_a")
			ENUM_SKILL_CONFRIM.BUFF_SINGLE: get_skill_confirm.play("buff_s")
			ENUM_SKILL_CONFRIM.DEBUFF_AOE: get_skill_confirm.play("debuff_a")
			ENUM_SKILL_CONFRIM.DEBUFF_SINGLE: get_skill_confirm.play("debuff_s")
			ENUM_SKILL_CONFRIM.HEAL_AOE: get_skill_confirm.play("heal_a")
			ENUM_SKILL_CONFRIM.HEAL_SINGLE: get_skill_confirm.play("heal_s")
			ENUM_SKILL_CONFRIM.FOCUS_AOE: get_skill_confirm.play("focus_a")
			ENUM_SKILL_CONFRIM.FOCUS_SINGLE: get_skill_confirm.play("focus_s")
	elif _bool == false:
		get_skill_confirm.visible = false
		get_skill_confirm.stop()
	else: print("FUNC enable_skill_confirm ERROR!")

# SKILL BTN
func _btn_select_skill_0():
	class_desc.visible=false
	btn_stat_menu.visible=false
	main_desc.visible=false
	enable_skill_info(0)
	check_skill_confirm(0)
	access_battle_scene(0)
	set_skill_confirm_battleinfo()
	SfxManager.play_turn_select()
	
func _btn_select_skill_1():
	class_desc.visible=false
	btn_stat_menu.visible=false
	main_desc.visible=false
	check_skill_confirm(1)
	enable_skill_info(1)
	access_battle_scene(1)
	set_skill_confirm_battleinfo()
	SfxManager.play_turn_select()
		
func _btn_select_skill_2():
	class_desc.visible=false
	btn_stat_menu.visible=false
	main_desc.visible=false
	check_skill_confirm(2)
	enable_skill_info(2)
	access_battle_scene(2)
	set_skill_confirm_battleinfo()
	SfxManager.play_turn_select()
		
func _btn_select_skill_3():
	class_desc.visible=false
	btn_stat_menu.visible=false
	main_desc.visible=false
	check_skill_confirm(3)
	enable_skill_info(3)
	access_battle_scene(3)
	set_skill_confirm_battleinfo()
	SfxManager.play_turn_select()

func disable_all_skill_confirm(is_disabled: bool):
	for btn in [$btn_skill_basic, $btn_skill_1, $btn_skill_2, $btn_skill_ulti]:
		btn.disabled = is_disabled

## ---------- PROGRESS BAR ----------
@onready var prog_hp:TextureProgressBar = $BarMainBg/hp_bar
@onready var prog_hp_over:TextureProgressBar = $BarMainBg/hp_bar_over
@onready var prog_hp_late:TextureProgressBar = $BarMainBg/hp_bar_late
@onready var prog_def:TextureProgressBar = $BarMainBg/def_bar
@onready var prog_def_over:TextureProgressBar = $BarMainBg/def_bar_over
@onready var prog_def_late:TextureProgressBar = $BarMainBg/def_bar_late
var get_bar_hp = 0 # SUDAH DI SET DEFAULT HP
var get_bar_def = 0 # SUDAH DI SET DEFAULT DEF
var bar_hp_temp = 100
var bar_def_temp = 100
func bar_hpdef():
	var value_hp = int(set_pct(get_health, get_bar_hp))
	var value_def = int(set_pct(get_deffense, get_bar_def))
		
	prog_hp.value = value_hp
	prog_def.value = value_def
	
	var set_value_hp = clamp(value_hp-100, 0, 90)
	var set_value_def = clamp(value_def-100, 0, 90)
	if value_hp > 100:prog_hp_over.value = set_value_hp
	else: prog_hp_over.value = 0
	if value_def > 100: prog_def_over.value = set_value_def
	else: prog_def_over.value = 0
	
	await get_tree().create_timer(1).timeout
	prog_hp_late.value = value_hp
	prog_def_late.value = value_def

func update_turn_count(value):
	var get_count_turn:Label = $main_frame/LABEL_TURN_COUNT
	var _value = str(value)
	get_count_turn.text = str(_value)

var default_index

func hover_start():
	self.z_index = 10
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)  # Animasi lebih smooth
	tween.set_ease(Tween.EASE_OUT)  # Mulai cepat, lalu melambat
	tween.tween_property(self, "position", Vector2(default_pos_x, default_pos_y - 25), 0.2)
	tween.tween_property(self, "scale", Vector2(1.15, 1.15), 0.2)

func hover_reset():
	if not pos_lock:
		pos_lock = true
		default_pos_x = self.position.x
		default_pos_y = self.position.y
		default_index = self.z_index

	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)  # Mulai lambat, cepat di tengah, lalu melambat lagi
	tween.tween_property(self, "position", Vector2(default_pos_x, default_pos_y), 0.2)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	tween.tween_callback(func(): self.z_index = default_index)


	


	
	
	
	
