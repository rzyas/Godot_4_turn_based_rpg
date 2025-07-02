extends Node2D

@onready var main_hit: Node2D = $"."
@onready var vfx_hit: AnimatedSprite2D = $VFX_hit

enum ENUM_ELEMENT {LIGHT, NATURE, WATER, DARK, FIRE}
enum ENUM_CLASS {WARR, ARC, KNI, ASSA, SUPP, MECH, BEAST, WIZZ, HEAL}

func get_random_int(min_value: int, max_value: int) -> int:
	return randi_range(min_value, max_value)

func on_timeout():
	print("Timer selesai!")

func remove_anim():
	if is_instance_valid(vfx_hit):
		vfx_hit.stop()
		vfx_hit.frame = 0
		vfx_hit.hide()  # Sembunyikan VFX

func play_single_vfx(animation: String):
	var rand_x = get_random_int(-100, 100)
	var rand_y = get_random_int(-100, 100)
	var rand_r = get_random_int(0, 360)
	
	main_hit.position = Vector2(rand_x, rand_y)
	main_hit.rotation = rand_r
	main_hit.scale = Vector2(5, 5)
	
	vfx_hit.show()  # Tampilkan VFX sebelum memainkan animasi
	vfx_hit.play(animation)
	
	# Disconnect the signal first if it's already connected
	if vfx_hit.is_connected("animation_finished", Callable(self, "remove_anim")):
		vfx_hit.disconnect("animation_finished", Callable(self, "remove_anim"))
	
	# Connect the signal using Callable in Godot 4.3+
	vfx_hit.connect("animation_finished", Callable(self, "remove_anim"))

func play_vfx2dhit(code: String, loop: int, _class):
	for i in range(loop):
		play_single_vfx(code)
		play_sfx(_class)
		# Wait for the animation to finish before starting the next one
		await vfx_hit.animation_finished
		
		# Add a small delay between animations if needed
		#if i < loop - 1:  # Don't wait after the last animation
		#	await get_tree().create_timer(0.1).timeout
	
	# Setelah semua animasi selesai, hapus VFX
	queue_free()

# --- SFX ---
func play_sfx(_class):
	var sfx_manager = preload("res://scenes/sfx_manager.tscn").instantiate()
	add_child(sfx_manager)
	if _class == ENUM_CLASS.ARC: sfx_manager.sfx_arrow()
	elif _class == ENUM_CLASS.WARR: sfx_manager.sfx_random_sword()
	elif _class == ENUM_CLASS.KNI: sfx_manager.sfx_random_sword()
	elif _class == ENUM_CLASS.ASSA: sfx_manager.sfx_random_dagger()
	elif _class == ENUM_CLASS.MECH: sfx_manager.sfx_random_dagger()
	elif _class == ENUM_CLASS.SUPP: sfx_manager.sfx_magic_spell()
	elif _class == ENUM_CLASS.WIZZ: sfx_manager.sfx_magic_spell()
	elif _class == ENUM_CLASS.HEAL: sfx_manager.sfx_magic_spell()
	elif _class == ENUM_CLASS.BEAST: sfx_manager.sfx_random_claw()
	else: print("ERROR: ON PLAY SFX")
	await get_tree().create_timer(3).timeout
	sfx_manager.queue_free()

func get_vfxhit(elem, _class):
	if _class == ENUM_CLASS.ARC:
		#play_sfx(ENUM_CLASS.ARC, 4)
		if elem == ENUM_ELEMENT.DARK: play_vfx2dhit("hit_arc_dark", 1, ENUM_CLASS.ARC)
		elif elem == ENUM_ELEMENT.FIRE: play_vfx2dhit("hit_arc_fire", 1, ENUM_CLASS.ARC)
		elif elem == ENUM_ELEMENT.LIGHT: play_vfx2dhit("hit_arc_light", 1, ENUM_CLASS.ARC)
		elif elem == ENUM_ELEMENT.NATURE: play_vfx2dhit("hit_arc_nature", 1, ENUM_CLASS.ARC)
		elif elem == ENUM_ELEMENT.WATER: play_vfx2dhit("hit_arc_water", 1, ENUM_CLASS.ARC)
		else: print("func getvfxhit on class: Get_vfx2dhit ERROR")
	elif _class == ENUM_CLASS.ASSA or _class == ENUM_CLASS.MECH:
		var rng = get_random_int(3, 6)
		#play_sfx(ENUM_CLASS.ASSA, rng)
		if elem == ENUM_ELEMENT.DARK: play_vfx2dhit("hit_assa_dark", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.FIRE: play_vfx2dhit("hit_assa_fire", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.LIGHT: play_vfx2dhit("hit_assa_light", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.NATURE: play_vfx2dhit("hit_assa_nature", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.WATER: play_vfx2dhit("hit_assa_water", rng, ENUM_CLASS.ASSA)
		else: print("func getvfxhit on class: Get_vfx2dhit ERROR")
	elif _class == ENUM_CLASS.BEAST:
		var rng = get_random_int(3, 6)
		#play_sfx(ENUM_CLASS.BEAST, rng)
		if elem == ENUM_ELEMENT.DARK: play_vfx2dhit("hit_beast_dark", rng, ENUM_CLASS.BEAST)
		elif elem == ENUM_ELEMENT.FIRE: play_vfx2dhit("hit_beast_fire", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.LIGHT: play_vfx2dhit("hit_beast_light", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.NATURE: play_vfx2dhit("hit_beast_nature", rng, ENUM_CLASS.ASSA)
		elif elem == ENUM_ELEMENT.WATER: play_vfx2dhit("hit_beast_water", rng, ENUM_CLASS.ASSA)
		else: print("func getvfxhit on class: Get_vfx2dhit ERROR")
	elif _class == ENUM_CLASS.WIZZ or _class == ENUM_CLASS.SUPP or _class == ENUM_CLASS.HEAL:
		#play_sfx(ENUM_CLASS.WIZZ, 1)
		if elem == ENUM_ELEMENT.DARK: play_vfx2dhit("hit_mage_dark", 1, ENUM_CLASS.WIZZ)
		elif elem == ENUM_ELEMENT.FIRE: play_vfx2dhit("hit_mage_fire", 1, ENUM_CLASS.WIZZ)
		elif elem == ENUM_ELEMENT.LIGHT: play_vfx2dhit("hit_mage_light", 1, ENUM_CLASS.WIZZ)
		elif elem == ENUM_ELEMENT.NATURE: play_vfx2dhit("hit_mage_nature", 1, ENUM_CLASS.WIZZ)
		elif elem == ENUM_ELEMENT.WATER: play_vfx2dhit("hit_mage_water", 1, ENUM_CLASS.WIZZ)
		else: print("func getvfxhit on class: Get_vfx2dhit ERROR")
	elif _class == ENUM_CLASS.WARR or _class == ENUM_CLASS.KNI:
		var count_hit = 2 if _class == ENUM_CLASS.WARR else 1
		#play_sfx(ENUM_CLASS.ASSA, count_hit)
		if elem == ENUM_ELEMENT.DARK: play_vfx2dhit("hit_mele_dark", count_hit, ENUM_CLASS.WARR)
		elif elem == ENUM_ELEMENT.FIRE: play_vfx2dhit("hit_mele_fire", count_hit, ENUM_CLASS.WARR)
		elif elem == ENUM_ELEMENT.LIGHT: play_vfx2dhit("hit_mele_light", count_hit, ENUM_CLASS.WARR)
		elif elem == ENUM_ELEMENT.NATURE: play_vfx2dhit("hit_mele_nature", count_hit, ENUM_CLASS.WARR)
		elif elem == ENUM_ELEMENT.WATER: play_vfx2dhit("hit_mele_water", count_hit, ENUM_CLASS.WARR)
		else: print("func getvfxhit on class: Get_vfx2dhit ERROR")
	else: print("func getvfxhit on class: Get_vfx2dhit ERROR")
