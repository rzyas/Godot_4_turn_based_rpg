class_name Data_story_character
extends Node

var nature = "Symbolizing the power of nature, this character serves as a guardian of balance. Their body and aura radiate the essence of earth, water, fire, and wind. At times calm like a flowing river, yet fierce like an unstoppable storm. Their existence reminds others that nature is not merely a resource, but a living force to be respected."
var fire = "Embodiment of fire’s power, this character radiates an unyielding flame that never fades. Every step leaves a trail of heat, carrying light into the darkness. The fire they wield can be a warm shield or a devastating weapon. They reflect the duality of nature: a source of life and a force of destruction, reminding all that fire is not meant to be conquered, but respected."
var water = "Symbolizing the power of water, this character embodies serenity and hidden strength. Like a gentle river that can carve stone, they represent patience and resilience. Beneath their calm surface lies a storm capable of overwhelming everything. The water they command can heal and nurture life, yet also devastate when disregarded. They remind all that true power often flows beneath quiet grace."
var light = "Symbolizing the power of light, this character embodies hope and truth. Their presence radiates serenity and inspiration, like dawn banishing the night. The light they wield can heal wounds, reveal hidden truths, and burn away lurking evil. Yet the brighter the light shines, the greater the shadows it casts. They remind all that light is not only beauty, but also a burden of guidance and responsibility."
var dark = "Symbolizing the power of darkness, this character embodies the shadows born from mystery and fear. They cloak their surroundings in a chilling aura, like a moonless night that devours all light. The darkness they command can serve as comforting concealment or a treacherous snare. They reflect nature’s hidden side: unseen, untouchable, yet ever-present. Their existence reminds all that without darkness, light could never shine."

func get_story_character(code):
	return dict_story_character[code]

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

var main_code = "en"
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
