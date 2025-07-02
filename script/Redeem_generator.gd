class_name RedeemCodeGenerator

const PASSWORD_LENGTH = 32
# Konstanta keamanan statis yang TIDAK berubah antar device
const ITERATIONS = 1000  # Dikurangi untuk performa di device dengan spesifikasi rendah
const PEPPER = "a37fc98b2e5d6g4h1j9k3l4m5n7p8q2r" # Pepper statis untuk konsistensi
const PW1 = "secure_salt_key_for_pw1_a7d91ef2" # Salt statis untuk password pertama
const PW2 = "secure_salt_key_for_pw2_c8b36de5" # Salt statis untuk password kedua

# Gunakan static variable dengan initializer
static var _rng: RandomNumberGenerator = _create_rng()

# Fungsi static untuk inisialisasi RNG
static func _create_rng() -> RandomNumberGenerator:
	var new_rng = RandomNumberGenerator.new()
	new_rng.randomize()
	return new_rng

# Fungsi menghasilkan ID acak (digunakan oleh player)
static func generate_id() -> String:
	var bytes = PackedByteArray()
	for i in range(16):  # 16 bytes = 32 hex characters
		bytes.append(_rng.randi() % 256)
	return bytes.hex_encode().to_upper()

# PENTING: Fungsi hash yang DETERMINISTIC, menghasilkan output yang sama 
# untuk input yang sama di semua device
static func _hash_with_salt(input: String, salt: String) -> String:
	var hash_input = input + salt + PEPPER
	var context = HashingContext.new()
	
	# Deterministic multiple iterations untuk keamanan yang lebih baik
	for i in range(ITERATIONS):
		context.start(HashingContext.HASH_SHA256)
		context.update((hash_input + str(i)).to_utf8_buffer())
		var digest = context.finish()
		hash_input = digest.hex_encode()
	
	return hash_input.to_upper()

# PENTING: Fungsi ini harus DETERMINISTIC - menghasilkan password yang sama 
# untuk ID yang sama di semua device
static func generate_passwords(id: String) -> Array[String]:
	# TIDAK menggunakan session salt atau nilai acak apapun
	# untuk memastikan hasil yang sama di semua device
	var pw1 = _hash_with_salt(id, PW1).substr(0, PASSWORD_LENGTH)
	var pw2 = _hash_with_salt(id, PW2).substr(0, PASSWORD_LENGTH)
	
	return [pw1, pw2]

# Fungsi verifikasi password
static func confirm_password(id: String, input_password: String) -> bool:
	var passwords = generate_passwords(id)
	
	# Gunakan constant-time comparison untuk keamanan
	var result1 = _constant_time_compare(input_password, passwords[0])
	var result2 = _constant_time_compare(input_password, passwords[1])
	
	# Return true jika salah satu password cocok
	return result1 or result2

# Helper function untuk perbandingan waktu konstan
static func _constant_time_compare(a: String, b: String) -> bool:
	if a.length() != b.length():
		return false
		
	var result = 0
	for i in range(a.length()):
		result |= a.unicode_at(i) ^ b.unicode_at(i)
	
	return result == 0

# Fungsi untuk menghasilkan paket kode lengkap
static func get_code_package() -> Dictionary:
	var id = generate_id()
	var passwords = generate_passwords(id)
	
	return {
		"id": id,
		"pw1": passwords[0],  # Password opsi pertama
		"pw2": passwords[1],  # Password opsi kedua
	}

# Fungsi untuk memeriksa validitas ID (format yang benar)
static func is_valid_id_format(id: String) -> bool:
	# Memeriksa apakah ID memiliki panjang yang benar dan hanya mengandung hex digits
	if id.length() != 32:
		return false
		
	var valid_chars = "0123456789ABCDEF"
	for c in id:
		if valid_chars.find(c) == -1:
			return false
			
	return true

# Fungsi tambahan untuk menghasilkan kode ramah pengguna
static func generate_friendly_code(length: int = 10) -> String:
	var chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789" # Menghindari karakter membingungkan
	var code = ""
	
	for i in range(length):
		var idx = _rng.randi() % chars.length()
		code += chars[idx]
		
		# Tambahkan tanda hubung untuk pembacaan yang lebih mudah
		if i == 4 && length > 6:
			code += "-"
	
	return code
