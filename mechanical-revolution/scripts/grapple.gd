class_name Grapple extends RayCast2D
@onready var grapple_line:= %GrappleLine

var is_tethering:=false
var tether_position : Vector2
var tether_length:= 0.0
var is_slack := false
var peak_counts : float
var slack_points : PackedFloat32Array
@export var slack_amplitude := 20.0
var grapple_offset: float= 0.0

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("grapple")):
		attach_tether(get_global_mouse_position())
	grapple_line.clear_points()
	grapple_line.add_point(Vector2.ZERO)
	
	for i in range(slack_points.size()):
		var default_pos := (tether_position-global_position)*slack_points[i]
		
		
		var add_vector := (tether_position-global_position).orthogonal().normalized() * (i%2 -0.5)* 2 *slack_amplitude * grapple_offset
		grapple_line.add_point(default_pos)
	grapple_line.add_point(tether_position-global_position)

func attach_tether(pos:Vector2) -> void:
	tether_position = pos
	is_tethering = true
	#print(pos)
	#print(position)
	tether_length = global_position.distance_to(tether_position)
	grapple_offset = 1.0
	for i in range(floori(tether_length/30.0)):
		slack_points.append(i/floorf(tether_length/30.0))
	#print(grapple_line.points)
	var tween := create_tween().set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self,"grapple_offset", 0.0, 0.5)
	tween.finished.connect(func () -> void:
		grapple_offset = 0.0
		slack_points.clear()
	)


	
