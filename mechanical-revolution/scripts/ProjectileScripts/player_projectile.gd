@abstract class_name PlayerProjectileGB extends Projectile


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#get_tree().create_timer(lifetime).timeout.connect(func ()-> void:
		#queue_free()
	#)
	#body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		(body as Enemy).take_damage(damage)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _travel(delta: float) -> void:
	position += direction * travel_speed * delta

@abstract func _rotate() -> void
