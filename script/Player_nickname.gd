extends Node2D
@onready var pnl_main = $main_pnl_start
func _ready() -> void:
	onready_main()

func _get_reward(code, value):
	match code:
		"gold": AutoloadData.player_money+=value
		"mana": AutoloadData.player_exp+=value
		"ticket": AutoloadData.player_super_ticket+=value
		"spin": AutoloadData.player_spin_coin+=value
	AutoloadData.save_data()
func form_alert(line_edit_node: LineEdit) -> void:
	SfxManager.play_system_fail()
	var tween := create_tween()
	tween.tween_property(line_edit_node, "self_modulate", Color.RED, 0.3)
	tween.tween_interval(1.0)
	tween.tween_property(line_edit_node, "self_modulate", Color.WHITE, 0.3)
func onready_main():
	var node_nickname:LineEdit = pnl_main.get_node("vbox/hbox/vbox_main/enter_nickname")
	var node_code:LineEdit = pnl_main.get_node("vbox/hbox/vbox_main/enter_code_promp")
	var node_code_desc:Label = pnl_main.get_node("vbox/pnl_1/txt_confirm_code")
	var node_btn_checkcode:Button = pnl_main.get_node("vbox/btn_check_code")
	var node_check_gold:CheckButton = pnl_main.get_node("vbox/pnl_0/vbox/reward_0/sw_gold")
	var node_check_mana:CheckButton = pnl_main.get_node("vbox/pnl_0/vbox/reward_1/sw_mana")
	var node_check_ticket:CheckButton = pnl_main.get_node("vbox/pnl_0/vbox/reward_2/sw_ticket")
	var node_check_spin:CheckButton = pnl_main.get_node("vbox/pnl_0/vbox/reward_3/sw_spin")
	var node_btn_entergame:Button = pnl_main.get_node("vbox/btn_enter_game")
	
	# -----------------------------------------------
	# STARTED REWARD
	# -----------------------------------------------
	var all_sw = [node_check_gold, node_check_mana, node_check_ticket, node_check_spin]
	var started_code:int=0
	for i in all_sw.size():
		var btn_sw: CheckButton = all_sw[i]
		btn_sw.connect("pressed", func(i_copy := i):
			for j in all_sw.size():
				all_sw[j].button_pressed = j == i_copy
				if j == i_copy:
					started_code = j
		)
	# -------------------------------------------------
	# CODE
	# -------------------------------------------------
	node_btn_checkcode.connect('pressed', func():
		var get_enter_code = node_code.text
		
		# Cek apakah kode ada di daftar reward
		if AutoloadData.player_started_reward.has(get_enter_code):
			# Ambil data reward
			var reward_data = AutoloadData.player_started_reward[get_enter_code]
			var get_id_reward = reward_data['id']
			var get_count_reward = reward_data['count']
			var get_desc_reward = reward_data['desc']
			var get_confirm_code = AutoloadData.player_started_reward[get_enter_code]["claim"]
			
			if get_confirm_code==false:
				AutoloadData.player_started_reward[get_enter_code]["claim"]=true
				AutoloadData.save_data()
				_get_reward(get_id_reward, get_count_reward)
				node_code_desc.text = get_desc_reward
			else:
				node_code_desc.text = 'Code already claimed! One time only.'
		else:
			# Kode tidak ditemukan
			SfxManager.play_system_fail()
			node_code_desc.text = 'Sorry, the code you entered is wrong.'
	)

	# -------------------------------------------------
	# ENTER GAME
	# -------------------------------------------------
	node_btn_entergame.connect("pressed", func():
		if node_nickname.text.length() <=3:
			form_alert(node_nickname) )
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
