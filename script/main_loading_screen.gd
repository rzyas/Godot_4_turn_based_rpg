extends Control

const arr_txt = ["LOADING", "LOADING.", "LOADING..", "LOADING...", "LOADING....", "LOADING....."]

func get_random_int(_min: int, _max: int) -> int:
	# Validasi untuk memastikan min lebih kecil atau sama dengan max
	if _min > _max:
		push_error("Parameter 'min' must not be greater than 'max'.")
		return _min
	# Menghasilkan angka acak antara min dan max (inklusif)
	return randi_range(_min, _max)

var all_img_bgscr = [
	"res://img/Base Card/Loading Screen/1.jpeg",
	"res://img/Base Card/Loading Screen/2.jpeg",
	"res://img/Base Card/Loading Screen/3.jpeg",
	"res://img/Base Card/Loading Screen/4.jpeg",
	"res://img/Base Card/Loading Screen/5.jpeg",
	"res://img/Base Card/Loading Screen/6.jpeg",
	"res://img/Base Card/Loading Screen/7.jpeg",
	"res://img/Base Card/Loading Screen/8.jpeg",
	"res://img/Base Card/Loading Screen/9.jpeg",
	"res://img/Base Card/Loading Screen/10.jpeg",
	"res://img/Base Card/Loading Screen/11.jpeg",
	"res://img/Base Card/Loading Screen/12.jpeg",
	"res://img/Base Card/Loading Screen/13.jpeg",
	"res://img/Base Card/Loading Screen/14.jpeg",
	"res://img/Base Card/Loading Screen/15.jpeg",
	"res://img/Base Card/Loading Screen/16.jpeg",
	"res://img/Base Card/Loading Screen/17.jpeg",
	"res://img/Base Card/Loading Screen/18.jpeg",
	"res://img/Base Card/Loading Screen/19.jpeg",
	"res://img/Base Card/Loading Screen/21.jpeg",
	"res://img/Base Card/Loading Screen/22.jpeg",
	"res://img/Base Card/Loading Screen/23.jpeg",
	"res://img/Base Card/Loading Screen/24.jpeg",
	"res://img/Base Card/Loading Screen/25.jpeg",
	"res://img/Base Card/Loading Screen/26.jpeg",
]

var progress: Array = []
var scenes_name: String = "res://scenes/Battle_scene.tscn"
var scene_load_status = 0
var count_reset = 0
var current_progress: float = 0.0
var smooth_progress: float = 0.0

@onready var load_txt = $loading_txt
@onready var loading_count = $loading_count
@onready var main_bg_scr = $bg_loading_scrn

func _ready():
	$prog_bar_loading.show_percentage = false
	var get_max_value = all_img_bgscr.size() - 1
	var rng_img = get_random_int(0, get_max_value)
	main_bg_scr.texture = load(str(all_img_bgscr[rng_img]))
	ResourceLoader.load_threaded_request(scenes_name)
	
	var loading_timer = Timer.new()
	add_child(loading_timer)
	loading_timer.wait_time = 0.2
	loading_timer.timeout.connect(update_loading_text)
	loading_timer.start()

func update_loading_text():
	if scene_load_status != ResourceLoader.THREAD_LOAD_LOADED:
		if count_reset >= 5: 
			count_reset = 0
		load_txt.text = arr_txt[count_reset]
		count_reset += 1
func _process(delta):
	if scenes_name.is_empty():
		return
	
	scene_load_status = ResourceLoader.load_threaded_get_status(scenes_name, progress)
	smooth_progress = lerp(smooth_progress, progress[0] if not progress.is_empty() else 0.0, delta * 5.0)
	if smooth_progress < 1:
		$prog_bar_loading.value = smooth_progress * 100
		loading_count.text = str(floor(smooth_progress * 100 + 1)) + "%"
	else:
		print("DONT OWKOWKOWK")
		$prog_bar_loading.visible = false
		loading_count.visible = false
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and smooth_progress > 0.99:
		var new_scene = ResourceLoader.load_threaded_get(scenes_name)
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(new_scene)
