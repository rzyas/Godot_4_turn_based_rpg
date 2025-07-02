extends Control

var get_scene_tomove = AutoloadData.scene_data

@onready var main_data = {
		"txt_loading": $main/vbox/txt,
		"prog": $main/vbox/hbox/prog,
		"txt_pct": $main/vbox/hbox/txt
	}

var total_steps = 0
var is_loading_complete = false
var loading_stages = [
	"Initializing resource loader...",
	"Loading scene dependencies...",
	"Processing textures and materials...",
	"Loading audio resources...", 
	"Compiling scripts...",
	"Building scene tree...",
	"Finalizing resource loading..."
]
var current_stage = 0

func _ready():
	is_loading_complete = false
	update_loading_info(0.0)
	
	# Pastikan progress bar dikonfigurasi dengan benar
	main_data["prog"].min_value = 0.0
	main_data["prog"].max_value = 1.0
	main_data["prog"].value = 0.0
	main_data["prog"].step = 0.01  # Untuk smoothness
	
	main_data["txt_pct"].text = "0%"
	start_loading(get_scene_tomove)

func update_loading_info(progress: float):
	# Informasi memori dan performance
	var memory_static = Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0
	var memory_static_max = Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / 1024.0 / 1024.0
	var object_count = Performance.get_monitor(Performance.OBJECT_COUNT)
	var fps = Engine.get_frames_per_second()
	
	# Tentukan stage berdasarkan progress
	var stage_index = int(progress * (loading_stages.size() - 1))
	stage_index = clamp(stage_index, 0, loading_stages.size() - 1)
	current_stage = stage_index
	
	# Format informasi loading
	var scene_name = get_scene_tomove.get_file().get_basename()
	var loading_text = "%s\n" % loading_stages[current_stage]
	loading_text += "Scene: %s\n" % scene_name
	loading_text += "Memory: %.1f MB (Peak: %.1f MB)\n" % [memory_static, memory_static_max]
	loading_text += "Objects: %d | FPS: %d" % [object_count, fps]
	
	main_data["txt_loading"].text = loading_text

func start_loading(path):
	if path == "":
		main_data["txt_loading"].text = "Error: Scene path not set.\nCheck AutoloadData.scene_data"
		return
	
	update_loading_info(0.0)
	
	var error = ResourceLoader.load_threaded_request(path)
	if error != OK:
		var error_text = "Failed to start loading.\nError Code: %d\nPath: %s" % [error, path]
		main_data["txt_loading"].text = error_text
		return
	
	set_process(true)

func _process(delta):
	# Jika loading sudah selesai, jangan proses lagi
	if is_loading_complete:
		return
		
	var progress_array = []
	var status = ResourceLoader.load_threaded_get_status(get_scene_tomove, progress_array)
	
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var raw_progress = progress_array[0] if progress_array.size() > 0 else 0.0
		
		# Normalisasi progress ke range 0-1
		var normalized_progress = clamp(raw_progress, 0.0, 1.0)
		
		# Jika sudah mencapai 100%, langsung set sebagai loaded
		if normalized_progress >= 1.0:
			is_loading_complete = true
			complete_loading()
			return
		
		# Update loading info dengan progress terkini
		update_loading_info(normalized_progress)
		
		# Update progress bar
		main_data["prog"].value = normalized_progress
		
		# Update text percentage
		var percentage = int(normalized_progress * 100)
		main_data["txt_pct"].text = str(percentage) + "%"
		
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		is_loading_complete = true
		complete_loading()
		
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		is_loading_complete = true
		main_data["txt_loading"].text = "Loading Failed!\nCheck console for details.\nPath: %s" % get_scene_tomove
		set_process(false)
		
	elif status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		# Hanya tampilkan error jika loading belum pernah selesai
		if not is_loading_complete:
			main_data["txt_loading"].text = "Invalid Resource!\nPath does not exist:\n%s" % get_scene_tomove
			set_process(false)

func complete_loading():
	# Set progress ke 100%
	main_data["prog"].value = 1.0
	main_data["txt_pct"].text = "100%"
	
	# Update final loading info
	var scene_name = get_scene_tomove.get_file().get_basename()
	var memory_static = Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0
	var object_count = Performance.get_monitor(Performance.OBJECT_COUNT)
	main_data["txt_loading"].text = "Loading Successfully!\nScene: %s\nFinal Memory: %.1f MB\nObjects: %d\nTransitioning..." % [scene_name, memory_static, object_count]
	
	var scene = ResourceLoader.load_threaded_get(get_scene_tomove)
	if scene is PackedScene:
		# Beri sedikit delay agar user bisa melihat info final
		await get_tree().create_timer(0.8).timeout
		transition_to(scene)
	else:
		main_data["txt_loading"].text = "Error: Loaded resource is not a scene.\nType: %s" % scene.get_class()
	set_process(false)

func transition_to(scene):
	get_tree().change_scene_to_packed(scene)
