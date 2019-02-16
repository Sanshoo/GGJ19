extends Node2D

var title
export (String) var c_mortis

func _ready():
	title = preload("res://MainMenu.tscn")
	$gameover.modulate.a = 0
	$wolf.modulate.a = 0
	$sanity.modulate.a = 0
	$insert.modulate.a = 0
	yield(get_tree().create_timer(0.3), "timeout")
	$gameover.modulate.a = 1
	yield(get_tree().create_timer(0.5), "timeout")
	match c_mortis:
		"sanity":
			$sanity.modulate.a = 1
		"wolf":
			$wolf.modulate.a = 1
	yield(get_tree().create_timer(0.7), "timeout")
	$insert.modulate.a = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_focus"):
		get_tree().change_scene_to(title)
