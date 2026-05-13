class_name Grapple extends RayCast2D
@onready var grapple_line: Line2D = %GrappleLine

var is_tethering:=false
var tether_position : Vector2
var is_slack := false
var grapple_offset:= 0.0:
	set(val):
		if (val > 0.0) and is_tethering:
			if (not is_slack):
				

func attach_tether() -> void:
	tether_position = grapple_ray.get_collision_point()
	tether_length = position.distance_to(tether_position)
	var tween:= create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT_IN)
	
