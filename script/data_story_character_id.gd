class_name Data_story_character_id
extends Node

var nature = "Melambangkan kekuatan alam, karakter ini adalah penjaga harmoni dunia. Tubuh dan auranya dipenuhi energi dari tanah, air, api, dan angin. Ia bisa menjadi tenang seperti sungai yang mengalir, namun juga mengamuk seperti badai yang tak terbendung. Kehadirannya mengingatkan bahwa alam bukan hanya sumber daya, tapi kekuatan hidup yang harus dihormati."
var fire = "Melambangkan kekuatan api, karakter ini adalah wujud semangat yang membara dan tak pernah padam. Setiap langkahnya meninggalkan jejak panas, seolah membawa cahaya di tengah kegelapan. Api yang ia kendalikan bisa menjadi pelindung yang hangat, namun juga senjata yang membinasakan. Ia mencerminkan sisi ganda alam: energi kehidupan sekaligus kekuatan kehancuran, dan mengingatkan bahwa api harus dihormati, bukan ditaklukkan."
var water = "Melambangkan kekuatan air, karakter ini memancarkan ketenangan sekaligus kekuatan yang tersembunyi. Seperti sungai yang mengalir lembut namun mampu mengikis batu, ia adalah simbol kesabaran dan ketahanan. Dalam ketenangannya tersimpan badai yang bisa menggulung segalanya. Air yang ia kendalikan mampu menyembuhkan dan memberi kehidupan, namun juga menghancurkan bila diabaikan. Ia adalah pengingat bahwa kelembutan bisa menyimpan kekuatan yang dahsyat."
var light = "Melambangkan kekuatan cahaya, karakter ini adalah wujud harapan dan kebenaran. Ia memancarkan aura yang menenangkan sekaligus membangkitkan semangat, bagaikan fajar yang mengusir kegelapan. Cahaya yang ia bawa mampu menyembuhkan luka, menyingkap kebenaran, serta membakar kejahatan yang bersembunyi. Namun, semakin terang sinarnya, semakin besar pula bayangan yang tercipta. Ia mengingatkan bahwa cahaya bukan sekadar keindahan, tetapi juga tanggung jawab untuk menuntun jalan."
var dark = "Melambangkan kekuatan kegelapan, karakter ini adalah bayangan yang lahir dari misteri dan ketakutan terdalam. Ia menyelimuti sekitarnya dengan aura dingin dan rahasia, bagaikan malam tanpa bulan yang menelan cahaya. Kegelapan yang ia kuasai bisa menjadi perlindungan yang menenangkan, namun juga ancaman yang menyesatkan. Ia mencerminkan sisi tersembunyi dari alam: tak terlihat, tak tersentuh, namun selalu ada. Kehadirannya mengingatkan bahwa tanpa kegelapan, cahaya takkan pernah bersinar."

func get_story_character(code):
	return dict_story_character[code]

#var story_s1 = data_story_char_s1_75.new()
#var story_s2 = data_story_char_s2_163.new()
#var story_s3 = data_story_char_s3_218.new()

var all_rank = [
	4, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 5, 5, 6, 1, 1, 1, 1, 2,
	2, 2, 3, 4, 5, 6, 4, 5, 5, 4, 4, 5, 6, 1, 5, 6, 4, 4, 5, 6,
	4, 5, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2,
	2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 6, 6, 4, 4, 4,
	4, 5, 5, 6, 2, 2, 5, 5, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4, 5, 5,
	5, 6, 1, 2, 4, 6, 1, 4, 5, 5, 6, 3, 5, 6, 4, 4, 5, 6, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2,
	2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5,
	5, 5, 5, 5, 6, 6, 5, 1, 6, 1, 1, 2, 1, 5, 4, 1, 1, 1, 1, 1,
	1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3,
	3, 3, 3, 3, 3, 4, 4, 4, 5, 5, 6, 2, 6, 5, 3, 4, 5, 5]
var all_elem = {36:3, 77:4, 118:0, 174:1, 218:2}

var main_code = "id"
func _init() -> void:
	var story_s1 = data_story_char_s1_75.new()
	var story_s2 = data_story_char_s2_163.new()
	var story_s3 = data_story_char_s3_218.new()
	for i in range(1, all_rank.size()+1):
		var key = "s1_%03d" %[i]
		var value
		if all_rank[i-1] >= 4:
			var get_func_name = "hero_%d" %[i]
			if i <= 75:
				if story_s1.has_method(get_func_name):
					value = story_s1.call(get_func_name).get(main_code, "kosong")
				else:
					print("Method: %s hilang!" %[get_func_name])
					value = "Method: %s hilang!" %[get_func_name]
			elif i <= 163:
				if story_s2.has_method(get_func_name):
					value = story_s2.call(get_func_name).get(main_code, "kosong")
				else:
					print("Method: %s hilang!" %[get_func_name])
					value = "Method: %s hilang!" %[get_func_name]
			elif i <= 218:
				if story_s3.has_method(get_func_name):
					value = story_s3.call(get_func_name).get(main_code, "kosong")
				else:
					print("Method: %s hilang!" %[get_func_name])
					value = "Method: %s hilang!" %[get_func_name]
		else:
			if i <= 36: value = dark
			elif i <= 77: value = fire
			elif i <= 118: value = light
			elif i <= 218: value = water
		dict_story_character[key] = value
		
var dict_story_character = {}
