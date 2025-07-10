extends Node

@onready var wheel = $spin/Lucky_wheel/lw_3/lw_2
@onready var get_wheel_coin:Label = $spin/header/hbox/spin_txt
#@onready var wheel_coin_total = AutoloadData.player_spin_coin
@onready var get_anim_spinfail:AnimationPlayer = $anim_spin
@onready var get_lobby_eq = Lobby_equipments.new()
@onready var reward_dash:Panel = $Reward_dash
@onready var reward_desh_img:TextureRect = $Reward_dash/pnlc/vbox/img
@onready var btn_cls_reward = $Reward_dash/btn_cls
@onready var spin_exp = AutoloadData.spin_exp
@onready var spin_level = AutoloadData.spin_level
@onready var node_spin_exp:Label = $spin/spin_level/vbox/hbox2/exp
@onready var node_spin_level:Label = $spin/spin_level/vbox/hbox/level
@onready var node_spin_prog:TextureProgressBar = $spin/spin_level/vbox/hbox/prog
@onready var node_spin_reward:Label = $spin/Lucky_wheel/btn_spin_roll/Label
@onready var node_floating_exp:Label = $spin/spin_level/vbox/hbox/level/floating_exp
@onready var anim_Player:AnimationPlayer = $anim_player
const max_exp = 1000000
func autoload_spin_level():
	node_spin_exp.text = str(spin_exp)
	node_spin_level.text = str("Level: ", spin_level)
	node_spin_reward.text = str(AutoloadData.spin_reward,"X REWARD")
	node_spin_prog.value = get_lobby_eq.set_pct(spin_exp, max_exp)	
	node_spin_exp.text = get_lobby_eq.filter_num_k(spin_exp)
	$spin/pnl_chance_cls.connect("pressed", func():
		$spin/pnl_chance_cls.hide())
	$spin/spin_level/vbox/Button.connect("pressed", func():
		$spin/pnl_chance_cls.show())
	update_coin()

func update_coin():
	$spin/hbox_reward/btn_reward_r/count.text = str(AutoloadData.player_reward)
	$spin/hbox_reward/btn_reward_s/count.text = str(AutoloadData.player_reward_special)
	wallet_node["reward"].text =  str(AutoloadData.player_reward)
	wallet_node["special_reward"].text =  str(AutoloadData.player_reward_special)
	get_wheel_coin.text = str("SPIN COIN: ",AutoloadData.player_spin_coin)

func spin_score_manager(add_exp):
	
	var temp_exp = spin_exp
	var sim = spin_exp+add_exp
	if sim > max_exp:
		spin_level+=1
		AutoloadData.spin_reward+=1
		sim-=max_exp
		while sim > max_exp:
			sim-=max_exp
			spin_level+=1
			AutoloadData.spin_reward+=1
		spin_exp=sim
	elif sim == max_exp:
		spin_level += 1
		AutoloadData.spin_reward+=1
		spin_exp=0
	else:
		spin_exp+=add_exp
	var temp_prog = node_spin_prog.value
	var prog_pct = get_lobby_eq.set_pct(spin_exp, max_exp)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_method(func(value):
		node_spin_prog.value=value,
		temp_prog,
		prog_pct,
		.2)
	tween.tween_method(func(value):
		node_spin_exp.text=str(get_lobby_eq.filter_num_k(value)),
		temp_exp,
		spin_exp,
		1)
	node_spin_level.text = str("Level: ",spin_level)
	node_spin_reward.text = str(AutoloadData.spin_reward,"X REWARD")
	node_floating_exp.text=str(add_exp)
	node_floating_exp.show()
	anim_Player.play("floating_exp")
	await anim_Player.animation_finished
	node_floating_exp.hide()
	AutoloadData.save_data()

func _ready() -> void:
	update_spin_exhance()
	onready_btn_vault()
	onready_open_chest()
	if AutoloadData.player_inventory_chest[current_chest_selected] < 10:
		node_btnc_x10open.button_pressed=false
	else: node_btnc_x10open.button_pressed=true
	$open_chest/chest_own.text = str("OWN: ",AutoloadData.player_inventory_chest[1])
	get_wheel_coin.text = str("SPIN COIN: ",AutoloadData.player_spin_coin)
	onready_btn_current()
	SfxManager.lw_onready_bgm(SfxManager.ENUM_BGM.SHOP)
	onready_spin()
	autoload_spin_level()
	for key in wallet_node.keys():
		wallet_node[key].text = get_lobby_eq.filter_num_k(get_currency[key])

func update_tweex_txt(nilai_awal: int, nilai_final: int, target_label: Label) -> void:
	var tween := create_tween()
	var dummy := nilai_awal
	
	tween.tween_method(func(val):
		SfxManager.play_score()
		target_label.text = get_lobby_eq.filter_num_k(val), dummy, nilai_final, 2.0)

@onready var wallet_node = {
	"gold": $spin/history_senoak/vbox/hbox/count/gold,
	"mana": $spin/history_senoak/vbox/hbox/count/mana,
	"ticket": $spin/history_senoak/vbox/hbox/count/ticket,
	"spin_coin": $spin/history_senoak/vbox/hbox/count/spin_coin,
	"reward": $spin/history_senoak/vbox/hbox/count/r_reward,
	"special_reward": $spin/history_senoak/vbox/hbox/count/s_reward2
}
@onready var get_currency = {
	"gold": AutoloadData.player_money,
	"mana": AutoloadData.player_exp,
	"ticket": AutoloadData.player_super_ticket,
	"spin_coin": AutoloadData.player_spin_coin,
	"reward": AutoloadData.player_reward,
	"special_reward": AutoloadData.player_reward_special
}

func spin_update(value: int) -> void:
	var label = $Reward_dash/pnlc/vbox/count
	var tween_count = get_tree().create_tween()
	var start_value = 0
	var duration = 2.0

	tween_count.tween_method(
		func(new_val):
			SfxManager.play_score()
			label.text = get_lobby_eq.filter_num_k(int(new_val))
	, start_value, value, duration)

func spin_update_icon(code):
	var limit_code = clamp(code,0, 4)
	code = limit_code
	var get_img:PanelContainer = $Reward_dash/pnlc
	var stylebox = StyleBoxTexture.new()
	match code:
		0: stylebox.texture = preload("res://img/UI (new)/New UI Flat/Tier Reward/T0.png")
		1: stylebox.texture = preload("res://img/UI (new)/New UI Flat/Tier Reward/T1.png")
		2: stylebox.texture = preload("res://img/UI (new)/New UI Flat/Tier Reward/T2.png")
		3: stylebox.texture = preload("res://img/UI (new)/New UI Flat/Tier Reward/T3.png")
		4: stylebox.texture = preload("res://img/UI (new)/New UI Flat/Tier Reward/T4.png")
	get_img.add_theme_stylebox_override("panel", stylebox)	

var temp_gold = AutoloadData.player_money
var temp_mana = AutoloadData.player_exp

var is_spinning:bool = false
# Segment probabilities (index 0-9)
var segment_positions = [0, 36, 72, 108, 144, 180, 216, 252, 288, 324]
var chances = [25.0, 25.0, 10.0, 10.0, 10.0, 1.0, 2.0, 2.0, 5.0, 10.0]
func spin_smooth_with_timing(start_rotation: float, end_rotation: float, total_segments: int):
	# Split into fast and slow phases
	var fast_segments = int(total_segments * 0.8)
	var slow_segments = total_segments - fast_segments
	var current_rotation = start_rotation
	var segment_step = 36.0
	# Fast phase: consistent 0.11s per segment
	for i in range(fast_segments):
		current_rotation += segment_step
		
		var tween = create_tween()
		tween.tween_property(wheel, "rotation_degrees", current_rotation, 0.11)
		
		SfxManager.play_lucky_wheel()
		await tween.finished
	# Slow phase: progressive slowdown
	for i in range(slow_segments):
		current_rotation += segment_step
		# Progressive slowdown from 0.11s to 0.4s
		var progress = float(i) / float(slow_segments - 1) if slow_segments > 1 else 0.0
		var duration = 0.11 + (progress * 0.29)  # 0.11 -> 0.4
		
		var tween = create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(wheel, "rotation_degrees", current_rotation, duration)
		
		SfxManager.play_lucky_wheel()
		await tween.finished
	# Final precise adjustment to exact target
	if abs(current_rotation - end_rotation) > 0.1:
		var final_tween = create_tween()
		final_tween.set_ease(Tween.EASE_OUT)
		final_tween.tween_property(wheel, "rotation_degrees", end_rotation, 0.2)
		await final_tween.finished
func get_weighted_random_segment() -> int:
	var total := 0.0
	for c in chances:
		total += c

	var pick := randf() * total
	var cumulative := 0.0

	for i in chances.size():
		cumulative += chances[i]
		if pick < cumulative:
			return i
	return chances.size() - 1
func get_random_segment():
	var rng = randi_range(1, 100)
	if rng <=25: return 0
	elif rng <= 35: return 1
	elif rng <= 40: return 2
	elif rng <= 42: return 3
	elif rng <= 44: return 4
	elif rng == 45: return 5
	elif rng <= 75: return randi_range(6,8)
	else: return 9
	
func spin():
	if is_spinning: return
	elif AutoloadData.player_spin_coin <=0:
		if get_anim_spinfail.is_playing() == false:
			get_anim_spinfail.play("spin_not_enough")
			SfxManager.play_system_fail()
		return
	SfxManager.play_click()
	get_anim_spinfail.play("spin_pressed")
	is_spinning = true
	# Get target segment and its exact position
	#var target_segment = get_weighted_random_segment()
	var target_segment
	if AutoloadData.spin_exhance_special == 500:
		if AutoloadData.spin_exhance_common == 100: AutoloadData.spin_exhance_common -=1
		target_segment = 5
	elif AutoloadData.spin_exhance_common == 100:
		target_segment = 6
	#else: target_segment = get_random_segment()
	else: target_segment = get_weighted_random_segment()
	# CHEAT START--------
	#target_segment = 7
	# CHEAT END--------
	var target_position = segment_positions[target_segment]
	# Current rotation (tidak di reset, lanjut dari posisi sekarang)
	var current_rotation = wheel.rotation_degrees
	var current_normalized = fmod(current_rotation, 360)
	if current_normalized < 0:
		current_normalized += 360
	# Calculate spins and final target
	var spins = randi_range(3, 6)
	var final_target = current_rotation + (spins * 360) + (target_position - current_normalized)
	# Jika target position lebih kecil dari posisi current, tambah 1 putaran
	if target_position < current_normalized:
		final_target += 360
	# Calculate total segments to move
	var total_rotation = final_target - current_rotation
	var total_segments = int(total_rotation / 36)
	
	await spin_smooth_with_timing(current_rotation, final_target, total_segments)
	if target_segment in [4, 3, 2]:
		SfxManager.play_lucky_wheel_fail()
		new_history("ZONK")
		spin_score_manager(randi_range(100,500))
	elif target_segment == 0:
		temp_mana = AutoloadData.player_exp
		SfxManager.play_lucky_wheel_reward(true)
		var reward = 0
		var code
		var rng = randi_range(1, 100)
		var score_exp = rng*10
		spin_score_manager(score_exp)
		if rng == 1:
			code=4
			reward = 200000*AutoloadData.spin_reward
		elif rng <= 5: 
			code=3
			reward = 75000*AutoloadData.spin_reward
		elif rng <= 10:
			code=2
			reward = 50000*AutoloadData.spin_reward
		elif rng <= 24:
			code=1
			reward = 25000*AutoloadData.spin_reward
		else:
			code=0
			reward = 10000
		new_history( str("MANA: ",get_lobby_eq.filter_num_k(reward)) )
		spin_update_icon(code)
		reward_dash.show()
		reward_desh_img.texture = load("res://img/UI (new)/New UI Flat/flat_mana.png")
		AutoloadData.player_exp += reward
		AutoloadData.save_data()
		spin_update(reward)
		btn_cls_reward.disabled = true
		await get_tree().create_timer(3).timeout
		btn_cls_reward.disabled = false
	elif target_segment == 1:
		temp_gold = AutoloadData.player_money
		SfxManager.play_lucky_wheel_reward(false)
		var reward = 0
		var code
		var rng = randi_range(1, 100)
		var score_exp = rng*10
		spin_score_manager(score_exp)
		if rng == 1:
			code=4
			reward = 25000000*AutoloadData.spin_reward
		elif rng <= 5:
			code=3
			reward = 20000000*AutoloadData.spin_reward
		elif rng <= 10:
			code=2
			reward = 10000000*AutoloadData.spin_reward
		elif rng <= 24:
			code=1
			reward = 2500000*AutoloadData.spin_reward
		else:
			code=0
			reward = 500000
		new_history( str("GOLD: ",get_lobby_eq.filter_num_k(reward)) )
		spin_update_icon(code)
		AutoloadData.player_money += reward
		AutoloadData.save_data()
		reward_dash.show()
		reward_desh_img.texture = load("res://img/UI (new)/New UI Flat/flat_gold.png")
		spin_update(reward)
		btn_cls_reward.disabled = true
		await get_tree().create_timer(3).timeout
		btn_cls_reward.disabled = false
	elif target_segment == 6:
		SfxManager.play_lucky_wheel_jackpot()
		AutoloadData.player_reward+=AutoloadData.spin_reward
		new_history(str("RANDOM BOX X",AutoloadData.spin_reward ))
		$spin/hbox_reward/btn_reward_r/count.text = str(AutoloadData.player_reward)
		wallet_node["reward"].text = str(AutoloadData.player_reward)
		spin_score_manager(1000)
	elif target_segment == 5:
		SfxManager.play_lucky_wheel_jackpot_super()
		AutoloadData.player_reward_special+=AutoloadData.spin_reward
		new_history(str("SPECIAL RANDOM BOX X",AutoloadData.spin_reward))
		$spin/hbox_reward/btn_reward_s/count.text = str(AutoloadData.player_reward_special)
		wallet_node["special_reward"].text = str(AutoloadData.player_reward_special)
		spin_score_manager(5000)
	elif target_segment in [9,8,7]:
		SfxManager.play_lucky_wheel_freespin()
		var get_bonus
		match target_segment:
			9:get_bonus=1*AutoloadData.spin_reward
			8:get_bonus=2*AutoloadData.spin_reward
			7:get_bonus=3*AutoloadData.spin_reward
		AutoloadData.player_spin_coin+=get_bonus
		AutoloadData.save_data()
		if target_segment==9:new_history(str("SPIN X",1*AutoloadData.spin_reward))
		elif target_segment==8:new_history(str("SPIN X",2*AutoloadData.spin_reward))
		elif target_segment==7:new_history(str("SPIN X",3*AutoloadData.spin_reward))
		wallet_node["spin_coin"].text = str(get_currency["spin_coin"])
		spin_score_manager(randi_range(500,1000))
	
	is_spinning = false
	AutoloadData.player_spin_coin -=1
	var limit_spin_coin = clamp(AutoloadData.player_spin_coin, 0, 999999)
	AutoloadData.player_spin_coin = limit_spin_coin
	AutoloadData.spin_exhance_common +=1
	AutoloadData.spin_exhance_special +=1
	if AutoloadData.spin_exhance_common == 101:AutoloadData.spin_exhance_common = 0
	if AutoloadData.spin_exhance_special == 501: AutoloadData.spin_exhance_special = 0
	update_spin_exhance()
	AutoloadData.roadmap_total_spin+=1
	AutoloadData.save_data()
	$spin/history_senoak/vbox/hbox/count/spin_coin.text = str(AutoloadData.player_spin_coin)
	get_wheel_coin.text = str("SPIN COIN: ",AutoloadData.player_spin_coin)
	
func update_spin_exhance():
	$spin/fixed_reward/hbox/vbox_2/prog_r.value = int( AutoloadData.spin_exhance_common )
	$spin/fixed_reward/hbox/vbox_2/prog_s.value = int( AutoloadData.spin_exhance_special/5 )
	$spin/fixed_reward/hbox/vbox_3/Label.text = str(AutoloadData.spin_exhance_common,"/100")
	$spin/fixed_reward/hbox/vbox_3/Label2.text = str(AutoloadData.spin_exhance_special,"/500")
	
func onready_spin():
	$spin/btn_cls.connect("pressed", func():
		$spin.hide() )
# ----------------------------- HISTORY --------------------------
var history_count = 1
@onready var history_prosed:HBoxContainer = $spin/history/vbox/ScrollContainer/vbox/prosed_hbox
@onready var history_parent:VBoxContainer = $spin/history/vbox/ScrollContainer/vbox

func new_history(code):
	var history = history_prosed.duplicate()
	var num:Label = history.get_node("num")
	var main:Label = history.get_node("main")
	num.text = str(history_count)
	history_count+=1
	main.text=str(code)
	history.show()
	history_parent.add_child(history)
	history_parent.move_child(history, 0)

# ----------------------------- REWARD OPEN:START -----------------------------
@onready var btn_pre_open = $spin/pnl_open_reward/pre_open
@onready var btn_reward_confirm = $spin/pnl_open_reward/reward_confirm
@onready var parent_reward = $spin/pnl_open_reward
@onready var pnl_parent = $spin/pnl_open_reward/pnl_all_img
@onready var select_main:TextureRect = $spin/pnl_open_reward/select
@onready var img_random = {
	"basic":"res://img/Item/Chest/random_1.png",
	"special":"res://img/Item/Chest/random_2.png"
}
var current_selected_reward = null

func onready_btn_current():
	var count = 1
	for child in pnl_parent.get_children():
		if child.has_node("btn"):
			var btn: Button = child.get_node("btn")
			
			# Simpan nilai count sekarang ke dalam variabel lokal agar tidak terjebak closure
			var index = count
			
			btn.connect("pressed", func():
				SfxManager.play_turn_select()
				current_selected_reward = index
				if select_main.visible==false and is_pre_open==false:
					select_main.show()
				if select_main.visible and is_pre_open==false:
					tween_select_move(select_main, child)
			)
			count += 1

func tween_select_move(_node: Control, target_node: Control) -> void:
	var tween = create_tween()
	var target_pos = target_node.get_global_rect().position
	var target_size = target_node.get_global_rect().size
	var self_size = _node.get_global_rect().size

	# Hitung posisi agar _node berada di tengah target_node
	var final_pos = target_pos + (target_size / 2) - (self_size / 2)

	tween.tween_property(_node, "global_position", final_pos, 0.1)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)

func img_chest(code):
	var limit_code = clamp(code, 1, 8)
	var get_img = str("res://img/Item/Chest/00",limit_code,".png")
	return get_img
	
var recent_box = null
func reset_random_icon(code):
	parent_reward.show()
	if code != recent_box and is_pre_open==false:
		#var path = code == 1 ? img_random["basic"] : img_random["special"]
		var path = img_random["basic"] if code == 1 else img_random["special"]
		var tex = load(path)

		var children = pnl_parent.get_children()
		for i in range(children.size()):
			var img: TextureRect = children[i]
			img.texture = tex
			SfxManager.play_count()
			await get_tree().create_timer(0.05).timeout
		recent_box = code
func set_reward_img(code, code_box):
	match code_box:
		1:
			if code == 1: return img_chest(6)
			elif code <20: return img_chest(5)
			else: return img_chest(4)
		2:
			if code == 1: return img_chest(8)
			elif code <20: return img_chest(7)
			else: return img_chest(6)

var is_pre_open = false
var final_reward_code = null
func pre_open():
	if recent_box == null: return

	var curr_confirm
	match recent_box:
		1: curr_confirm = AutoloadData.player_reward
		2: curr_confirm = AutoloadData.player_reward_special
	if curr_confirm <= 0: return
	
	if recent_box == 1:
		AutoloadData.player_reward -= 1
	elif recent_box == 2:
		AutoloadData.player_reward_special -= 1
	AutoloadData.save_data()
	update_coin()

	#var arr_reward: Array[int] = []
	#for i in 16:
		#arr_reward.append(randi_range(1, 100))
	#
	#var get_reward = arr_reward[current_selected_reward-1]
	#if get_reward == 1: final_reward_code = 3
	#elif get_reward <= 20: final_reward_code = 2
	#else: final_reward_code = 1
	#
	#var children = pnl_parent.get_children()
	#for i in children.size():
		#var _img: TextureRect = children[i]
		#var arr_code = [1, 2, 3, 4, 5, 6, 7, 8]
		#var tween = create_tween()
		#var swap_count = clamp(randi_range(7, 12), 1, arr_code.size())
#
		#for ii in swap_count:
			#var arr_rng = arr_code.pick_random()
			#tween.tween_callback(func():
				#SfxManager.play_count()
				#_img.texture = load(img_chest(arr_rng))
			#).set_delay(ii * 0.02)
			#arr_code.erase(arr_rng)
#
		#tween.tween_callback(func():
			#_img.texture = load(set_reward_img(arr_reward[i], recent_box))
		#).set_delay(swap_count * 0.02 + 0.01)  # pasang final image setelah efek selesai
	#is_pre_open = true
	# ----------- TEST -------------
	var arr_reward: Array[int] = []
	for i in 16:
		arr_reward.append(randi_range(1, 100))

	var get_reward = arr_reward[current_selected_reward-1]
	if get_reward == 1: final_reward_code = 3
	elif get_reward <= 20: final_reward_code = 2
	else: final_reward_code = 1
	if current_box_selected == 1:
		match final_reward_code:
			3:AutoloadData.player_inventory_chest[6]+=1
			2:AutoloadData.player_inventory_chest[5]+=1
			1:AutoloadData.player_inventory_chest[4]+=1
	elif current_box_selected == 2:
		match final_reward_code:
			3:AutoloadData.player_inventory_chest[8]+=1
			2:AutoloadData.player_inventory_chest[7]+=1
			1:AutoloadData.player_inventory_chest[6]+=1
	AutoloadData.save_data()
	
	var children = pnl_parent.get_children()
	var total_duration = 3.0

	# Buat urutan chest berdasarkan current_selected_reward
	# current_selected_reward adalah yang terakhir, jadi mulai dari setelahnya
	var chest_order = []
	# Mulai dari current_selected_reward+1 sampai 16
	for i in range(current_selected_reward + 1, 17):
		chest_order.append(i - 1)  # convert ke index (0-15)
	# Lanjut dari 1 sampai current_selected_reward (terakhir)
	for i in range(1, current_selected_reward + 1):
		chest_order.append(i - 1)  # convert ke index (0-15)

	for i in chest_order.size():
		var chest_index = chest_order[i]
		var _img: TextureRect = children[chest_index]
		var arr_code = [1, 2, 3, 4, 5, 6, 7, 8]
		var swap_count = clamp(randi_range(7, 12), 1, arr_code.size())
		
		# Delay untuk setiap chest (chest ke-i dimulai pada waktu i * (3.0/16.0))
		var start_delay = i * (total_duration / 16.0)
		
		# Pastikan start_delay tidak 0 atau negatif
		if start_delay <= 0:
			start_delay = 0.01  # minimal 0.01 detik
		
		# Timer untuk memulai animasi chest ini
		var start_timer = Timer.new()
		add_child(start_timer)
		start_timer.wait_time = start_delay
		start_timer.one_shot = true
		start_timer.timeout.connect(_start_chest_animation.bind(chest_index, _img, arr_code, swap_count, arr_reward, i))
		start_timer.start()

func _start_chest_animation(chest_index: int, img: TextureRect, arr_code: Array, swap_count: int, reward_array: Array[int], order_index: int):
	_animate_chest_step(chest_index, img, arr_code, swap_count, 0, reward_array, order_index)

func _animate_chest_step(chest_index: int, img: TextureRect, arr_code: Array, swap_count: int, current_step: int, reward_array: Array[int], order_index: int):
	is_pre_open = true
	if current_step < swap_count:
		# Animasi swap
		if arr_code.size() > 0:
			var arr_rng = arr_code.pick_random()
			SfxManager.play_count()
			img.texture = load(img_chest(arr_rng))
			arr_code.erase(arr_rng)
		
		# Timer untuk step berikutnya
		var step_timer = Timer.new()
		add_child(step_timer)
		step_timer.wait_time = 0.02  # 0.02 detik per step seperti di code asli
		step_timer.one_shot = true
		step_timer.timeout.connect(func():
			step_timer.queue_free()
			_animate_chest_step(chest_index, img, arr_code, swap_count, current_step + 1, reward_array, order_index)
		)
		step_timer.start()
	else:
		# Set final image
		img.texture = load(set_reward_img(reward_array[chest_index], recent_box))
			
	# ----------- TEST -------------
	
# ------------------------ OPEN CHEST:START ----------------------------
@onready var node_btnc_x10open:CheckButton = $open_chest/btn_check_openx10
var current_chest_selected:int = 1
func chest_slide(_bool:bool):
	SfxManager.play_turn_select()
	match _bool:
		true: current_chest_selected-=1
		false: current_chest_selected+=1
	var limit_code = clamp(current_chest_selected, 1, 8)
	current_chest_selected = limit_code
	if current_chest_selected == 8: $open_chest/img_open_chest/anim.show()
	else: $open_chest/img_open_chest/anim.hide()
	var own = str("OWN: ",AutoloadData.player_inventory_chest[current_chest_selected])
	$open_chest/chest_own.text = own
	if AutoloadData.player_inventory_chest[current_chest_selected] < 10:
		node_btnc_x10open.button_pressed=false
	else: node_btnc_x10open.button_pressed=true
	var get_img:TextureRect=$open_chest/img_open_chest
	var path = str("res://img/Item/Chest/00",current_chest_selected,".png")
	get_img.texture = load(path)

var arr_list_chest:Array = []
var lobby_eq = Lobby_equipments.new()
var new_eq = Load_reward.new()

@onready var btn_list_open_chest = $open_chest/pnl_open_chest/pnl_btn/vbox
@onready var img_main_gear:TextureRect = $open_chest/pnl_open_chest/main_gear
@onready var pnl_openchest = $open_chest/pnl_open_chest
@onready var btn_open_chest_main = $open_chest/hbox/btn_open_chest
@onready var btn_sell:Button = $open_chest/pnl_open_chest/pnl_preview/hbox/vbox_main/hbox/btn_sell
var btn_sell_confirm:bool = false
var current_result_openchest = 1

func update_currecy():
	$open_chest/chest_own.text = str("OWN: ",AutoloadData.player_inventory_chest[current_chest_selected])
	$spin/history_senoak/vbox/hbox/count/gold.text = lobby_eq.filter_num_k(AutoloadData.player_money)
	$spin/history_senoak/vbox/hbox/count/spin_coin.text = lobby_eq.filter_num_k(AutoloadData.player_spin_coin)
	$spin/history_senoak/vbox/hbox/count/ticket.text = lobby_eq.filter_num_k(AutoloadData.player_super_ticket)
	$spin/history_senoak/vbox/hbox/count/mana.text = lobby_eq.filter_num_k(AutoloadData.player_exp)
func onready_open_chest():
	preview_openchest_reset()
	for i in btn_list_open_chest.get_child_count():
		var btn:Button = btn_list_open_chest.get_child(i)
		btn.connect("pressed", func():
			SfxManager.play_click()
			current_result_openchest = i+1
			btn_sell.text = "SELL"
			btn_sell_confirm=false
			btn_sell.disabled=false
			var btn_select:Button = btn_list_open_chest.get_child(i)
			btn_select.disabled = false
			preview_openchest(arr_list_chest[i]) )
	$open_chest/pnl_open_chest/btn_cls_openchest.connect("pressed", func():
		SfxManager.play_click()
		pnl_openchest.hide())
	btn_sell.connect("pressed", func():
		if btn_sell_confirm==false:
			SfxManager.play_click()
			btn_sell_confirm=true
			btn_sell.text = "CONFIRM"
		elif btn_sell_confirm:
			SfxManager.play_click()
			var get_coin_tosell = AutoloadData.player_equipment[ arr_list_chest[current_result_openchest-1] ]["sell"]
			AutoloadData.player_money += get_coin_tosell
			AutoloadData.player_equipment.erase(arr_list_chest[current_result_openchest-1])
			AutoloadData.save_data()
			update_currecy()
			$open_chest/pnl_open_chest/pnl_preview/hbox/vbox_main/hbox/price.text = str(
				"Selled: ",lobby_eq.filter_num_k(get_coin_tosell)," !"
			)
			btn_sell.text = "SELL"
			btn_sell_confirm=false
			btn_sell.disabled=true
			var btn_select:Button = btn_list_open_chest.get_child(current_result_openchest-1)
			btn_select.disabled=true )
	btn_open_chest_main.connect("pressed", func():
		if AutoloadData.player_inventory_chest[current_chest_selected] <= 0:
			anim_Player.play("gearchest_emty")
			SfxManager.play_system_fail()
			return
		open_chest(node_btnc_x10open.button_pressed) )

func open_chest(is_multiopen):
	current_result_openchest = 1
	preview_openchest_reset()
	pnl_openchest.show()
	# DISABLED ALL BTN SELECT (PREVIEW)
	for btn:Button in btn_list_open_chest.get_children():
		btn.disabled = true
	
	arr_list_chest = []
	$open_chest/pnl_open_chest/btn_cls_openchest.disabled=true
	if is_multiopen:
		for i in range(10):
			SfxManager.play_item_open()
			var eq = new_eq.eq_chest(current_chest_selected, i)
			arr_list_chest.append(eq["id_node"])
			var btn:Button = btn_list_open_chest.get_child(i)
			btn.disabled = false
			preview_openchest(arr_list_chest[i])
			btn_sell.disabled=true
			AutoloadData.player_inventory_chest[current_chest_selected]-=1
			AutoloadData.save_data()
			update_currecy()
			await get_tree().create_timer(.5).timeout
		if AutoloadData.player_inventory_chest[current_chest_selected] <10:
			node_btnc_x10open.button_pressed=false
		else:
			node_btnc_x10open.button_pressed=true
	else:
		SfxManager.play_item_open()
		var eq = new_eq.eq_chest(current_chest_selected, 0)
		arr_list_chest.append(eq["id_node"])
		var btn:Button = btn_list_open_chest.get_child(0)
		btn.disabled = false
		img_main_gear.texture = load(eq["icon_raw"])
		preview_openchest(arr_list_chest[current_result_openchest-1])
		AutoloadData.player_inventory_chest[current_chest_selected]-=1
		AutoloadData.save_data()
		update_currecy()
		if AutoloadData.player_inventory_chest[current_chest_selected] <10:
			node_btnc_x10open.button_pressed=false
		else:
			node_btnc_x10open.button_pressed=true
	$open_chest/pnl_open_chest/btn_cls_openchest.disabled = false

@onready var node_main = $open_chest/pnl_open_chest/pnl_preview/hbox/vbox_main
@onready var nodes_openchest_preview = {
	'name': node_main.get_node("name"),
	'type': node_main.get_node('type'),
	'rank': node_main.get_node('rank'),
	'enhance': node_main.get_node('enhance'),
	'price': node_main.get_node('hbox/price'),
	'btn_sell': node_main.get_node('hbox/btn_sell'),
	'stat_1': node_main.get_node('stat_1'),
	'stat_2': node_main.get_node('stat_2'),
	'stat_3': node_main.get_node('stat_3'),
	'desc': node_main.get_node('desc')
}
func preview_openchest(code_dict):
	var get_data = AutoloadData.player_equipment[code_dict]
	img_main_gear.texture = load(get_data["icon_raw"])
	nodes_openchest_preview["name"].text = get_data["name"]
	nodes_openchest_preview["type"].text = get_data["type"]
	nodes_openchest_preview["rank"].text = lobby_eq._set_string_color(get_data["grade_txt"], get_data["grade_color"])
	nodes_openchest_preview["enhance"].text = str(get_data["enhance_main"])
	nodes_openchest_preview["price"].text = lobby_eq._set_string_color(lobby_eq.filter_num_k(get_data["sell"]), "GOLD")
	
	var temp_stat = ["stat_1", "stat_2", "stat_3"]
	for set_stat in temp_stat:
		nodes_openchest_preview[set_stat].text = str(
			lobby_eq.stat_code_indic(get_data[set_stat]["stat_code"]),
			lobby_eq.stat_code(get_data[set_stat]["stat_code"],get_data[set_stat]["stat_main"])," ",
			lobby_eq.stat_code_tier(get_data[set_stat]["stat_grade"]) )
			
	nodes_openchest_preview["desc"].text = str( get_data["desc"],"\n",get_data["desc_uniq"] )
	
func preview_openchest_reset():
	nodes_openchest_preview["name"].text = ""
	nodes_openchest_preview["type"].text = ""
	nodes_openchest_preview["rank"].text = ""
	nodes_openchest_preview["enhance"].text = ""
	nodes_openchest_preview["price"].text = ""
	
	var temp_stat = ["stat_1", "stat_2", "stat_3"]
	for set_stat in temp_stat:
		nodes_openchest_preview[set_stat].text = ""
			
	nodes_openchest_preview["desc"].text = ""
# ------------------------ OPEN CHEST:END ----------------------------
# ----------------------------- REWARD OPEN:END -----------------------------

# --------------------------- VAULT:START -----------------------------
@onready var hbox_menu = $btn_cls_vault_menu/pnl_c/hbox_menu
@onready var btn_vault_main:Button = $btn_cls_vault_main
@onready var nodes_vault_main = {
	0:$btn_cls_vault_main/main_shop/scroll_c/hbox_gold, # GOLD
	1:$btn_cls_vault_main/main_shop/scroll_c/hbox_mana, # MANA
	2:$btn_cls_vault_main/main_shop/scroll_c/hbox_spin, # SPIN
	3:$btn_cls_vault_main/main_shop/scroll_c/hbox_ticket } # TICKET
@onready var btn_vault_menu:Button = $btn_cls_vault_menu
func onready_btn_vault():
	# btn action main
	for i in range(3):
		var num = 1
		for child in nodes_vault_main[i].get_children():
			var btn:Button = child.get_node("vbox/btn")
			btn.connect("pressed", func():
				vault_ask(i, num) )
			num+=1
	# btn show
	btn_vault_main.connect("pressed", func():
		SfxManager.play_click()
		btn_vault_main.hide()
		btn_vault_menu.show() )
	btn_vault_menu.connect("pressed", func():
		SfxManager.play_click()
		btn_vault_menu.hide())
	# btn main menu
	var num_vault_main = 0
	for i in hbox_menu.get_child_count():
		var btn:Button = hbox_menu.get_child(i).get_node("vbox/btn")
		btn.connect("pressed", func():
			SfxManager.play_click()
			btn_vault_menu.hide()
			btn_vault_main.show()
			for ii in nodes_vault_main.size():
				var hbox:HBoxContainer = nodes_vault_main[ii]
				hbox.visible = ii==num_vault_main )
		num_vault_main+=1
		
@onready var parent_ask = $parent_ask
@onready var prosed_ask = $parent_ask/prosed_ask
@onready var data_shop_value = {
	0:{1:100000, 2:250000, 3:750000, 4:2500000, 5:20000000, 6:75000000},
	1:{1:10000, 2:25000, 3:75000, 4:250000, 5:2000000, 6:7500000},
	2:{1:1, 2:3, 3:7, 4:15, 5:40, 6:100}, }
@onready var data_shop_price = {
	0:{1:100, 2:200, 3:500, 4:1000, 5:5000, 6:10000},
	1:{1:100, 2:200, 3:500, 4:1000, 5:5000, 6:10000},
	2:{1:1000, 2:2500, 3:5000, 4:10000, 5:25000, 6:50000}, }
	
func vault_process(code_curr, code_lv, node_to_free:Node):
	var code = clamp(code_curr, 0, 3)
	var limit = clamp(code_lv, 1, 6)
	
	if AutoloadData.player_super_ticket < data_shop_price[code][limit]: 
		SfxManager.play_system_fail()
		return
	SfxManager.play_money()
	match code:
		0:
			AutoloadData.player_super_ticket -= data_shop_price[code][limit]
			AutoloadData.player_money += data_shop_value[code][limit]
		1:
			AutoloadData.player_super_ticket -= data_shop_price[code][limit]
			AutoloadData.player_exp += data_shop_value[code][limit]
		2:
			AutoloadData.player_super_ticket -= data_shop_price[code][limit]
			AutoloadData.player_spin_coin += data_shop_value[code][limit]
	AutoloadData.save_data()
	update_currecy()
	update_coin()
	node_to_free.queue_free()

func vault_ask(code_curr, code_lv):
	SfxManager.play_item_open()
	var code = clamp(code_curr, 0, 3)
	var limit = clamp(code_lv, 1, 6)
	var dict_desc = {0:" (Gold)",1:" (Mana)",2:" (Spin Coin)"}
	var price_total = lobby_eq.filter_num_k(data_shop_price[code][limit])
	var value_total = lobby_eq.filter_num_k(data_shop_value[code][limit])
	
	var new_ask = prosed_ask.duplicate()
	new_ask.show()
	var ask_main_desc:Label = new_ask.get_node("vbox/main_desc")
	ask_main_desc.text = str(
		"Confirm the transaction to be continued as follows: \n",
		"Item: ",value_total,dict_desc[code],"\n",
		"Price: ",price_total," (Super Ticket)\n",
		"Super tickets remaining: ", lobby_eq.filter_num_k(AutoloadData.player_super_ticket)
	)
	
	var ask_btn_yes:Button = new_ask.get_node("vbox/hbox/btn_yes")
	var ask_btn_no:Button = new_ask.get_node("vbox/hbox/btn_no")
	ask_btn_no.connect("pressed", func():
		SfxManager.play_item_close()
		new_ask.queue_free() )
	ask_btn_yes.connect("pressed", vault_process.bind(code_curr, code_lv, new_ask) )
	parent_ask.add_child(new_ask)
	
	
# --------------------------- VAULT:END -----------------------------

# ---------------------------- BTN -------------------------------
func _on_btn_spin_pressed() -> void:
	$spin.visible=true
	$bg.texture = load("res://img/Shop/bg_spin.png")
	SfxManager.play_click()
func _on_btn_vault_pressed() -> void:
	btn_vault_menu.show()
	$bg.texture = load("res://img/Shop/bg_vault.png")
	SfxManager.play_click()
func _on_btn_chest_pressed() -> void:
	$open_chest.visible = true
	$bg.texture = load("res://img/Shop/bg_chest.png")
	SfxManager.play_click()
func _on_btn_spin_roll_pressed() -> void:
	spin()
func _on_btn_cls_pressed() -> void:
	reward_dash.hide()
	update_tweex_txt(temp_gold, AutoloadData.player_money, wallet_node["gold"])
	update_tweex_txt(temp_mana, AutoloadData.player_exp, wallet_node["mana"])
var current_box_selected
func _on_btn_reward_r_pressed() -> void:
	if AutoloadData.player_reward <= 0:
		anim_Player.play("reward_r_faild")
		SfxManager.play_system_fail()
	else:
		reset_random_icon(1)
		current_box_selected=1
func _on_btn_reward_s_pressed() -> void:
	if AutoloadData.player_reward_special <= 0:
		anim_Player.play("reward_s_faild")
		SfxManager.play_system_fail()
	else:
		reset_random_icon(2)
		current_box_selected=2
func _on_btn_cls_reward_pressed() -> void:
	parent_reward.hide()
func _on_pre_open_pressed() -> void:
	if current_selected_reward == null: return
	pre_open()
	btn_pre_open.disabled = true
	await get_tree().create_timer(3).timeout
	btn_reward_confirm.disabled = false
func _on_reward_confirm_pressed() -> void:
	btn_pre_open.disabled = false
	btn_reward_confirm.disabled = true
	select_main.hide()
	parent_reward.hide()
	is_pre_open = false
	current_selected_reward = null
	recent_box = null
	final_reward_code = null
func _on_btn_reset_bg_pressed() -> void:
	$bg.texture = load("res://img/Shop/bg_default.png")
func _on_chest_prev_pressed() -> void:
	chest_slide(true)
func _on_chest_next_pressed() -> void:
	chest_slide(false)
func _on_btn_check_openx_10_pressed() -> void:
	var chest_count = AutoloadData.player_inventory_chest[current_chest_selected]
	if chest_count < 10 and node_btnc_x10open.button_pressed: node_btnc_x10open.button_pressed=false
func _on_btn_cls_open_chest_pressed() -> void:
	$open_chest.visible = false
func _on_btn_exit_pressed() -> void:
	SceneManager.move_to_scene(SceneManager.ENUM_SCENE.LOBBY)
