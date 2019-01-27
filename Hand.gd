extends CanvasLayer

func _ready():
	pass

func up():
	$Node2D.visible = true
	$Node2D/AnimationPlayer.play("hand-up")

func down():
	$Node2D/AnimationPlayer.play("hand-down")
	yield(get_tree().create_timer(0.3), "timeout")
	$Node2D.visible = false
