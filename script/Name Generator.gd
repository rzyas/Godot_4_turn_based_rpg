class_name Name_generator
extends RefCounted

# Enums untuk performance dan type safety
enum Gender {
	PRIA,
	WANITA
}

enum Region {
	JAWA,
	SUMATRA,
	KALIMANTAN,
	SULAWESI,
	BALI_NUSA,
	MALUKU_PAPUA
}

# Data nama depan Indonesia berdasarkan region
static var nama_depan_pria: Dictionary = {
	Region.JAWA: [
		"Budi", "Agus", "Bambang", "Dedi", "Eko", "Fajar", "Gunawan", "Hendra",
		"Indra", "Joko", "Krisna", "Lukman", "Malik", "Nando", "Oki", "Pandu",
		"Rudi", "Slamet", "Tono", "Umar", "Vino", "Wawan", "Yanto", "Zaki",
		"Arief", "Bayu", "Cahyo", "Dimas", "Firman", "Gilang", "Hendro", "Irvan"
	],
	Region.SUMATRA: [
		"Rizki", "Fadli", "Hasan", "Irfan", "Yusuf", "Wahyu", "Teguh", "Sofyan",
		"Rahmat", "Qodir", "Noval", "Mirza", "Lukman", "Khairul", "Jefri", "Indra",
		"Hafiz", "Gading", "Faisal", "Eka", "Doni", "Candra", "Bagas", "Andi",
		"Zulkifli", "Yogi", "Wildan", "Veri", "Taufik", "Syahrul", "Ridho", "Putra"
	],
	Region.KALIMANTAN: [
		"Aditya", "Benny", "Chandra", "Denny", "Erwin", "Ferry", "Gatot", "Henry",
		"Ivan", "Jimmy", "Kevin", "Lucky", "Martin", "Norbert", "Oscar", "Peter",
		"Reynold", "Steven", "Tommy", "Udin", "Vincent", "William", "Xavier", "Yudi",
		"Zulfikar", "Andika", "Bobi", "Charly", "Doni", "Edwin", "Franky", "Guntur"
	],
	Region.SULAWESI: [
		"Akbar", "Basri", "Cakra", "Daud", "Erwanto", "Fachri", "Ghazi", "Habib",
		"Ismail", "Jamal", "Karim", "Latif", "Maman", "Najib", "Omar", "Pratama",
		"Qasim", "Ramdhan", "Salim", "Taufan", "Usman", "Valdi", "Wira", "Yusran",
		"Zaenal", "Arman", "Burhan", "Candra", "Dhani", "Efendi", "Fahmi", "Galih"
	],
	Region.BALI_NUSA: [
		"Wayan", "Made", "Nyoman", "Ketut", "Gede", "Putu", "Kadek", "Komang",
		"Agung", "Bayu", "Candra", "Dewa", "Eka", "Firman", "Gung", "Hendra",
		"Indra", "Jaya", "Krisna", "Mandra", "Nengah", "Oka", "Pande", "Raka",
		"Surya", "Tresna", "Udayana", "Vino", "Widya", "Yoga", "Zen", "Arya"
	],
	Region.MALUKU_PAPUA: [
		"Abraham", "Benny", "Christ", "David", "Emanuel", "Franky", "George", "Hans",
		"Isak", "Jonathan", "Kornelius", "Lukas", "Markus", "Nikolas", "Oktavianus", "Paulus",
		"Robertus", "Simon", "Tomas", "Urbanus", "Viktor", "Wilhelmus", "Xaverius", "Yohanes",
		"Zakarias", "Andreas", "Barnabas", "Cornelis", "Dominikus", "Eduardus", "Fransiskus", "Gregorius"
	]
}

static var nama_depan_wanita: Dictionary = {
	Region.JAWA: [
		"Sari", "Dewi", "Rina", "Maya", "Lina", "Fitri", "Endang", "Tuti",
		"Yuni", "Ratna", "Indah", "Wati", "Siti", "Ani", "Evi", "Diah",
		"Rini", "Nita", "Lilis", "Mira", "Tina", "Vita", "Winda", "Yanti",
		"Astri", "Bunga", "Citra", "Dina", "Fani", "Gita", "Heni", "Ika"
	],
	Region.SUMATRA: [
		"Aida", "Bella", "Cici", "Dinda", "Elsa", "Farah", "Gina", "Hana",
		"Intan", "Jihan", "Kirana", "Laila", "Mela", "Nadya", "Okta", "Putri",
		"Raisa", "Safira", "Tiara", "Ulfa", "Vina", "Wulan", "Yola", "Zahra",
		"Adelia", "Bunga", "Cinta", "Dara", "Febri", "Gema", "Hilda", "Icha"
	],
	Region.KALIMANTAN: [
		"Angela", "Bertha", "Cecilia", "Desi", "Erni", "Fanny", "Grace", "Helen",
		"Irene", "Jessica", "Kartika", "Linda", "Maria", "Nancy", "Olivia", "Patricia",
		"Regina", "Susan", "Theresia", "Ursula", "Veronika", "Wendy", "Xenia", "Yolanda",
		"Zella", "Anastasia", "Beatrice", "Caroline", "Debora", "Elisabeth", "Felicia", "Gabriella"
	],
	Region.SULAWESI: [
		"Aisyah", "Bintang", "Citra", "Dian", "Elvi", "Fadilla", "Giska", "Hasna",
		"Iis", "Juwita", "Kania", "Laras", "Melani", "Nurul", "Ocha", "Prita",
		"Qonita", "Riska", "Salwa", "Tika", "Umi", "Vira", "Wulan", "Yesi",
		"Zulfa", "Amira", "Balqis", "Cahya", "Dinda", "Elsa", "Fadya", "Ghina"
	],
	Region.BALI_NUSA: [
		"Ayu", "Dewi", "Kadek", "Komang", "Luh", "Made", "Ni", "Nyoman",
		"Putu", "Wayan", "Citra", "Diah", "Eka", "Fitri", "Gung", "Hening",
		"Indira", "Jaya", "Krisna", "Laksmi", "Manik", "Nanda", "Okta", "Pande",
		"Rani", "Sari", "Tresna", "Utami", "Vina", "Widya", "Yanti", "Zara"
	],
	Region.MALUKU_PAPUA: [
		"Agnes", "Bernadeth", "Catharina", "Dorkas", "Esther", "Fatima", "Gloria", "Herlina",
		"Imelda", "Joice", "Kartini", "Lydia", "Martha", "Natasha", "Olivia", "Priscilla",
		"Ruth", "Sara", "Theresia", "Ursula", "Veronika", "Wilhelmina", "Xenia", "Yolanda",
		"Zefanya", "Anastasia", "Beatrice", "Cornelia", "Debora", "Elisabeth", "Fransiska", "Gabriella"
	]
}

# Data nama tengah/nama keluarga yang diplesetkan dari marga asli
static var nama_tengah_universal: Array[String] = [
	"Cahya", "Indra", "Bayu", "Surya", "Adi", "Dwi", "Tri", "Catur", "Panca",
	"Eka", "Dika", "Riga", "Seka", "Nava", "Dasa", "Kusuma", "Ananda", "Wijaya",
	"Pratama", "Utama", "Mulia", "Lestari", "Sari", "Putri", "Putra", "Satria",
	"Dharma", "Karya", "Jaya", "Kencana", "Permana", "Santosa", "Wirawan"
]

static var nama_akhir_jawa: Array[String] = [
	"Wibowo", "Widodo", "Santoso", "Kurniawan", "Setiawan", "Firmansyah", "Wahyudi",
	"Prabowo", "Suryanto", "Handoko", "Gunawan", "Prasetyo", "Nugroho", "Budianto",
	"Yulianto", "Hendarto", "Susanto", "Purwanto", "Darmawan", "Sudrajat", "Kartono",
	"Sutrisno", "Haryanto", "Supriyanto", "Hermawan", "Purnomo", "Prayitno", "Suyanto",
	"Suharjo", "Priyono", "Witono", "Sumarno", "Harjono", "Suharto", "Pranowo"
]

static var nama_akhir_sumatra: Array[String] = [
	"Harahap", "Siregar", "Nasution", "Lubis", "Daulay", "Batubara", "Pane", "Tampubolon",
	"Situmorang", "Sinaga", "Sihotang", "Turnip", "Manurung", "Pardede", "Simbolon",
	"Simanjuntak", "Hutasoit", "Sijabat", "Silaen", "Hutapea", "Siahaan", "Ginting",
	"Tarigan", "Sembiring", "Karo", "Perangin", "Sitepu", "Bangun", "Keliat", "Milala",
	"Sebayang", "Barus", "Sitorus", "Hutahaean", "Malau"
]

static var nama_akhir_kalimantan: Array[String] = [
	"Widjaja", "Hartono", "Tanuwijaya", "Gunadi", "Sutanto", "Liem", "Tan", "Wibawa",
	"Setiono", "Pranata", "Kusuma", "Halim", "Wijaya", "Setiadi", "Lukman", "Salim",
	"Purnama", "Indrawijaya", "Nusantara", "Suhendra", "Wijayanto", "Setiabudi", "Hermanto",
	"Nurhadi", "Mahendra", "Setiana", "Sumardjono", "Hartawan", "Santoso", "Setiawan",
	"Purnomo", "Gunawan", "Pratama", "Kustiawan", "Haryadi"
]

static var nama_akhir_sulawesi: Array[String] = [
	"Makki", "Mappanyukki", "Pallangga", "Mattulada", "Patunru", "Djalil", "Rasyid",
	"Alimuddin", "Baharuddin", "Hasanuddin", "Nurdin", "Syamsuddin", "Darwis", "Masdar",
	"Rachman", "Wahab", "Yusuf", "Ramli", "Karim", "Halim", "Saleh", "Mahmud",
	"Hakim", "Nasir", "Syarif", "Farid", "Ridwan", "Rahman", "Rahim", "Hamid",
	"Majid", "Rashid", "Syahroni", "Latief", "Marzuki"
]

static var nama_akhir_bali_nusa: Array[String] = [
	"Sutrisna", "Sudana", "Suardana", "Wijaya", "Adnyana", "Ariana", "Winata", "Suwandana",
	"Maheswara", "Gunawan", "Pramana", "Nugraha", "Suryawan", "Antara", "Setiawan",
	"Kurniawan", "Darmawan", "Pratama", "Utama", "Kusuma", "Sanjaya", "Permana",
	"Krisna", "Dharma", "Wijana", "Suryadi", "Pradana", "Mahendra", "Purnama",
	"Wirawan", "Suryanto", "Kartika", "Bayu", "Surya", "Arya"
]

static var nama_akhir_maluku_papua: Array[String] = [
	"Tuhumury", "Sapulete", "Wattimena", "Ferdinandus", "Christoffel", "Matakupan",
	"Leiwakabessy", "Latuheru", "Pattiasina", "Leimena", "Siwalette", "Pattynama",
	"Titaley", "Soplantila", "Latuputty", "Matitaputty", "Wambrauw", "Lokbere",
	"Rumbewas", "Mandacan", "Tamaela", "Soumokil", "Pattimura", "Leasiwal",
	"Matitaputty", "Tawainella", "Hukom", "Patty", "Rumkorem", "Rumbiak",
	"Wenda", "Yeimo", "Youw", "Dimara", "Karma"
]

# Cache untuk nama yang sudah digunakan (optimasi memori)
static var used_names: Dictionary = {}
static var name_counter: int = 0

# Weighted random untuk distribusi region yang realistis
static var region_weights: Array[float] = [
	0.45,  # JAWA (dominan)
	0.20,  # SUMATRA
	0.10,  # KALIMANTAN
	0.12,  # SULAWESI
	0.08,  # BALI_NUSA
	0.05   # MALUKU_PAPUA
]

# Random instance untuk thread safety
static var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# Inisialisasi static
static func _static_init():
	rng.randomize()

# Fungsi utama untuk generate data
static func generate_person_data(ensure_unique: bool = true) -> Dictionary:
	var gender: Gender = _get_random_gender()
	var region: Region = _get_weighted_random_region()
	var name: String = _generate_unique_name(gender, region, ensure_unique)
	
	return {
		"name": name,
		"umur": _generate_realistic_age(),
		"berat_badan": _generate_realistic_weight(gender),
		"tinggi": _generate_realistic_height(gender),
		"gender": _gender_to_string(gender),
		"region": _region_to_string(region)
	}

# Generate multiple data sekaligus (batch processing)
static func generate_batch_data(count: int, ensure_unique: bool = true) -> Array[Dictionary]:
	var results: Array[Dictionary] = []
	results.resize(count)
	
	for i in range(count):
		results[i] = generate_person_data(ensure_unique)
		
	return results

# Generate dengan custom parameters
static func generate_custom_data(
	gender_preference: Gender = Gender.PRIA,
	region_preference: Region = Region.JAWA,
	age_range: Vector2i = Vector2i(18, 65),
	use_preference: bool = false
) -> Dictionary:
	
	var gender: Gender = gender_preference if use_preference else _get_random_gender()
	var region: Region = region_preference if use_preference else _get_weighted_random_region()
	var name: String = _generate_unique_name(gender, region, true)
	
	return {
		"name": name,
		"umur": rng.randi_range(age_range.x, age_range.y),
		"berat_badan": _generate_realistic_weight(gender),
		"tinggi": _generate_realistic_height(gender),
		"gender": _gender_to_string(gender),
		"region": _region_to_string(region)
	}

# === PRIVATE METHODS ===

static func _get_random_gender() -> Gender:
	return Gender.PRIA if rng.randf() > 0.5 else Gender.WANITA

static func _get_weighted_random_region() -> Region:
	var random_value: float = rng.randf()
	var cumulative: float = 0.0
	
	for i in range(region_weights.size()):
		cumulative += region_weights[i]
		if random_value <= cumulative:
			return i as Region
	
	return Region.JAWA  # fallback

static func _generate_unique_name(gender: Gender, region: Region, ensure_unique: bool) -> String:
	var nama_depan_array: Array = nama_depan_pria[region] if gender == Gender.PRIA else nama_depan_wanita[region]
	var nama_depan: String = nama_depan_array[rng.randi() % nama_depan_array.size()]
	
	# Generate nama lengkap
	var full_name: String = _construct_full_name(nama_depan, region)
	
	if not ensure_unique:
		return full_name
	
	var final_name: String = full_name
	var attempt: int = 0
	
	# Coba dapatkan nama unik dengan variasi
	while used_names.has(final_name) and attempt < 50:
		attempt += 1
		final_name = _construct_full_name(nama_depan, region)
	
	# Jika masih tidak unik, tambahkan suffix
	if used_names.has(final_name):
		name_counter += 1
		final_name = full_name + " " + _get_roman_numeral(name_counter)
	
	used_names[final_name] = true
	return final_name

static func _construct_full_name(nama_depan: String, region: Region) -> String:
	var use_middle_name: bool = rng.randf() > 0.3  # 70% chance ada nama tengah
	var nama_akhir_array: Array[String]
	
	# Pilih array nama akhir sesuai region
	match region:
		Region.JAWA:
			nama_akhir_array = nama_akhir_jawa
		Region.SUMATRA:
			nama_akhir_array = nama_akhir_sumatra
		Region.KALIMANTAN:
			nama_akhir_array = nama_akhir_kalimantan
		Region.SULAWESI:
			nama_akhir_array = nama_akhir_sulawesi
		Region.BALI_NUSA:
			nama_akhir_array = nama_akhir_bali_nusa
		Region.MALUKU_PAPUA:
			nama_akhir_array = nama_akhir_maluku_papua
		_:
			nama_akhir_array = nama_akhir_jawa
	
	var nama_akhir: String = nama_akhir_array[rng.randi() % nama_akhir_array.size()]
	
	if use_middle_name:
		var nama_tengah: String = nama_tengah_universal[rng.randi() % nama_tengah_universal.size()]
		return nama_depan + " " + nama_tengah + " " + nama_akhir
	else:
		return nama_depan + " " + nama_akhir

static func _get_roman_numeral(number: int) -> String:
	match number:
		1: return "I"
		2: return "II"
		3: return "III"
		4: return "IV"
		5: return "V"
		6: return "VI"
		7: return "VII"
		8: return "VIII"
		9: return "IX"
		10: return "X"
		_: return "X+"

static func _generate_realistic_age() -> int:
	# Distribusi umur yang realistis (weighted)
	var rand_val: float = rng.randf()
	
	if rand_val < 0.3:  # 30% usia muda (18-30)
		return rng.randi_range(18, 30)
	elif rand_val < 0.6:  # 30% usia dewasa (31-45)
		return rng.randi_range(31, 45)
	elif rand_val < 0.85:  # 25% usia menengah (46-60)
		return rng.randi_range(46, 60)
	else:  # 15% usia tua (61-80)
		return rng.randi_range(61, 80)

static func _generate_realistic_weight(gender: Gender) -> float:
	# Berat badan realistis orang Indonesia
	var base_weight: float
	var variation: float
	
	if gender == Gender.PRIA:
		base_weight = 65.0  # kg
		variation = 15.0
	else:
		base_weight = 55.0  # kg
		variation = 12.0
	
	# Gunakan distribusi normal (gaussian approximation)
	var weight: float = base_weight + (rng.randf() - 0.5) * variation * 2
	return round(max(40.0, min(120.0, weight)) * 10.0) / 10.0  # 1 decimal place

static func _generate_realistic_height(gender: Gender) -> int:
	# Tinggi badan realistis orang Indonesia (cm)
	var base_height: int
	var variation: int
	
	if gender == Gender.PRIA:
		base_height = 168  # cm
		variation = 8
	else:
		base_height = 158  # cm
		variation = 6
	
	var height: int = base_height + rng.randi_range(-variation, variation)
	return max(140, min(190, height))

static func _gender_to_string(gender: Gender) -> String:
	return "Pria" if gender == Gender.PRIA else "Wanita"

static func _region_to_string(region: Region) -> String:
	match region:
		Region.JAWA: return "Jawa"
		Region.SUMATRA: return "Sumatra"
		Region.KALIMANTAN: return "Kalimantan"
		Region.SULAWESI: return "Sulawesi"
		Region.BALI_NUSA: return "Bali & Nusa Tenggara"
		Region.MALUKU_PAPUA: return "Maluku & Papua"
		_: return "Unknown"

# Utility functions
static func clear_used_names() -> void:
	used_names.clear()
	name_counter = 0

static func get_used_names_count() -> int:
	return used_names.size()

static func export_to_csv(data: Array[Dictionary], file_path: String) -> bool:
	var file: FileAccess = FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		return false
	
	# Header
	file.store_line("Name,Umur,Berat Badan,Tinggi,Gender,Region")
	
	# Data
	for person in data:
		var line: String = "%s,%d,%.1f,%d,%s,%s" % [
			person.name,
			person.umur,
			person.berat_badan,
			person.tinggi,
			person.gender,
			person.region
		]
		file.store_line(line)
	
	file.close()
	return true

# Debug function
static func print_statistics(data: Array[Dictionary]) -> void:
	var gender_count: Dictionary = {"Pria": 0, "Wanita": 0}
	var region_count: Dictionary = {}
	var age_sum: int = 0
	
	for person in data:
		gender_count[person.gender] += 1
		region_count[person.region] = region_count.get(person.region, 0) + 1
		age_sum += person.umur
	
	print("=== STATISTIK DATA ===")
	print("Total: ", data.size())
	print("Gender - Pria: ", gender_count.Pria, ", Wanita: ", gender_count.Wanita)
	print("Rata-rata umur: ", int(age_sum / data.size()))
	print("Distribusi region: ", region_count)
