tool
extends EditorScript

var cell_size = 64

func _run():
	for node in get_scene().get_children():
		if node.is_class("TileMap"):
			for child in node.get_children():
				fix_position(child)

func fix_position(node : StaticBody2D):
	if node.get_parent().is_class("TileMap"):
		var new_pos = Vector2()
		new_pos.x = (floor(node.position.x/cell_size)*cell_size) + 32
		new_pos.y = (floor(node.position.y/cell_size)*cell_size) + 32
		node.position = new_pos
