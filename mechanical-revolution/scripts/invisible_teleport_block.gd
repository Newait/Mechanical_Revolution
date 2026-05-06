extends Area2D

@export var tp_scene :PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func on_body_entered(body:Node2D):
	get_tree().change_scene_to_packed(tp_scene)
