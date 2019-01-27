extends Control

onready var title = $MarginContainer/CenterContainer/HBoxContainer/CenterContainer/TextureRect
onready var coin = $MarginContainer/CenterContainer/HBoxContainer/CenterContainer2/TextureRect2
onready var creditz = $MarginContainer/CenterContainer/HBoxContainer/CenterContainer3/TextureRect

var game
var intro = true

func _ready():
	game = preload("res://Game.tscn")
	title.modulate.a = 0
	coin.modulate.a = 0
	creditz.modulate.a = 0
	yield(get_tree().create_timer(0.3), "timeout")
	title.modulate.a = 1
	yield(get_tree().create_timer(0.5), "timeout")
	creditz.modulate.a = 1
	yield(get_tree().create_timer(0.7), "timeout")
	coin.modulate.a = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_focus") and intro:
		title.modulate.a = 0
		coin.modulate.a = 0
		$MarginContainer2.visible = true
		intro = false
	elif Input.is_action_just_pressed("ui_focus"):
		get_tree().change_scene_to(game)
