extends Node2D

onready var player = $Player
onready var sanitybar = $"GUI/SanityBar"
var game_state = "ingame"
var fade_scene
var fade

func _ready():
	fade_scene = preload("res://GameOver.tscn") # MUDAR QUANDO ORGANIZAR LUGAR DAS CENAS

func _process(delta):
	sanitybar.value = player.sanity
	
	if player.sanity <= 0 and game_state == "ingame":
		fade = fade_scene.instance()
		$Camera.add_child(fade)
		remove_child($GUI)
		game_state = "over"