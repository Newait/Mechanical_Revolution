class_name Laser extends RayCast2D

var damage := 5.0
var direction := Vector2.ZERO


func _ready() -> void:
	pass
			

func _physics_process(delta: float) -> void:
	position += direction * delta
	
	if is_colliding():
		if (get_collider() is Enemy):
			(get_collider() as Enemy).take_damage(damage)

func upd_direction(lookvector:Vector2) -> void:
	direction = lookvector
