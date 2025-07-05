class_name Load_images

func img_stage_star(code):
	var limit_code = clamp(code, 0, 3)
	return str("res://img/UI (new)/star_",limit_code,".png")

var img_star = {
	0:{true:load("res://img/UI (new)/Deck/select_all.png"), false:load("res://img/UI (new)/Deck/select_all_disabled.png")},
	1:{true:load("res://img/UI (new)/Deck/star_1.png"), false:load("res://img/UI (new)/Deck/star_1_disabled.png")},
	2:{true:load("res://img/UI (new)/Deck/star_2.png"), false:load("res://img/UI (new)/Deck/star_2_disabled.png")},
	3:{true:load("res://img/UI (new)/Deck/star_3.png"), false:load("res://img/UI (new)/Deck/star_3_disabled.png")},
	4:{true:load("res://img/UI (new)/Deck/star_4.png"),false:load("res://img/UI (new)/Deck/star_4_disabled.png")},
	5:{true:load("res://img/UI (new)/Deck/star_5.png"),false:load("res://img/UI (new)/Deck/star_5_disabled.png")},
	6:{true:load("res://img/UI (new)/Deck/star_6.png"),false:load("res://img/UI (new)/Deck/star_6_disabled.png")}}
var img_elemen = {
	0:{true:load("res://img/UI (new)/Deck/select_all.png"), false:load("res://img/UI (new)/Deck/select_all_disabled.png")},
	1:{true:load("res://img/Icon Jobs/New icon elements/icn_class_light.png"), false:load("res://img/Icon Jobs/New icon elements/elem_bw_light_disabled.png")},
	2:{true:load("res://img/Icon Jobs/New icon elements/icn_class_nature.png"), false:load("res://img/Icon Jobs/New icon elements/elem_bw_nature_disabled.png")},
	3:{true:load("res://img/Icon Jobs/New icon elements/icn_class_water.png"), false:load("res://img/Icon Jobs/New icon elements/elem_bw_water_disabled.png")},
	4:{true:load("res://img/Icon Jobs/New icon elements/icn_class_dark.png"), false:load("res://img/Icon Jobs/New icon elements/elem_bw_dark_disabled.png")},
	5:{true:load("res://img/Icon Jobs/New icon elements/icn_class_fire.png"), false:load("res://img/Icon Jobs/New icon elements/elem_bw_fire_disabled.png")}}
var img_class = {
	0:{true:load("res://img/UI (new)/Deck/select_all.png"), false:load("res://img/UI (new)/Deck/select_all_disabled.png")},
	1:{true:load("res://img/Icon Class/icn_job_warr.png"), false:load("res://img/Icon Class/class_bw_war_disabled.png")},
	2:{true:load("res://img/Icon Class/icn_job_arch.png"), false:load("res://img/Icon Class/class_bw_arc_disabled.png")},
	3:{true:load("res://img/Icon Class/icn_job_deff.png"), false:load("res://img/Icon Class/class_bw_def_disabled.png")},
	4:{true:load("res://img/Icon Class/icn_job_assa.png"), false:load("res://img/Icon Class/class_bw_assa_disabled.png")},
	5:{true:load("res://img/Icon Class/icn_job_supp.png"), false:load("res://img/Icon Class/class_bw_supp_disabled.png")},
	6:{true:load("res://img/Icon Class/icn_job_mech.png"), false:load("res://img/Icon Class/class_bw_mech_disabled.png")},
	7:{true:load("res://img/Icon Class/icn_job_abbys.png"), false:load("res://img/Icon Class/class_bw_beast_disabled.png")},
	8:{true:load("res://img/Icon Class/icn_job_wiz.png"), false:load("res://img/Icon Class/class_bw_wiz_disabled.png")},
	9:{true:load("res://img/Icon Class/icn_job_heal.png"), false:load("res://img/Icon Class/class_bw_heal_disabled.png")}}
var img_icon = {
	"money":load("res://img/UI (new)/New UI Flat/flat_gold.png"),
	"exp":load("res://img/UI (new)/New UI Flat/flat_mana.png"),
	"ticket":load("res://img/UI (new)/New UI Flat/flat_ticket.png"),
	"warning":load("res://img/UI (new)/Icon/4Warning.png"),
	"repeat":load("res://img/UI (new)/Icon/5Repeat.png"),
	"sekeleton":load("res://img/UI (new)/Icon/5Sekeleton.png"),
	"skip":load("res://img/UI (new)/Icon/6Skip.png"),
	"3star":load("res://img/UI (new)/Icon/7Star3.png"),
	"timer":load("res://img/UI (new)/Icon/8Time.png"),
	"spin":load("res://img/UI (new)/New UI Flat/flat_spin.png"),
	 }

var img_bab = {
	1:
		{1:"res://img/Background/BAB/1/1.png",2:"res://img/Background/BAB/1/2.png",3:"res://img/Background/BAB/1/3.png",
		4:"res://img/Background/BAB/1/4.png",5:"res://img/Background/BAB/1/5.png",6:"res://img/Background/BAB/1/6.png",
		7:"res://img/Background/BAB/1/7.png",8:"res://img/Background/BAB/1/8.png",9:"res://img/Background/BAB/1/9.png",
		10:"res://img/Background/BAB/1/10.png",11:"res://img/Background/BAB/1/11.png",12:"res://img/Background/BAB/1/12.png",
		13:"res://img/Background/BAB/1/13.png",14:"res://img/Background/BAB/1/14.png"},
	2:{1:null,2:null,3:null,4:null,5:null,6:null,7:null,8:null,9:null,10:null,11:null,12:null,13:null,14:null},
	3:{1:null,2:null,3:null,4:null,5:null,6:null,7:null,8:null,9:null,10:null,11:null,12:null,13:null,14:null},
	4:{1:null,2:null,3:null,4:null,5:null,6:null,7:null,8:null,9:null,10:null,11:null,12:null,13:null,14:null},
	5:{1:null,2:null,3:null,4:null,5:null,6:null,7:null,8:null,9:null,10:null,11:null,12:null,13:null,14:null},
	6:{1:null,2:null,3:null,4:null,5:null,6:null,7:null,8:null,9:null,10:null,11:null,12:null,13:null,14:null},
	7:{1:null,2:null,3:null,4:null,5:null,6:null,7:null,8:null,9:null,10:null,11:null,12:null,13:null,14:null}, }

# -------------------- RAW -------------------
func raw_img_eq_gen(code, link):
	var code_limit = clamp(code, 1, 31)
	var temp_num = ""
	if code_limit <10: temp_num="00"
	elif code_limit <99: temp_num="0"
	return str(link + str(temp_num) + str(code_limit) + ".png")
func raw_img_eq_gen_acc(code, link):
	var code_limit = clamp(code, 1, 34)
	var temp_num = ""
	if code_limit <10: temp_num="00"
	elif code_limit <99: temp_num="0"
	return str(link + str(temp_num) + str(code_limit) + ".png")
	
func raw_img_eq_acc(code):
	const link = "res://img/Equipments/acc/"
	return raw_img_eq_gen_acc(code, link)
func raw_img_eq_armor(code):
	const link = "res://img/Equipments/armor/"
	return raw_img_eq_gen(code, link)
func raw_img_eq_glove(code):
	const link="res://img/Equipments/glove/"
	return raw_img_eq_gen(code, link)
func raw_img_eq_helm(code):
	const link = "res://img/Equipments/helm/"
	return raw_img_eq_gen(code, link)
func raw_img_eq_shoes(code):
	const link = "res://img/Equipments/shoes/"
	return raw_img_eq_gen(code, link)
func raw_img_eq_trousers(code):
	const link = "res://img/Equipments/trousers/"
	return raw_img_eq_gen(code, link)
func raw_img_eq_wpn_melee(code):
	const link = "res://img/Equipments/wpn_melee/"
	return raw_img_eq_gen(code, link)
func raw_img_eq_wpn_wiz(code):
	const link = "res://img/Equipments/wpn_wiz/"
	return raw_img_eq_gen(code, link)	
# -------------------- RAW -------------------
func _img_eq_gen_acc(code, link):
	var code_limit = clamp(code, 1, 34)
	var temp_num = ""
	if code_limit <10: temp_num="00"
	elif code_limit <99: temp_num="0"
	return load(link + str(temp_num) + str(code_limit) + ".png")
func _img_eq_gen(code, link):
	var code_limit = clamp(code, 1, 31)
	var temp_num = ""
	if code_limit <10: temp_num="00"
	elif code_limit <99: temp_num="0"
	return load(link + str(temp_num) + str(code_limit) + ".png")

func img_eq_acc(code):
	const link = "res://img/Equipments/acc/"
	return _img_eq_gen_acc(code, link)
func img_eq_armor(code):
	const link = "res://img/Equipments/armor/"
	return _img_eq_gen(code, link)
func img_eq_glove(code):
	const link="res://img/Equipments/glove/"
	return _img_eq_gen(code, link)
func img_eq_helm(code):
	const link = "res://img/Equipments/helm/"
	return _img_eq_gen(code, link)
func img_eq_shoes(code):
	const link = "res://img/Equipments/shoes/"
	return _img_eq_gen(code, link)
func img_eq_trousers(code):
	const link = "res://img/Equipments/trousers/"
	return _img_eq_gen(code, link)
func img_eq_wpn_melee(code):
	const link = "res://img/Equipments/wpn_melee/"
	return _img_eq_gen(code, link)
func img_eq_wpn_wiz(code):
	const link = "res://img/Equipments/wpn_wiz/"
	return _img_eq_gen(code, link)

func img_inventory_fragments(code):
	var num = "00" if code<10 else "0"
	const link = "res://img/Item/Fragments/"
	return load(str(link,num,code,".png"))
func img_inventory_card_gacha(code):
	var num = "00" if code<10 else "0"
	const link = "res://img/Item/Card/"
	return load(str(link,num,code,".png"))
func img_inventory_chest(code):
	var num = "00" if code<10 else "0"
	const link = "res://img/Item/Chest/"
	return load(str(link,num,code,".png"))
func img_inventory_enhance(code):
	var num = "00" if code<10 else "0"
	const link = "res://img/Item/Enhance/"
	return load(str(link,num,code,".png"))
func img_inventory_misc(code):
	var num = "00" if code<10 else "0"
	const link = "res://img/Item/Misc/"
	return load(str(link,num,code,".png"))
func img_inventory_token(code):
	var num = "00" if code<10 else "0"
	const link = "res://img/Item/Token/"
	return load(str(link,num,code,".png"))
	
var img_inven = {
		1:{
			true:load("res://img/Icon Card Manager/inventory/backpack_1.png"),
			false:load("res://img/Icon Card Manager/inventory/backpack_0.png")
		},2:{
			true:load("res://img/Icon Card Manager/inventory/eq_1.png"),
			false:load("res://img/Icon Card Manager/inventory/eq_0.png")
		},3:{
			true:load("res://img/Icon Card Manager/inventory/chest_1.png"),
			false:load("res://img/Icon Card Manager/inventory/chest_0.png")
		} }
	
var img_inven_gear:Dictionary = {
	1:{
		true:load("res://img/Inventory - EQ/wpnm_1.png"),
		false:load("res://img/Inventory - EQ/wpnm_0.png")
	},2:{
		true:load("res://img/Inventory - EQ/wpns_1.png"),
		false:load("res://img/Inventory - EQ/wpns_0.png")
	},3:{
		true:load("res://img/Inventory - EQ/armor_1.png"),
		false:load("res://img/Inventory - EQ/armor_0.png")
	},4:{
		true:load("res://img/Inventory - EQ/gloves_1.png"),
		false:load("res://img/Inventory - EQ/gloves_0.png")
	},5:{
		true:load("res://img/Inventory - EQ/helm_1.png"),
		false:load("res://img/Inventory - EQ/helm_0.png")
	},6:{
		true:load("res://img/Inventory - EQ/shoes_1.png"),
		false:load("res://img/Inventory - EQ/shoes_0.png")
	},7:{
		true:load("res://img/Inventory - EQ/trouser_1.png"),
		false:load("res://img/Inventory - EQ/trouser_0.png")
	},8:{
		true:load("res://img/Inventory - EQ/acc_ring_1.png"),
		false:load("res://img/Inventory - EQ/acc_ring_0.png")
	},9:{
		true:load("res://img/Inventory - EQ/acc_earring_1.png"),
		false:load("res://img/Inventory - EQ/acc_earring_0.png")
	},10:{
		true:load("res://img/Inventory - EQ/acc_nacklaced_1.png"),
		false:load("res://img/Inventory - EQ/acc_nacklaced_0.png")
	},11:{
		true:load("res://img/Inventory - EQ/acc_belt_1.png"),
		false:load("res://img/Inventory - EQ/acc_belt_0.png")
	}, }

func img_eq_stat(code): return load(str("res://img/Inventory - EQ/stat/",code,".png"))
func img_eq_main(code): return load(str("res://img/Inventory - EQ/eq/",code,".png"))
func img_default_gs(code):
	match code:
		"acc_1","acc_2","acc_3","acc_4": code = "acc"
	return load(str("res://img/Inventory - EQ/default_gs/",code,".png"))
func img_default_eq(code):
	match code:
		"acc_1","acc_2","acc_3","acc_4": code = "acc"
	return load(str("res://img/Inventory - EQ/gear/",code,".png"))

var img_gs_none = {true:"res://img/UI (new)/New UI Flat/Gearset/DEFA/EQ_NONE_ICON.png", false:"res://img/UI (new)/New UI Flat/Gearset/DEFA/EQ_NONE_MAIN.png"}
var img_gs_acc = {
	1:{
		true:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_00_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_00_MAIN.png" },
	2:{
		true:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_01_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_01_MAIN.png" },
	3:{
		true:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_02_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_02_MAIN.png" },
	4:{
		true:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_03_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_03_MAIN.png" },
	5:{
		true:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_04_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/ACC/ACC_GS_04_MAIN.png" }, }
var img_gs_bs = {
	1:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_00_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_00_MAIN.png", },
	2:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_01_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_01_MAIN.png", },
	3:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_02_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_02_MAIN.png", },
	4:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_03_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_03_MAIN.png", },
	5:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_04_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_04_MAIN.png", },
	6:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_05_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_05_MAIN.png", },
	7:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_06_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_06_MAIN.png", },
	8:{
		true:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_07_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/BS/EQ_GS_07_MAIN.png", }, }
var img_gs_sc = {
	1:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_00_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_00_MAIN.png" },
	2:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_01_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_01_MAIN.png" },
	3:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_02_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_02_MAIN.png" },
	4:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_03_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_03_MAIN.png" },
	5:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_04_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_04_MAIN.png" },
	6:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_05_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_05_MAIN.png" },
	7:{
		true:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_06_ICON.png",
		false:"res://img/UI (new)/New UI Flat/Gearset/SC/EQ_SC_06_MAIN.png" }, }

func img_gs_main(str_code:String, bool_code:bool):
	match str_code:
		"acc_gs_1", "none": return img_gs_none[bool_code]
		"acc_gs_2":return img_gs_acc[1][bool_code]
		"acc_gs_3":return img_gs_acc[2][bool_code]
		"acc_gs_4":return img_gs_acc[3][bool_code]
		"acc_gs_5":return img_gs_acc[4][bool_code]
		"acc_gs_6":return img_gs_acc[5][bool_code]
		
		"eq_gs_0":return img_gs_bs[1][bool_code]
		"eq_gs_1":return img_gs_bs[2][bool_code]
		"eq_gs_2":return img_gs_bs[3][bool_code]
		"eq_gs_3":return img_gs_bs[4][bool_code]
		"eq_gs_4":return img_gs_bs[5][bool_code]
		"eq_gs_5":return img_gs_bs[6][bool_code]
		"eq_gs_6":return img_gs_bs[7][bool_code]
		"eq_gs_7":return img_gs_bs[8][bool_code]
		
		"eq_gssc_0":return img_gs_sc[1][bool_code]
		"eq_gssc_1":return img_gs_sc[2][bool_code]
		"eq_gssc_2":return img_gs_sc[3][bool_code]
		"eq_gssc_3":return img_gs_sc[4][bool_code]
		"eq_gssc_4":return img_gs_sc[5][bool_code]
		"eq_gssc_5":return img_gs_sc[6][bool_code]
		"eq_gssc_6":return img_gs_sc[7][bool_code]
		
		
		
		
		
