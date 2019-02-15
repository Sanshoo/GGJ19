extends Node2D

onready var title = $name
onready var coin = $insertcoin
onready var creditz = $creditz
onready var controls1 = $controls1
onready var controls2 = $controls2

var game
var intro = true

func _ready():
	game = preload("res://Tutorial.tscn")
	title.modulate.a = 0
	coin.modulate.a = 0
	creditz.modulate.a = 0
	controls1.modulate.a = 0
	controls2.modulate.a = 0
	yield(get_tree().create_timer(0.3), "timeout")
	if intro: title.modulate.a = 1
	yield(get_tree().create_timer(0.5), "timeout")
	creditz.modulate.a = 1
	yield(get_tree().create_timer(0.7), "timeout")
	if intro: coin.modulate.a = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_focus") and intro:
		intro = false
		coin.modulate.a = 0
		yield(get_tree().create_timer(0.3), "timeout")
		title.modulate.a = 0
		yield(get_tree().create_timer(0.3), "timeout")
		controls1.modulate.a = 1
		yield(get_tree().create_timer(0.5), "timeout")
		controls2.modulate.a = 1
	if Input.is_action_just_pressed("ui_focus") and !intro:
		get_tree().change_scene_to(game)
