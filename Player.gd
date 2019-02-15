extends KinematicBody2D

var tile_size = 64
var stunned = false
var to_be_moved = false
var movable = true
export (float, 0.0, 1.0, 0.1) var movespeed = 0.2 # in sec
export (bool) var step_pause = true

export (int, 1, 100) var sanity = 26 # (current sanity)
var recharging = false setget recharging_changed
var sanity_recharge = 37
var sanity_thereshold = 33
var max_sanity = 100
var sanity_step = 3
var sanity_hit = 20
var current_step = 0
var n_pos
var m_pos

signal hit

func _ready():
	connect("hit", get_tree().get_nodes_in_group("camera")[0], "shake")
	n_pos = position

func _physics_process(delta):
	# movement
	var move_vec = Vector2(0, 0)
	if movable:
		if Input.is_action_pressed("ui_up"):
			$Sprite.animation = "up"
			to_be_moved = true
			move_vec.y -= tile_size
		elif Input.is_action_pressed("ui_left"):
			$Sprite.animation = "left"
			to_be_moved = true
			move_vec.x -= tile_size
		elif Input.is_action_pressed("ui_right"):
			$Sprite.animation = "right"
			to_be_moved = true
			move_vec.x += tile_size
		elif Input.is_action_pressed("ui_down"):
			$Sprite.animation = "down"
			to_be_moved = true
			move_vec.y += tile_size
		
		if to_be_moved and !stunned and !move_and_collide(move_vec, true, true, true):
			to_be_moved = false
			move_and_collide(move_vec)
			movable = false
			if movespeed != 0:
				$Sprite.position -= move_vec
				$Tween.interpolate_property($Sprite, "position",
						$Sprite.position, Vector2(0, 0), movespeed,
						Tween.TRANS_CUBIC, Tween.EASE_OUT)
				$Tween.start()
				yield($Tween, "tween_completed")
				if step_pause:
					yield(get_tree().create_timer(movespeed/2), "timeout")
			movable = true
	
	if position != n_pos:
		play_footstep()
		sanity -= sanity_step
		n_pos = position
	
	# sanity
	if Input.is_action_just_pressed("ui_focus") and sanity < sanity_thereshold:
		m_pos = position
		self.recharging = true
	elif position != m_pos or !Input.is_action_pressed("ui_focus") or sanity >= max_sanity:
		self.recharging = false
	
	if m_pos == position and recharging and sanity < max_sanity:
		sanity += delta*sanity_recharge

func recharging_changed(value):
	recharging = value
	match value:
		true:
			$SanityRecharge.play()
			get_tree().call_group("hand", "up")
		false:
			$SanityRecharge.stop()
			get_tree().call_group("hand", "down")

func hit():
	emit_signal("hit")
	stunned = true
	$Sprite.modulate = Color(100, 100, 100)
	sanity -= sanity_hit
	match $Sprite.animation:
		"up":
			move_and_collide( Vector2(0, tile_size))
		"down":
			move_and_collide( Vector2(0, -tile_size))
		"right":
			move_and_collide( Vector2(-tile_size, 0))
		"left":
			move_and_collide( Vector2(tile_size, 0))
			
	yield(get_tree().create_timer(0.8), "timeout")
	stunned = false
	$Sprite.modulate = Color(1, 1, 1)

func play_footstep():
	match current_step:
		0:
			$Footsteps.play(0.0)
			yield(get_tree().create_timer(0.5), "timeout")
			$Footsteps.stop()
		1:
			$Footsteps.play(0.5)
			yield(get_tree().create_timer(0.5), "timeout")
			$Footsteps.stop()
		2:
			$Footsteps.play(1.0)
			yield(get_tree().create_timer(0.5), "timeout")
			$Footsteps.stop()
		3:
			$Footsteps.play(1.5)
			yield(get_tree().create_timer(0.5), "timeout")
			$Footsteps.stop()
	current_step += 1
	if current_step > 3: current_step = 0
