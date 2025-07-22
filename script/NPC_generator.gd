class_name NPC_generator
extends RefCounted

# Generate a single NPC with complete data structure
func npc_new() -> Dictionary:
	var npc_id = _generate_unique_id()
	var gender = _generate_gender()
	var age = _generate_age()
	var birth_year = 1500 - age
	var birth_data = _generate_birth_date(birth_year)
	var death_data = _generate_death_date(birth_data, age)
	var stats = _generate_stats()
	
	var npc_data = {
		npc_id: {
			"name": _generate_name(gender),
			"age": age,
			"job": null,
			"gender": gender,
			"birth_date": birth_data,
			"death_date": death_data,
			"height": _generate_height(gender),
			"weight": _generate_weight(gender),
			"hobby": _generate_hobby(stats),
			"origin": _generate_origin(),
			"status": null,
			"trust": 0,
			"marriage": null,
			"location": null,
			"is_alive": true,
			"death_location": null,
			"physical": stats.physical,
			"intelligence": stats.intelligence,
			"communication": stats.communication,
			"wisdom": stats.wisdom,
			"stat_food":50,
			"stat_mood":70,
			"stat_health":70,
			"inventory":{},
		}
	}
	
	return npc_data
# Generate multiple NPCs
func npc_multiple(count: int) -> Array:
	var npcs = []
	for i in range(count):
		npcs.append(npc_new())
	return npcs
# Generate a family of NPCs with same surname
func npc_generate_family(count: int) -> Array:
	var family = []
	var surname = _generate_surname()
	var origin = _generate_origin()
	
	for i in range(count):
		var npc_id = _generate_unique_id()
		var gender = _generate_gender()
		var age = _generate_age()
		var birth_year = 1500 - age
		var birth_data = _generate_birth_date(birth_year)
		var death_data = _generate_death_date(birth_data, age)
		var stats = _generate_stats()
		
		var npc_data = {
			npc_id: {
				"name": _generate_first_name(gender) + " " + surname,
				"age": age,
				"gender": gender,
				"height": _generate_height(gender),
				"weight": _generate_weight(gender),
				"intelligence": stats.intelligence,
				"wisdom": stats.wisdom,
				"physical": stats.physical,
				"communication": stats.communication,
				"birth_date": birth_data,
				"death_date": death_data,
				"death_location": null,
				"status": null,
				"marriage": null,
				"job": null,
				"location": null,
				"is_alive": true,
				"hobby": _generate_hobby(stats),
				"origin": origin
			}
		}
		
		family.append(npc_data)
	
	return family
# Generate custom NPC based on provided data
func npc_custom(data: Dictionary) -> Dictionary:
	var npc_id = _generate_unique_id()
	var gender = data.get("set_gender", _generate_gender())
	var age = data.get("set_age", _generate_age())
	var birth_year = 1500 - age
	var birth_data = data.get("set_birth_date", _generate_birth_date(birth_year))
	var death_data = data.get("set_death_date", _generate_death_date(birth_data, age))
	
	var stats = {
		"intelligence": data.get("set_intelligence", randi_range(1, 100)),
		"wisdom": data.get("set_wisdom", randi_range(1, 100)),
		"physical": data.get("set_physical", randi_range(1, 100)),
		"communication": data.get("set_communication", randi_range(1, 100))
	}
	
	var npc_data = {
		npc_id: {
			"name": data.get("set_name", _generate_name(gender)),
			"age": age,
			"gender": gender,
			"height": data.get("set_height", _generate_height(gender)),
			"weight": data.get("set_weight", _generate_weight(gender)),
			"intelligence": stats.intelligence,
			"wisdom": stats.wisdom,
			"physical": stats.physical,
			"communication": stats.communication,
			"birth_date": birth_data,
			"death_date": death_data,
			"death_location": data.get("set_death_location", null),
			"status": data.get("set_status", null),
			"marriage": data.get("set_marriage", null),
			"job": data.get("set_job", null),
			"location": data.get("set_location", null),
			"is_alive": data.get("set_is_alive", true),
			"hobby": data.get("set_hobby", _generate_hobby(stats)),
			"origin": data.get("set_origin", _generate_origin())
		}
	}
	
	return npc_data
# Filter NPCs by stat range
func npc_filter_by_stat(npcs: Array, stat_name: String, min_val: int, max_val: int) -> Array:
	var filtered = []
	for npc_dict in npcs:
		for npc_id in npc_dict.keys():
			var npc_data = npc_dict[npc_id]
			if npc_data.has(stat_name):
				var stat_value = npc_data[stat_name]
				if stat_value >= min_val and stat_value <= max_val:
					filtered.append(npc_dict)
	return filtered
# Sort NPCs by stat value
func npc_sort_by(npcs: Array, stat_name: String, descending: bool = false) -> Array:
	var sorted_npcs = npcs.duplicate()
	sorted_npcs.sort_custom(func(a, b):
		var a_value = 0
		var b_value = 0
		
		for npc_id in a.keys():
			if a[npc_id].has(stat_name):
				a_value = a[npc_id][stat_name]
				break
		
		for npc_id in b.keys():
			if b[npc_id].has(stat_name):
				b_value = b[npc_id][stat_name]
				break
		
		if descending:
			return a_value > b_value
		else:
			return a_value < b_value
	)
	return sorted_npcs
# Validate NPC data structure
func npc_validate(data: Dictionary) -> bool:
	if data.keys().size() != 1:
		return false
	
	var npc_id = data.keys()[0]
	var npc_data = data[npc_id]
	
	var required_keys = [
		"name", "age", "gender", "height", "weight",
		"intelligence", "wisdom", "physical", "communication",
		"birth_date", "death_date", "death_location", "status",
		"marriage", "job", "location", "is_alive", "hobby", "origin"
	]
	
	for key in required_keys:
		if not npc_data.has(key):
			return false
	
	# Validate birth_date structure
	if typeof(npc_data["birth_date"]) != TYPE_DICTIONARY:
		return false
	
	var birth_date = npc_data["birth_date"]
	if not (birth_date.has("hour") and birth_date.has("day") and 
			birth_date.has("month") and birth_date.has("year")):
		return false
	
	# Validate death_date structure
	if typeof(npc_data["death_date"]) != TYPE_DICTIONARY:
		return false
	
	var death_date = npc_data["death_date"]
	if not (death_date.has("hour") and death_date.has("day") and 
			death_date.has("month") and death_date.has("year")):
		return false
	
	return true
# Generate unique ID for NPC
func _generate_unique_id() -> String:
	var timestamp = str(Time.get_unix_time_from_system()).substr(5, 5)
	var random_num = str(randi_range(100, 999))
	return timestamp + random_num
# Generate random gender
func _generate_gender() -> String:
	return ["Male", "Female"][randi_range(0, 1)]
# Generate random age
func _generate_age() -> int:
	return randi_range(18, 80)
# Generate Indonesian-style male names
func _generate_male_names() -> Array:
	return [
		"Agus", "Bambang", "Cahyo", "Dedi", "Eko", "Fajar", "Guntur", 
		"Hendra", "Indra", "Joko", "Kunto", "Lukman", "Marno", "Nando",
		"Oki", "Pramono", "Ridwan", "Slamet", "Tono", "Udin", "Vino",
		"Wawan", "Yanto", "Zaenal", "Arif", "Budi", "Candra", "Dimas",
		"Edy", "Fendi", "Gandi", "Hadi", "Irfan", "Jaya", "Krisna" ]
# Generate Indonesian-style female names
func _generate_female_names() -> Array:
	return [
		"Ani", "Budi", "Citra", "Dewi", "Erni", "Fitri", "Gita", 
		"Hani", "Indah", "Jihan", "Kartika", "Lestari", "Maya", "Nita",
		"Okta", "Putri", "Ratna", "Sari", "Tuti", "Uci", "Vina",
		"Wati", "Yuli", "Zahra", "Ayu", "Bunga", "Cita", "Diah",
		"Elsa", "Fira", "Gina", "Hesti", "Ika", "Jeni", "Kirana" ]
# Generate Indonesian-style surnames
func _generate_surnames() -> Array:
	return [
		"Prasetyo", "Sutanto", "Wibowo", "Santoso", "Hartono", "Setiawan",
		"Kurniawan", "Wijaya", "Gunawan", "Susanto", "Cahyono", "Purnomo",
		"Subagyo", "Wardoyo", "Nugroho", "Raharjo", "Suharto", "Hidayat",
		"Saputra", "Nugraha", "Permana", "Maulana", "Ramadhan", "Firmansyah",
		"Anderson", "Johnson", "Williams", "Brown", "Jones", "Garcia",
		"Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez",
		"Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore" ]
# Generate first name based on gender
func _generate_first_name(gender: String) -> String:
	if gender == "Male":
		var male_names = _generate_male_names()
		return male_names[randi_range(0, male_names.size() - 1)]
	else:
		var female_names = _generate_female_names()
		return female_names[randi_range(0, female_names.size() - 1)]
# Generate full name based on gender
func _generate_name(gender: String) -> String:
	var first_name = _generate_first_name(gender)
	var surnames = _generate_surnames()
	
	# 70% chance of having surname
	if randi_range(1, 100) <= 70:
		var surname = surnames[randi_range(0, surnames.size() - 1)]
		return first_name + " " + surname
	else:
		return first_name
# Generate surname only
func _generate_surname() -> String:
	var surnames = _generate_surnames()
	return surnames[randi_range(0, surnames.size() - 1)]
# Generate height based on gender
func _generate_height(gender: String) -> int:
	if gender == "Male":
		return randi_range(160, 185)
	else:
		return randi_range(150, 175)
# Generate weight based on gender
func _generate_weight(gender: String) -> int:
	if gender == "Male":
		return randi_range(55, 90)
	else:
		return randi_range(45, 75)
# Generate stats
func _generate_stats() -> Dictionary:
	return {
		"intelligence": randi_range(1, 100),
		"wisdom": randi_range(1, 100),
		"physical": randi_range(1, 100),
		"communication": randi_range(1, 100) }
# Generate birth date
func _generate_birth_date(birth_year: int) -> Dictionary:
	return {
		"hour": randi_range(0, 23),
		"day": randi_range(1, 28),
		"month": randi_range(1, 12),
		"year": birth_year }
# Generate death date
func _generate_death_date(birth_data: Dictionary, age: int) -> Dictionary:
	var death_year = birth_data.year + age + randi_range(10, 40)
	return {
		"hour": randi_range(0, 23),
		"day": randi_range(1, 28),
		"month": randi_range(1, 12),
		"year": death_year }
# Generate hobby based on stats
func _generate_hobby(stats: Dictionary) -> String:
	var intelligence = stats.intelligence
	var physical = stats.physical
	var wisdom = stats.wisdom
	var communication = stats.communication
	
	var hobbies = []
	
	# Intelligence-based hobbies
	if intelligence >= 70:
		hobbies.append_array(["Reading", "Chess", "Mathematics", "Programming", "Research"])
	
	# Physical-based hobbies
	if physical >= 70:
		hobbies.append_array(["Running", "Swimming", "Martial Arts", "Climbing", "Dancing"])
	
	# Wisdom-based hobbies
	if wisdom >= 70:
		hobbies.append_array(["Meditation", "Gardening", "Philosophy", "Teaching", "Counseling"])
	
	# Communication-based hobbies
	if communication >= 70:
		hobbies.append_array(["Public Speaking", "Writing", "Singing", "Acting", "Socializing"])
	
	# Default hobbies if no high stats
	if hobbies.is_empty():
		hobbies = ["Watching TV", "Sleeping", "Eating", "Walking", "Listening Music"]
	
	return hobbies[randi_range(0, hobbies.size() - 1)]
# Generate modified Indonesian origin names
func _generate_origin() -> String:
	var origins = [
		"Jakarra", "Surabira", "Bandira", "Meddan", "Semaril", "Palimba",
		"Makare", "Tanggara", "Depen", "Bekale", "Bogal", "Malaya",
		"Padral", "Banjare", "Denlasa", "Samirda", "Balikara", "Jamira",
		"Pekandu", "Lampura", "Bengkira", "Pontira", "Kupira", "Jayarta",
		"Sorena", "Manira", "Palindra", "Kendala", "Tarnesi", "Ambira",
		"Bandera", "Jogkarta", "Suralena", "Cirera", "Tegara", "Purkara",
		"Kediran", "Blitarn", "Prolango", "Manowre", "Meraki", "Wamara",
		"Taralun", "Tuwari", "Timara", "Bimatra", "Matralem", "Bengkara",
		"Sinkara", "Luwira", "Palume", "Parera", "Bawara", "Tolira",
		"Bitura", "Tomira", "Tidral", "Selara", "Wakatra", "Majiri",
		"Sinjara", "Pankira", "Sopren", "Marisa", "Goranti", "Bonira",
		"Enralem", "Tanara", "Luwari" ]
	return origins[randi_range(0, origins.size() - 1) ]
