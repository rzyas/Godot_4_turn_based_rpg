class_name Data_story_bab_id
var data_bab_story = {}

func _init() -> void:
	# reset all first
	for i in range(7):
		var bab = "bab_%d" %[i+1]
		if data_bab_story.has(bab) == false:
			data_bab_story[bab]={}
			for ii in range(12):
				var stage = "stage_%d" %[ii+1]
				data_bab_story[bab][stage] = {"header":"", "story":""}
	
	for i in range(3):
		var path = "res://Story/S%d/ID/" %[i+1]
		var get_header:Dictionary = extract_txt_header(path)
		var get_story:Dictionary = extract_txt_story(path)
		for ii in range(12):
			var bab = "bab_%d" %[i+1]
			var stage = "stage_%d" %[ii+1]
			data_bab_story[bab][stage] = {
				"header":get_header[str(ii+1)],
				"story":get_story[str(ii+1)]
			}
	#var s1_header:Dictionary = extract_txt_header("res://Story/S1/ID/")
	#var s1_story:Dictionary = extract_txt_story("res://Story/S1/ID/")
	#for i in range(12):
		#var bab = "bab_1"
		#var stage = "stage_%d" %[i+1]
		#data_bab_story[bab][stage] = {
			#"header":s1_header[str(i+1)],
			#"story":s1_story[str(i+1)]
		#}
	
	# re-mapping story
func extract_txt_header(folder_path: String) -> Dictionary:
	var result: Dictionary = {}
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var index := 1
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".txt"):
				# ambil judul dari nama file
				var title = _process_file_name(file_name)
				if title != "":
					result[str(index)] = title
					index += 1
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Tidak bisa membuka folder: " + folder_path)
	return result
func _process_file_name(file_name: String) -> String:
	# buang ekstensi .txt
	var no_ext = file_name.trim_suffix(".txt")
	# pecah berdasarkan "_%_"
	var parts = no_ext.split("_%_")
	if parts.size() > 1:
		# ambil bagian setelah "_%_"
		return parts[1].strip_edges()
	else:
		return ""
func extract_txt_story(folder_path: String) -> Dictionary:
	var result: Dictionary = {}
	var dir = DirAccess.open(folder_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var index := 1
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".txt"):
				var file_path = folder_path + "/" + file_name
				var file = FileAccess.open(file_path, FileAccess.READ)
				if file:
					var content = file.get_as_text()
					result[str(index)] = content
					file.close()
					index += 1
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Tidak bisa membuka folder: " + folder_path)
	return result
