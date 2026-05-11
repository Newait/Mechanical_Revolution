class_name Grapple extends RayCast2D
@onready var grapple_line: Line2D = %GrappleLine

var tether_position : Vector2


signal reel
signal attach

func attach_tether() -> void:
	tether_position = grapple_ray.get_collision_point()
	tether_length = position.distance_to(tether_position)
	var tween:= create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT_IN)
	
