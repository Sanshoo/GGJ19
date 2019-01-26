extends KinematicBody2D

var tile_size = 64

var sanity = 100 # (current sanity)
var sanity_recharge = 30
var max_sanity = 100
var sanity_step = 5
var sanity_hit = 20
var n_pos

func _ready():
	n_pos = position

func _physics_process(delta):
	# movement
	var move_vec = Vector2(0, 0)
	if Input.is_action_just_pressed("ui_up"):
		$Sprite.animation = "up"
		move_vec.y -= tile_size
	elif Input.is_action_just_pressed("ui_left"):
		$Sprite.animation = "left"
		move_vec.x -= tile_size
	elif Input.is_action_just_pressed("ui_right"):
		$Sprite.animation = "right"
		move_vec.x += tile_size
	elif Input.is_action_just_pressed("ui_down"):
		$Sprite.animation = "down"
		move_vec.y += tile_size
	if (!move_and_collide(move_vec, true, true, true) or 
			move_and_collide(move_vec, true, true, true).collider.name != "Walls"):
		move_and_collide(move_vec)
	
	# sanity
	if position != n_pos:
		sanity -= sanity_step
		n_pos = position
	if Input.is_action_pressed("ui_focus"):
		self.modulate = Color(0.7, 6, 6)
		if sanity < max_sanity:
			sanity += delta*sanity_recharge
	else:
		self.modulate = Color(1, 1, 1)

	# sfx
	if Input.is_action_just_pressed("ui_focus"):
		$SanityRecharge.play()
	if Input.is_action_just_released("ui_focus"):
		$SanityRecharge.stop()

func hit():
	$Sprite.modulate = Color(100, 100, 100)
	sanity -= 20
	match $Sprite.animation:
		"up":
			move_and_collide( Vector2(0, tile_size))
		"down":
			move_and_collide( Vector2(0, -tile_size))
		"right":
			move_and_collide( Vector2(-tile_size, 0))
		"left":
			move_and_collide( Vector2(tile_size, 0))
			
	yield(get_tree().create_timer(0.5), "timeout")
	$Sprite.modulate = Color(1, 1, 1)


