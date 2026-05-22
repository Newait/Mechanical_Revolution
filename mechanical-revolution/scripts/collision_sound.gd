extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	finished.connect(func () -> void:
		queue_free() 
	)
	pass
