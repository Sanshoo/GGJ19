extends Sprite

var title

func _ready():
	title = preload("res://MainMenu.tscn")
	$GameOver.modulate.a = 0
	$Flavor.modulate.a = 0
	$insert.modulate.a = 0
	yield(get_tree().create_timer(0.3), "timeout")
	$GameOver.modulate.a = 1
	yield(get_tree().create_timer(0.5), "timeout")
	$Flavor.modulate.a = 1
	yield(get_tree().create_timer(0.7), "timeout")
	$insert.modulate.a = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_focus"):
		get_tree().change_scene_to(title)
