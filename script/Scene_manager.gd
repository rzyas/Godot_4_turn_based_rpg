extends Node

enum ENUM_SCENE { LOBBY, BATTLE, SHOP }

var list_scene = {
	ENUM_SCENE.LOBBY: 'res://scenes/Lobby.tscn',
	ENUM_SCENE.BATTLE: 'res://scenes/Battle_scene.tscn',
	ENUM_SCENE.SHOP: 'res://scenes/Shop.tscn'
}

func move_to_scene(set_scene: ENUM_SCENE):
	if not list_scene.has(set_scene):
		push_error('Scene not found for enum: %s' % str(set_scene))
		return
	
	var get_scene_path = list_scene[set_scene]
	
	# Simpan data scene jika perlu untuk loading screen
	AutoloadData.scene_data = get_scene_path
	
	# Pindah ke loading screen
	get_tree().change_scene_to_file('res://scenes/new_loading_screen.tscn')
