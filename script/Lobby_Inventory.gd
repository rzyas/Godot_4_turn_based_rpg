extends Node2D
class_name Lobby_inventory

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

var new_reward_data = Load_reward.new()
func new_inven_item(_main_loop, main_dict, _name, _icon, _type, _desc, _own, _prosed, _parent):
	if main_dict["own"] == 0: return
	var new_item:PanelContainer = _prosed.duplicate()
	var get_img:TextureRect = new_item.get_node("vbox/icon")
	var get_count:Label = new_item.get_node("vbox/count")
	var get_btn:Button = new_item.get_node("vbox/count/btn")
	
	get_img.texture = main_dict["icon"]
	get_count.text = filter_num_k(main_dict["own"])
	
	var preview_name:Label = _name
	var preview_icon:TextureRect = _icon
	var preview_type:Label = _type
	var preview_desc:RichTextLabel = _desc
	var preview_own:Label = _own
	
	get_btn.connect("pressed", func():
		preview_name.text = main_dict["name"]
		preview_icon.texture = main_dict["icon"]
		preview_type.text = main_dict["type"]
		preview_desc.text = main_dict["desc"]
		preview_own.text = str("OWN: ",filter_num_k(main_dict["own"])) )
	#if main_dict["own"] == 0: new_item.hide()
	#else: new_item.show()
	new_item.show()
	#new_item.name = str(main_dict["id_node"]) + str(_main_loop)
	_parent.add_child(new_item)
	
func load_all_inven(_name, _icon, _type, _desc, _own, _prosed, _parent):
	for i in range(1, 4):
		var get_dict = new_reward_data._inventory_currency(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)
	for i in range(1, AutoloadData.player_inventory_card_gacha.size()+1):
		var get_dict = new_reward_data._inventory_card_gacha(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)
	for i in range(1, AutoloadData.player_inventory_chest.size()+1):
		var get_dict = new_reward_data._inventory_chest_dict(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)
	for i in range(1, AutoloadData.player_inventory_enhance.size()+1):
		var get_dict = new_reward_data._inventory_enhance_dict(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)
	for i in range(1, AutoloadData.player_inventory_fragment.size()+1):
		var get_dict = new_reward_data._inventory_frag_dict(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)
	for i in range(1, AutoloadData.player_inventory_misc.size()+1):
		var get_dict = new_reward_data._inventory_misc_dict(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)
	for i in range(1, AutoloadData.player_inventory_token.size()+1):
		var get_dict = new_reward_data._inventory_token_dict(i)
		new_inven_item(i, get_dict, _name, _icon, _type, _desc, _own, _prosed, _parent)

func _inven_btn_switch(code, main_dict):
	var img_data = Load_images.new()
	for i in range(1, 4):
		main_dict[i]["_bool"] = (i==code)
		main_dict[i]["item_content"].visible = (i==code)
		main_dict[i]["id_node"].icon = img_data.img_inven[i][main_dict[i]["_bool"]]
func inven_btn_switch(main_dict):
	main_dict[1]["id_node"].connect("pressed", func():
		_inven_btn_switch(1, main_dict)
		main_dict[1]["action"].call()
		main_dict["preview"].visible = true)
	main_dict[2]["id_node"].connect("pressed", func():
		_inven_btn_switch(2, main_dict)
		main_dict["preview"].visible = false)
	main_dict[3]["id_node"].connect("pressed", func():
		_inven_btn_switch(3, main_dict)
		main_dict["preview"].visible = false )
