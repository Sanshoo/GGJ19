extends KinematicBody2D

var tile_size = 64

var sanity = 100 # (current sanity)
var sanity_recharge = 30
var max_sanity = 100
var sanity_step = 5
var sanity_hit = 20
var n_pos
var textureback = preload("res://assets/char1back.png")
var texturesideleft = preload("res://assets/char1side1.png")
var texturesideright = preload("res://assets/char1side2.png")
var texturefront = preload("res://assets/char1front.png")

func _ready():
	n_pos = position

func _physics_process(delta):
	# movement
	var move_vec = Vector2(0, 0)
	if Input.is_action_just_pressed("ui_up"):
		move_vec.y -= tile_size
		$PlayerSprite.texture = textureback
	elif Input.is_action_just_pressed("ui_left"):
		move_vec.x -= tile_size
		$PlayerSprite.texture = texturesideright
	elif Input.is_action_just_pressed("ui_right"):
		move_vec.x += tile_size
		$PlayerSprite.texture = texturesideleft
	elif Input.is_action_just_pressed("ui_down"):
		move_vec.y += tile_size
		$PlayerSprite.texture = texturefront
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
	move_and_collide( Vector2(0, tile_size))
	yield(get_tree().create_timer(0.5), "timeout")
	$Sprite.modulate = Color(1, 1, 1)


