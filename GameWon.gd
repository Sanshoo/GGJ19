extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_focus"):
		get_tree().change_scene_to(load("res://MainMenu.tscn"))
