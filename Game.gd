extends Node

onready var player = $Player
onready var sanitybar = $"GUI/SanityBar"
var game_state = "ingame"
var fade_scene
var win_scene
var alt_tex
var def_tex
var fade
var win

func _ready():
	fade_scene = preload("res://GameOver.tscn") # MUDAR QUANDO ORGANIZAR LUGAR DAS CENAS
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
		fade = fade_scene.instance()
		$Camera.add_child(fade)
		fade.z_index = 5
		remove_child($GUI)
		game_state = "over"

func victory():
	win = win_scene.instance()
	get_tree().change_scene_to(win)
	win.z_index = 5
	remove_child($GUI)
	game_state = "over"