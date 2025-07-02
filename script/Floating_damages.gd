extends Node2D

func format_number(_value: int) -> String:
	var num_str = str(abs(_value))
	var result = "-" if _value < 0 else ""
	
	var reversed_str = num_str.reverse()
	var chunks = []
	for i in range(0, reversed_str.length(), 3):
		chunks.append(reversed_str.substr(i, 3))
	
	# Menggabungkan menggunakan String.join()
	result += String(".").join(chunks).reverse()
	return result

func get_random_int(rand_min: int, rand_max: int) -> int:
	return randi_range(rand_min, rand_max)

enum STAT_DMG {HIT, CRITICAL, HEAL, DEF_UP, DEF_DEC, BURN, POISON, COUNTER, DODGE, BUFF,  DEBUFF}

func changes_fdmg(value, status):
	var get_value = $txt_dmg
	var get_desc = $txt_dmg/txt_desc
	var main_parent = $"."
	
	var random_xpos = get_random_int(-600, 600)
	main_parent.position = Vector2(random_xpos, 0)
	
	if status == STAT_DMG.HIT:
		get_value.text = str(format_number(value))
		get_desc.text = "HIT"
		get_value.self_modulate = Color("bbbdc0")
		get_desc.self_modulate = Color("bbbdc0")
		$txt_dmg/txt_desc/icon_dmg.frame = 0
	elif status == STAT_DMG.CRITICAL:
		get_value.text = "" + str(format_number(value))
		get_desc.text = "CRITICAL"
		get_value.self_modulate = Color("ff8a00")
		get_desc.self_modulate = Color("ff8a00")
		$txt_dmg/txt_desc/icon_dmg.frame = 1
	elif status == STAT_DMG.HEAL:
		get_value.text = "+" + str(format_number(value))
		get_desc.text = "HEAL"
		get_value.self_modulate = Color("8dc53e")
		get_desc.self_modulate = Color("8dc53e")
		$txt_dmg/txt_desc/icon_dmg.frame = 2
	elif status == STAT_DMG.DEF_UP:
		get_value.text = "+" + str(format_number(value))
		get_desc.text = "DEFENSE"
		get_value.self_modulate = Color("27aae0")
		get_desc.self_modulate = Color("27aae0")
		$txt_dmg/txt_desc/icon_dmg.frame = 3
	elif status == STAT_DMG.DEF_DEC:
		get_value.text = "" + str(format_number(value))
		get_desc.text = "DEFENSE"
		get_value.self_modulate = Color("bd1e2c")
		get_desc.self_modulate = Color("bd1e2c")
		$txt_dmg/txt_desc/icon_dmg.frame = 4
	elif status == STAT_DMG.BURN:
		get_value.text = "" + str(format_number(value))
		get_desc.text = "BURNT"
		get_value.self_modulate = Color("f05a29")
		get_desc.self_modulate = Color("f05a29")
		$txt_dmg/txt_desc/icon_dmg.frame = 5
	elif status == STAT_DMG.POISON:
		get_value.text = "" + str(format_number(value))
		get_desc.text = "POISON"
		get_value.self_modulate = Color("9e1f62")
		get_desc.self_modulate = Color("9e1f62")
		$txt_dmg/txt_desc/icon_dmg.frame = 6
	elif status == STAT_DMG.COUNTER:
		get_value.text = "" + str(format_number(value))
		get_desc.text = "COUNTER"
		get_value.self_modulate = Color("ffd300")
		get_desc.self_modulate = Color("ffd300")
		$txt_dmg/txt_desc/icon_dmg.frame = 7
	elif status == STAT_DMG.DODGE:
		get_value.text = "MISS"
		get_desc.text = ""
		get_value.self_modulate = Color.GOLD
		get_desc.self_modulate = Color.GOLD
		$txt_dmg/txt_desc/icon_dmg.frame = 8
	elif status == STAT_DMG.BUFF:
		get_value.text = ""
		get_desc.text = str(value)
		get_value.self_modulate = Color.DEEP_SKY_BLUE
		get_desc.self_modulate = Color.DEEP_SKY_BLUE
		$txt_dmg/txt_desc/icon_dmg.frame = 8
	elif status == STAT_DMG.DEBUFF:
		get_value.text = ""
		get_desc.text = str(value)
		get_value.self_modulate = Color.PURPLE
		get_desc.self_modulate = Color.PURPLE
		$txt_dmg/txt_desc/icon_dmg.frame = 8

func play_anim_fdmg():
	var animation_player = $AnimationPlayer
	animation_player.play("anim_fdmg")
