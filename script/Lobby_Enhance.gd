extends Node2D
class_name  Lobby_Enhance

func play_enhance_spell(node: TextureRect) -> void:
	node.visible = true
	node.rotation_degrees = 0.0
	node.modulate.a = 1.0  # pastikan tidak transparan sebelum mulai

	var _tween_enhance = get_tree().create_tween()
	_tween_enhance.set_parallel(true)

	# Rotasi 360 derajat selama 3 detik
	_tween_enhance.tween_property(node, "rotation_degrees", 360.0, 1.0).set_trans(Tween.TRANS_LINEAR)

	# Fade out selama 3 detik juga (berjalan bersamaan)
	_tween_enhance.tween_property(node, "modulate:a", 0.0, 3.0).set_trans(Tween.TRANS_LINEAR)

	await _tween_enhance.finished
	node.hide()
