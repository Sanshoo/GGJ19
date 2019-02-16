extends Area2D

onready var ost = get_tree().get_nodes_in_group("ost")[0]
onready var wolf = get_tree().get_nodes_in_group("wolf")[0]
onready var tween = $Tween

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.sanity_step = 0
		wolf.visible = false
		wolf.active = false
		tween.interpolate_property(ost, "volume_db", 0, -12, 1.0,
				Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()