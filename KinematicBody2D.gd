extends KinematicBody2D

var tile_size = 64

func _ready():
	pass

func _physics_process(delta):
	# movement
	var move_vec = Vector2(0, 0)
	if Input.is_action_just_pressed("ui_up"):
		move_vec.y -= tile_size
	elif Input.is_action_just_pressed("ui_left"):
		move_vec.x -= tile_size
	elif Input.is_action_just_pressed("ui_right"):
		move_vec.x += tile_size
	elif Input.is_action_just_pressed("ui_down"):
		move_vec.y += tile_size
	print (move_vec)
	move_and_collide(move_vec)