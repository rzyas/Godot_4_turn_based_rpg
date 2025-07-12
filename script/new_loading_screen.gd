extends Control

# ========================================
# LOADING SCREEN CONTROLLER
# ========================================
# Script untuk mengelola loading screen dengan performance monitoring
# dan threaded resource loading yang optimal

# ========================================
# VARIABLES & CONFIGURATION
# ========================================

# Scene target yang akan di-load
var get_scene_tomove
func set_main_scene():
	if AutoloadData.player_set_nickname == false:
		AutoloadData.reset_data()
		AutoloadData.scene_data = "res://scenes/Player_nickname.tscn"
		AutoloadData.player_set_nickname = true
		AutoloadData.save_data()
# Cache UI elements untuk performa lebih baik
@onready var main_data = {
		"txt_loading": $main/vbox/txt,
		"prog": $main/vbox/hbox/prog,
		"txt_pct": $main/vbox/hbox/txt }
# Loading state management
var is_loading_complete: bool = false
var last_progress: float = -1.0  # Cache progress terakhir untuk menghindari update berulang
var update_interval: float = 0.1  # Interval update UI (dalam detik)
var last_update_time: float = 0.0  # Timestamp update terakhir (dalam milliseconds)

# Performance monitoring cache
var performance_cache = {
	"memory_static": 0.0,
	"memory_static_max": 0.0,
	"object_count": 0,
	"fps": 0 }
# Loading stages untuk feedback visual
var loading_stages: Array[String] = [
	"Initializing resource loader...",
	"Loading scene dependencies...",
	"Processing textures and materials...",
	"Loading audio resources...", 
	"Compiling scripts...",
	"Building scene tree...",
	"Finalizing resource loading..." ]
var current_stage: int = 0
# ========================================
# INITIALIZATION
# ========================================
func _ready() -> void:
	AutoloadData.load_data()
	set_main_scene()
	get_scene_tomove = AutoloadData.scene_data
	# Inisialisasi autoload data
	AutoloadData.load_data()
	# Konfigurasi progress bar untuk optimal performance
	_setup_progress_bar()
	# Inisialisasi UI state
	_initialize_ui()
	# Mulai proses loading
	start_loading(get_scene_tomove)
# Setup progress bar dengan konfigurasi optimal
func _setup_progress_bar() -> void:
	var progress_bar = main_data["prog"]
	progress_bar.min_value = 0.0
	progress_bar.max_value = 1.0
	progress_bar.value = 0.0
	progress_bar.step = 0.01  # Smooth progress updates
	# Disable progress bar animation untuk performa lebih baik
	if progress_bar.has_method("set_allow_greater"):
		progress_bar.set_allow_greater(false)
	if progress_bar.has_method("set_allow_lesser"):
		progress_bar.set_allow_lesser(false)
# Inisialisasi state UI awal
func _initialize_ui() -> void:
	main_data["txt_pct"].text = "0%"
	main_data["txt_loading"].text = "Preparing to load..."
# ========================================
# PERFORMANCE MONITORING
# ========================================
# Update performance metrics dengan caching untuk efisiensi
func _update_performance_cache() -> void:
	# Update cache performance metrics
	performance_cache.memory_static = Performance.get_monitor(Performance.MEMORY_STATIC) / 1024.0 / 1024.0
	performance_cache.memory_static_max = Performance.get_monitor(Performance.MEMORY_STATIC_MAX) / 1024.0 / 1024.0
	performance_cache.object_count = Performance.get_monitor(Performance.OBJECT_COUNT)
	performance_cache.fps = Engine.get_frames_per_second()
# Generate informasi loading yang optimal
func _generate_loading_info(progress: float) -> String:
	# Tentukan stage berdasarkan progress
	var stage_index = int(progress * (loading_stages.size() - 1))
	stage_index = clamp(stage_index, 0, loading_stages.size() - 1)
	current_stage = stage_index
	# Format informasi loading dengan string builder pattern
	var info_parts: Array[String] = []
	# Stage info
	info_parts.append(loading_stages[current_stage])
	# Scene info
	var scene_name = get_scene_tomove.get_file().get_basename()
	info_parts.append("Scene: %s" % scene_name)
	# Memory info
	info_parts.append("Memory: %.1f MB (Peak: %.1f MB)" % [
		performance_cache.memory_static, 
		performance_cache.memory_static_max
	])
	# Performance info
	info_parts.append("Objects: %d | FPS: %d" % [
		performance_cache.object_count, 
		performance_cache.fps
	])
	return "\n".join(info_parts)
# ========================================
# LOADING MANAGEMENT
# ========================================
# Mulai proses loading dengan error handling
func start_loading(path: String) -> void:
	# Validasi path
	if path.is_empty():
		_show_error("Error: Scene path not set.\nCheck AutoloadData.scene_data")
		return
	# Validasi file existence
	if not FileAccess.file_exists(path):
		_show_error("Error: Scene file does not exist.\nPath: %s" % path)
		return
	# Update initial loading info
	_update_performance_cache()
	main_data["txt_loading"].text = _generate_loading_info(0.0)
	# Mulai threaded loading
	var error = ResourceLoader.load_threaded_request(path)
	if error != OK:
		_show_error("Failed to start loading.\nError Code: %d\nPath: %s" % [error, path])
		return
	# Aktifkan process loop
	set_process(true)
	print("Loading started for: %s" % path)
# Tampilkan error dengan format yang konsisten
func _show_error(message: String) -> void:
	main_data["txt_loading"].text = message
	print("Loading Error: %s" % message)
# ========================================
# MAIN PROCESS LOOP
# ========================================
# Process loop yang dioptimalkan
func _process(_delta: float) -> void:
	# Early exit jika loading sudah selesai
	if is_loading_complete:
		return
	# Throttle update untuk performa lebih baik menggunakan ticks
	var current_time = Time.get_ticks_msec()
	if (current_time - last_update_time) < (update_interval * 1000.0):
		return
	last_update_time = current_time
	# Cek status loading
	var progress_array: Array = []
	var status = ResourceLoader.load_threaded_get_status(get_scene_tomove, progress_array)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			_handle_loading_progress(progress_array)
		
		ResourceLoader.THREAD_LOAD_LOADED:
			_handle_loading_complete()
		
		ResourceLoader.THREAD_LOAD_FAILED:
			_handle_loading_failed()
		
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			_handle_invalid_resource()
# Handle progress update dengan optimasi
func _handle_loading_progress(progress_array: Array) -> void:
	var raw_progress = progress_array[0] if progress_array.size() > 0 else 0.0
	var normalized_progress = clamp(raw_progress, 0.0, 1.0)
	# Skip update jika progress sama dengan yang terakhir
	if abs(normalized_progress - last_progress) < 0.001:
		return
	last_progress = normalized_progress
	# Auto-complete jika mencapai 100%
	if normalized_progress >= 1.0:
		_handle_loading_complete()
		return
	# Update UI dengan batching
	_update_ui_batch(normalized_progress)
# Batch update UI untuk efisiensi
func _update_ui_batch(progress: float) -> void:
	# Update performance cache
	_update_performance_cache()
	# Update semua UI elements sekaligus
	main_data["prog"].value = progress
	main_data["txt_pct"].text = "%d%%" % int(progress * 100)
	main_data["txt_loading"].text = _generate_loading_info(progress)
# Handle loading complete
func _handle_loading_complete() -> void:
	is_loading_complete = true
	_finalize_loading()
# Handle loading failed
func _handle_loading_failed() -> void:
	is_loading_complete = true
	_show_error("Loading Failed!\nCheck console for details.\nPath: %s" % get_scene_tomove)
	set_process(false)
# Handle invalid resource
func _handle_invalid_resource() -> void:
	if not is_loading_complete:
		_show_error("Invalid Resource!\nPath does not exist:\n%s" % get_scene_tomove)
		set_process(false)
# ========================================
# COMPLETION & TRANSITION
# ========================================
# Finalisasi loading dengan cleanup
func _finalize_loading() -> void:
	# Set final UI state
	main_data["prog"].value = 1.0
	main_data["txt_pct"].text = "100%"
	# Update final info
	_update_performance_cache()
	var scene_name = get_scene_tomove.get_file().get_basename()
	main_data["txt_loading"].text = "Loading Complete!\nScene: %s\nFinal Memory: %.1f MB\nObjects: %d\nTransitioning..." % [
		scene_name, 
		performance_cache.memory_static, 
		performance_cache.object_count
	]
	# Load dan transition ke scene
	var scene = ResourceLoader.load_threaded_get(get_scene_tomove)
	if scene is PackedScene:
		# Delay untuk user feedback
		await get_tree().create_timer(0.8).timeout
		_transition_to_scene(scene)
	else:
		_show_error("Error: Loaded resource is not a scene.\nType: %s" % scene.get_class())
	# Cleanup
	set_process(false)
# Transition ke scene baru dengan cleanup
func _transition_to_scene(scene: PackedScene) -> void:
	print("Transitioning to scene: %s" % get_scene_tomove)
	# Cleanup sebelum transition
	_cleanup_loading_screen()
	# Change scene
	get_tree().change_scene_to_packed(scene)
# Cleanup loading screen resources
func _cleanup_loading_screen() -> void:
	# Clear cache
	performance_cache.clear()
	# Reset state
	is_loading_complete = false
	last_progress = -1.0
	# Disable processing
	set_process(false)
	print("Loading screen cleaned up")
# ========================================
# UTILITY FUNCTIONS
# ========================================
# Get formatted loading time (jika diperlukan untuk debugging)
func _get_formatted_time() -> String:
	var time = Time.get_time_dict_from_system()
	return "%02d:%02d:%02d" % [time.hour, time.minute, time.second]
# Get current timestamp in milliseconds
func _get_current_timestamp() -> float:
	return Time.get_ticks_msec()
