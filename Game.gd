extends Node

onready var player = $Player
onready var sanitybar = $"GUI/SanityBar"
var game_state = "ingame"
var over_scene
var win_scene
var alt_tex
var def_tex
var out_of_loop = true
var win

func _ready():
	$OST.connect("finished", self, "ost_mng")
	win_scene = preload("res://GameWon.tscn")
	def_tex = load("res://assets/sanity-bar/danger.png")
	alt_tex = load("res://assets/sanity-bar/progress.png")

func _process(delta):
	sanitybar.value = player.sanity
	if sanitybar.value > player.sanity_thereshold:
		sanitybar.texture_progress = alt_tex
	else:
		sanitybar.texture_progress = def_tex
	
	if player.sanity <= 0 and game_state == "ingame":
		game_over("sanity")

func ost_mng():
	if out_of_loop:
		$OST.stream = load("res://assets/ost/Tema Loop.wav")
		$OST.play()
	else:
		$OST.play()

func game_over(causa):
	match causa:
		"wolf":
			get_tree().change_scene_to(load("res://GameOverWol.tscn"))
		"sanity":
			get_tree().change_scene_to(load("res://GameOverSan.tscn"))

func victory():
	win = win_scene.instance()
	get_tree().change_scene_to(win)
	win.z_index = 5
	remove_child($GUI)
	game_state = "over"