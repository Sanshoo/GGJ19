extends CanvasLayer

var hand_state = "down"

func up():
	if hand_state == "down":
		hand_state = "up"
		$Node2D.visible = true
		$Node2D/AnimationPlayer.play("hand-up")

func down():
	if hand_state == "up":
		hand_state = "down"
		$Node2D/AnimationPlayer.play("hand-down")
		yield(get_tree().create_timer(0.3), "timeout")
		$Node2D.visible = false
