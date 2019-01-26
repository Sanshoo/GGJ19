extends TextureProgress

onready var player = $"../../Player"

func _ready():
	pass

func _progress(delta):
	self.value = player.sanity