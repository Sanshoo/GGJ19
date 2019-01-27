extends StaticBody2D

export (bool) var state = true
var attacking = false

func _ready():
	$Hitbox.connect("body_entered", self, "_on_body_entered")
	$Timer.connect("timeout", self, "_on_timeout")

func _process(delta):
	if state and !attacking:
		$Sprite.animation = "active"
		$Hitbox.monitoring = true
	if !state and !attacking :
		$Sprite.animation = "inactive"
		$Hitbox.monitoring = false

func _on_timeout():
	state = !state

func _on_body_entered(body):
	if body.is_in_group("player"):
		attacking = true
		$Sprite.animation = "attack"
		$AudioStreamPlayer.play()
		body.hit()
		yield(get_tree().create_timer(0.7), "timeout")
		$Sprite.animation = "active"
		attacking = false
		