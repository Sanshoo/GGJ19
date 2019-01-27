extends Camera2D

export (int) var vertical_offset = -50
var screen_top
var screen_bot
var max_y
var min_y

func _ready():
	# set min and max y from position2d child nodes
	max_y = $"../Level/max_y".position.y
	min_y = $"../Level/min_y".position.y

func _process(delta):
	var next_pos = $"../Player".position.y + vertical_offset
	screen_top = next_pos - 300
	screen_bot = next_pos + 300
	if screen_top > max_y and screen_bot < min_y:
		position.y = next_pos