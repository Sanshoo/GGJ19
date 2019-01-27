extends Node2D

var game
var player
var camera
var active = true
var nearby = false
var distance_dif
var wolf_speed = 68

func _ready():
	game = get_tree().get_nodes_in_group("master")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	camera = get_tree().get_nodes_in_group("camera")[0]
	position.y = camera.min_y
	

func _process(delta):
	distance_dif = self.global_position.y - player.global_position.y
	if active:
		if distance_dif > 350:
			self.position.y -= delta * wolf_speed * 3
		elif nearby:
			self.position.y -= delta * wolf_speed * 0.6
		else:
			self.position.y -= delta * wolf_speed
		
		if distance_dif <= 20:
			nearby = true
			yield(get_tree().create_timer(1.0),"timeout")
			if distance_dif <= 0:
				game.game_over()
			else:
				nearby = false