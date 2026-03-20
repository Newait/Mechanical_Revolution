class_name lasero extends RayCast2D

var damage = 10


func _process(delta: float) -> void:
	if is_colliding():
		if (get_collider() is Player):
			(get_collider() as Player).take_damage(damage)
