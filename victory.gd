extends Area2D

onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var game = get_tree().get_nodes_in_group("master")[0]
onready var greenwall = get_tree().get_root().get_node("Game/ParallaxBackground/ParallaxLayer")
onready var tween = $Tween
onready var victory = false

func _ready():
	connect("body_entered", self, "_on_body_entered")
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		victory = true
		player.stunned = true
		var time = 3600 - int($Timer.time_left)
		camera.active = false
		tween.interpolate_property(camera, "position:y", camera.position.y,
				camera.position.y - 210, 3.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		var wallleft = greenwall.get_node("leftwall")
		var wallright = greenwall.get_node("rightwall")
		var fadeleft = greenwall.get_node("leftfade")
		var faderight = greenwall.get_node("rightfade")
		tween.interpolate_property(wallleft, "position:x", wallleft.position.x,
				wallleft.position.x - 220, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(wallright, "position:x", wallright.position.x,
				wallright.position.x + 220, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(fadeleft, "position:x", fadeleft.position.x,
				fadeleft.position.x - 220, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.interpolate_property(faderight, "position:x", faderight.position.x,
				faderight.position.x + 220, 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		game.win = true
		yield(tween, "tween_completed")
		tween.interpolate_property($yourehome, "modulate:a", 0, 1,
				0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.interpolate_property($congratulations, "modulate:a", 0, 1,
				0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.5)
		$time.text = str(time/60) + ":" + str(time%60)
		tween.interpolate_property($time, "modulate:a", 0, 1,
				0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.8)
		tween.interpolate_property($thankyou, "modulate:a", 0, 1,
				0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 1.5)
		tween.interpolate_property($pressx, "modulate:a", 0, 1,
				0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 2)
		tween.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_focus") and victory == true:
		get_tree().change_scene_to(load("res://MainMenu.tscn"))