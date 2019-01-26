extends Camera2D

export (int) var vertical_offset = -130

var max_y
var min_y

func _ready():
	# set min and max y from position2d child nodes
	max_y = $"../Level/max_y".position.y
	min_y = $"../Level/min_y".position.y

func _process(delta):
	var next_pos = $"../Player".position.y + vertical_offset
	var screen_top = next_pos - 300
	var screen_bot = next_pos + 300
	if screen_top > max_y and screen_bot < min_y:
		position.y = next_pos