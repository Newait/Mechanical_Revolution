class_name PlayerProjectileGB extends Area2D

@export var lifetime:= 5.0
@export var travel_speed:= 200.0
@export var direction := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(func ()-> void:
		queue_free()
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * travel_speed * delta
