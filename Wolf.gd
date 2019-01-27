extends Node2D

var game
var player
var camera
var dead_line = 670
var wolf_speed = 48

func _ready():
	$deadline.connect("body_entered", self, "_on_player_entered")
	game = get_tree().get_nodes_in_group("master")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	camera = get_tree().get_nodes_in_group("camera")[0]
	position.y = camera.min_y
	

func _process(delta):
	if $deadline.position.y > camera.screen_bot:
		self.position.y -= wolf_speed*delta*2
	else:
		self.position.y -= delta * wolf_speed

func _on_player_entered(body):
	if body.is_in_group("player"):
		yield(get_tree().create_timer(1.0),"timeout")
		if $deadline.position.y <= player.position.y:
			game.game_over() 
