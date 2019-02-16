extends Area2D

onready var wolf = get_tree().get_nodes_in_group("wolf")[0]
onready var camera = get_tree().get_nodes_in_group("camera")[0]
onready var tween = $Tween

var cutscene_setback_amount = 460
var cutscene_setback_time = 2.0

var triggered = false

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(player):
	if triggered == false:
		if player.is_in_group("player"):
			camera.active = false
			
			tween.interpolate_property(camera, "position:y", camera.position.y,
					camera.position.y + cutscene_setback_amount, cutscene_setback_time,
					Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			player.movable = false
			yield(get_tree().create_timer(0.1),"timeout")
			yield(tween, "tween_completed")
			$AudioStreamPlayer.play()
			camera.wolf_shake()
			var wolf_delta = 340
			tween.interpolate_property(wolf, "position:y",
					wolf.global_position.y, wolf.global_position.y - wolf_delta, 5.0,
					Tween.TRANS_LINEAR, Tween.EASE_IN)
			wolf.visible = true
			player.movable = false
			tween.start()
			yield(get_tree().create_timer(4.0), "timeout")
			tween.interpolate_property(camera, "position:y",
					camera.position.y, camera.position.y - cutscene_setback_amount,
					cutscene_setback_time / 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			yield(tween, "tween_completed")
			wolf.active = true
			player.movable = true
			camera.active = true
			triggered = true