extends Node2D
func get_random_int(rand_min: int, rand_max: int) -> int:
	return randi_range(rand_min, rand_max)

# GATE MONSTER
func play_dg_progress(): $DgProgress.play()
func play_dg_fail(): $DgFail.play()
func play_dg_win(): $DgWin.play()
func play_dg_open():
	$DgOpen.play()
func play_gate_monster(code):
	code = clamp(code, 1, 20)
	var audio_node = get_node_or_null('gate_monster_' + str(code))
	if audio_node:
		audio_node.play()

# ROAD MAP
func play_roadmap_soul():$RoadmapSoul0.play()
func play_menu_select():$MenuSelect.play()
#------------------------------------ BGM:START --------------------------
# Variabel untuk menyimpan state BGM
var bgm_list: Array[AudioStreamPlayer] = []
var all_tracks: Array[AudioStreamPlayer] = []
var current_track: AudioStreamPlayer = null
var played_indices: Array[int] = []

enum ENUM_BGM {LOBBY, SHOP, BATTLE, ROADMAP}

func lw_onready_bgm(bgm: ENUM_BGM):
	# Reset semua track yang ada (hentikan semua BGM apapun yang sedang bermain)
	_reset_all_bgm()
	
	# Inisialisasi daftar BGM baru sesuai enum
	match bgm:
		ENUM_BGM.SHOP:
			bgm_list = [$BGM_Shop, $BGM_Shop_2, $BGM_Shop_3]
		ENUM_BGM.LOBBY:
			bgm_list = [$BGM_Lobby_0, $BGM_Lobby_1, $BGM_Lobby_2, $BGM_Lobby_3, $BGM_Lobby_4, $BGM_Lobby_5, $BGM_Lobby_6, $BGM_Lobby_7]
		ENUM_BGM.BATTLE:
			bgm_list = [$BgmBattle1, $BgmBattle2, $BgmBattle3, $BgmBattle4, $BgmBattle5, $BgmBattle6]
		ENUM_BGM.ROADMAP:
			bgm_list = [$Roadmap1, $Roadmap2, $Roadmap3, $Roadmap4, $Roadmap5]
	# Register semua track ke list total untuk reset di masa depan
	all_tracks = []
	for track in bgm_list:
		if not all_tracks.has(track):
			all_tracks.append(track)
	
	# Reset state internal
	current_track = null
	played_indices.clear()
	
	# Mulai putar BGM pertama
	lw_play_next_bgm()

func _reset_all_bgm():
	# Hentikan semua track apapun yang sedang berjalan
	for track in all_tracks:
		if track and track.playing:
			track.stop()
		if track and track.finished.is_connected(lw_on_bgm_finished):
			track.finished.disconnect(lw_on_bgm_finished)

func lw_play_next_bgm():
	# Reset daftar jika semua track sudah diputar
	if played_indices.size() >= bgm_list.size():
		played_indices.clear()
	
	# Buat daftar track yang tersedia
	var available_indices: Array[int] = []
	for i in bgm_list.size():
		if not played_indices.has(i) and bgm_list[i] != current_track:
			available_indices.append(i)
	
	# Jika tidak ada yang tersedia, gunakan semua track
	if available_indices.is_empty():
		available_indices = range(bgm_list.size())
	
	# Pilih track secara random
	var selected_index = available_indices[randi() % available_indices.size()]
	current_track = bgm_list[selected_index]
	
	# Pastikan track valid sebelum diputar
	if current_track and current_track.stream:
		# Connect signal untuk track selesai
		if not current_track.finished.is_connected(lw_on_bgm_finished):
			current_track.finished.connect(lw_on_bgm_finished)
		
		# Putar track
		current_track.play()
		played_indices.append(selected_index)

func lw_on_bgm_finished():
	lw_play_next_bgm()

#------------------------------------ BGM:END --------------------------

var current_sfx:AudioStreamPlayer
func play_system_fail(): $SystemFail.play()
func play_lucky_wheel_freespin(): $LwFreespin.play()
func play_lucky_wheel_jackpot(): $LwJackpot.play()
func play_lucky_wheel_jackpot_super(): $LwJackpotSuper.play()
func play_lucky_wheel_reward(_bool:bool):
	if _bool: $LwRewardMana.play()
	else: $LwRewardMoney.play()
func play_lucky_wheel_fail():
	var rng = randi_range(0, 2)
	var all_sfx = [
		$LuckyWheelFail1,
		$LuckyWheelFail2,
		$LuckyWheelFail3,
	]
	all_sfx[rng].play()
func play_lucky_wheel(): $LuckyWheelDing.play()
func play_random_enhance()-> void:
	var rng = randi_range(1, 6)
	var _data= {
		1:$Enhance01,
		2:$Enhance02,
		3:$Enhance03,
		4:$Enhance04,
		5:$Enhance05,
		6:$Enhance06,
	}
	_data[rng].play()
func play_enhance_spell(): $EnhanceSpell.play()
func play_count():$Count.play()
func play_popup():$Popup.play()
func play_exp():$Exp.play()
func play_jackpot():$Jackpot.play()
func play_jackpot_super():
	var jps:AudioStreamPlayer = $JackpotSuper
	jps.play()
	await jps.finished
func play_money():$Money.play()
func play_explosion():$SfxExplosion0.play()
func play_clock():$SfxClock.play()
func play_click():$SfxClick.play()
func play_item_open():$SfxItemOpen0.play()
func play_item_close():$SfxItemClose.play()
func play_iswin(_bool: bool):
	var sfx_win = [$SfxWin0, $SfxWin1, $SfxWin2]
	var sfx_lose = [$SfxLose0, $SfxLose1, $SfxLose2, $SfxLose3]

	if _bool and sfx_win.size():
		var rng = get_random_int(0, sfx_win.size()-1)
		sfx_win[rng].play()
	elif not _bool and sfx_lose.size():
		var rng = get_random_int(0, sfx_lose.size()-1)
		sfx_lose[rng].play()

func play_heal(): $Heal.play()
func play_isheroturn(_bool:bool):
	var get_data = [$VaiYourTurn, $VaiEnemyTurn]
	if _bool: get_data[0].play()
	elif _bool == false: get_data[1].play()
func play_score():
	var get_sfx:AudioStreamPlayer = $ScoreBatch
	get_sfx.volume_db = -20
	get_sfx.play()

func play_star_drop():
	var get_sfx:AudioStreamPlayer = $star_drop
	get_sfx.play()
func play_sfx_buff():
	var sfx_buff = $SfxBuff
	var new_sfx:AudioStreamPlayer = sfx_buff
	new_sfx.volume_db = -20
	new_sfx.play()
func play_turn_select():
	var get_sfx = $SelectTurnIcon
	var new_sfx:AudioStreamPlayer = get_sfx
	new_sfx.play()
	
func play_random_bgm_battle():
	# Array berisi referensi node AudioStreamPlayer
	var arr_sfx_battle = [$BgmBattle00, $BgmBattle01, $BgmBattle02, $BgmBattle03, $BgmBattle04]
	var rng = get_random_int(0, arr_sfx_battle.size() - 1)
	
	# Ambil BGM acak
	current_sfx = arr_sfx_battle[rng]
	current_sfx.volume_db = -10
	current_sfx.play()
	
	# Hubungkan sinyal `finished` agar lagu diulang
	current_sfx.finished.connect(_on_bgm_finished)

func _on_bgm_finished():
	# Pastikan current_sfx valid sebelum memutar ulang
	if current_sfx:
		current_sfx.play()

func stop_random_bgm_battle():
	if current_sfx and current_sfx.is_playing():
		current_sfx.stop()
		current_sfx.finished.disconnect(_on_bgm_finished)  # Hentikan loop
	else:
		print("sfx manager stop not working")
		
func play_random_sfx(arr_sfx: Array, error_message: String) -> void:
	var rng = get_random_int(0, arr_sfx.size() - 1)
	if arr_sfx[rng]: arr_sfx[rng].play()
	else: print(error_message)

func sfx_random_dagger() -> void:
	var arr_dagger_sfx = [$SfxDaggerHit1, $SfxDaggerHit2, $SfxDaggerHit3, $SfxDaggerHit4, $SfxDaggerHit5, $SfxDaggerHit6]
	play_random_sfx(arr_dagger_sfx, "SFX tidak tersedia atau null")

func sfx_random_sword() -> void:
	var arr_sfx = [$SfxSwordhit0, $SfxSwordhit1, $SfxSwordhit2, $SfxSwordhit3, $SfxSwordhit4]
	play_random_sfx(arr_sfx, "ERROR: sfx sword slash not found")

func sfx_random_claw() -> void:
	var arr_sfx = [$SfxClaw0, $SfxClaw1, $SfxClaw2, $SfxClaw3]
	play_random_sfx(arr_sfx, "ERROR: sfx sword slash not found")

func sfx_magic_spell() -> void:
	var arr_sfx = [$SfxMagicspell00, $SfxMagicspell01, $SfxMagicspell02, $SfxMagicspell03, $SfxMagicspell04]
	play_random_sfx(arr_sfx, "ERROR: sfx magic spell not found")

func sfx_arrow() -> void:
	var arr_sfx = [$SfxArrow0, $SfxArrow1, $SfxArrow2, $SfxArrow3]
	for value in range(6):
		play_random_sfx(arr_sfx, "ERROR: sfx magic spell not found")
		await get_tree().create_timer(.5).timeout
