extends StaticBody2D

export (bool) var state = true
var attacking = false

func _ready():
	$Hitbox.connect("body_entered", self, "_on_body_entered")
	$Timer.connect("timeout", self, "_on_timeout")

func _process(delta):
	if state and !attacking:
		$Sprite.frame = 1
		$Hitbox.monitoring = true
	if !state and !attacking :
		$Sprite.frame = 0
		$Hitbox.monitoring = false

func _on_timeout():
	state = !state

func _on_body_entered(body):
	if body.is_in_group("player"):
		attacking = true
		$Sprite.frame = 2
		body.hit()
		yield(get_tree().create_timer(0.5), "timeout")
		$Sprite.frame = 1
		attacking = false
		