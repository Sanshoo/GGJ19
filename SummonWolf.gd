extends Area2D

var triggered = false

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if triggered == false:
		if body.is_in_group("player"):
			get_tree().get_nodes_in_group("wolf")[0].active = true
			get_tree().get_nodes_in_group("wolf")[0].visible = true
			$AudioStreamPlayer.play()
			triggered = true