class_name Base_stat

#ATTACK
const max_attack = 9999999
var _attack :int = 0
var attack :int = _attack:
	get:
		return _attack
	set(value):
		set_attack(value)
		
func set_attack(value) -> void:
	const value_min = 0
	const value_max = max_attack
	_attack = clamp(value, value_min, value_max)
	
#DEFFENSE
const max_defense = 50000
var _deffense :int = 0
var deffense :int = _deffense:
	get:
		return _deffense
	set(value):
		set_deffense(value)
		
func set_deffense(value):
	const value_min = 0
	const value_max = max_defense
	_deffense = clamp(value, value_min, value_max)
	
#HEALTH
const max_health = 9999999
var _health :int = 0
var health = _health:
	get:
		return _health
	set(value):
		set_health(value)

func set_health(value):
	const value_min = 0
	const value_max = max_health
	_health = clamp(value, value_min, value_max)
	
#SPEED
const max_turn_speed = 10000
var _speed :int = 0
var speed = _speed:
	get:
		return _speed
	set(value):
		set_speed(value)

func set_speed(value):
	const value_min = 0
	const value_max = max_turn_speed
	_speed = clamp(value, value_min, value_max)

#COST
const max_cost = 25
var _cost :int = 0
var cost :int = _cost:
	get:
		return _cost
	set(value):
		set_cost(value)

func set_cost(value) -> void:
	const value_min = 0
	const value_max = max_cost
	_cost = clamp(value, value_min, value_max)

#CRIT RATE
const max_crit_rate = 200
var _crit_rate: int = 0
var crit_rate :int = _crit_rate:
	get:
		return _crit_rate
	set(value):
		set_crit_rate(value)
func set_crit_rate(value) -> void:
	const value_min = 0
	const value_max = max_crit_rate
	_crit_rate = clamp(value, value_min, value_max)
	
# CRIT DMG
const max_crit_dmg = 5000
var _crit_dmg: int = 0
var crit_dmg :int = _crit_dmg:
	get:
		return _crit_dmg
	set(value):
		set_crit_dmg(value)
func set_crit_dmg(value) -> void:
	const value_min = 150
	const value_max = max_crit_dmg
	_crit_dmg = clamp(value, value_min, value_max)

# SPEED ATACK
const max_speed_attack = 10000
var _speed_atk: int = 0
var speed_atk :int = _speed_atk:
	get:
		return _speed_atk
	set(value):
		set_speed_attack(value)
func set_speed_attack(value) -> void:
	const value_min = 0
	const value_max = max_speed_attack
	_speed_atk = clamp(value, value_min, value_max)
	
# EVASION
const max_evation = 5000
var _evation: int = 0
var evation :int = _evation:
	get:
		return _evation
	set(value):
		set_evation(value)
func set_evation(value):
	const value_min = 0
	const value_max = max_evation
	_evation = clamp(value, value_min, value_max)

# CRIT DEFF
const max_crit_def = 100
var _crit_deff :int = 0
var crit_deff :int = _crit_deff:
	get:
		return _crit_deff
	set(value):
		set_crit_deff(value)
func set_crit_deff(value):
	const value_min = 0
	const value_max = max_crit_def
	_crit_deff = clamp(value, value_min, value_max)
