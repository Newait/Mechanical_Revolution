class_name Grapple extends RayCast2D
@onready var grapple_line:= %GrappleLine

signal attach_grapple
signal detach_grapple
signal reel_grapple

var is_tethering:=false
var tether_position : Vector2
var tether_length:= 0.0
var peak_counts : float
var slack_points : PackedFloat32Array
var appeared_length := 0.0
var is_detaching := false
var is_slack := false
@export var max_dist := 800.0
@export var slack_amplitude := 20.0
var grapple_offset: float= 0.0
var anim_tween :Tween
var grapple_start_time : int
var can_reel := true
var reel_cd := 1.0

func end_tween() -> void:
	if anim_tween != null:
		anim_tween.kill()
	if is_slack:
		is_slack = false
	anim_tween = null
	
func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("grapple") and (not is_tethering)):
		target_position = get_local_mouse_position().normalized() * max_dist
		var pointParams := PhysicsPointQueryParameters2D.new()
		pointParams.collide_with_areas = true
		pointParams.collide_with_bodies = false
		pointParams.position = get_global_mouse_position()
		pointParams.collision_mask = 2
		force_raycast_update()
		if(get_viewport().world_2d.direct_space_state.intersect_point(pointParams)):
			attach_tether(get_global_mouse_position())
			#print("ran")
		elif (is_colliding()):
			attach_tether(get_collision_point())
	if (Input.is_action_just_released("grapple") and is_tethering):
		detach_tether()
	grapple_line.clear_points()
	if (is_tethering):
		if (is_slack):
			larp_points(delta)
		if not is_detaching:
			target_position = tether_position - global_position
			force_raycast_update()
			if is_colliding() and get_collision_point().distance_to(tether_position) > 0.05:
				detach_tether()
		if (not is_detaching):
			appeared_length = (tether_position-global_position).length()
		grapple_line.add_point(Vector2.ZERO)
		#print(slack_points)
		for i in range(slack_points.size()):
			var default_pos := (tether_position-global_position)*slack_points[i]
			
			
			var add_vector := (tether_position-global_position).orthogonal().normalized() * (i%2 -0.5)* 2 *slack_amplitude * grapple_offset
			grapple_line.add_point(default_pos + add_vector)
		if is_detaching:
			grapple_line.add_point((tether_position-global_position) * appeared_length/((tether_position-global_position) as Vector2).length() )
		else:
			grapple_line.add_point(tether_position-global_position)

func attach_tether(pos:Vector2) -> void:
	tether_position = pos
	attach_grapple.emit()
	#print(pos)
	#print(position)
	tether_length = global_position.distance_to(tether_position)
	grapple_start_time = Time.get_ticks_msec()
	grapple_offset = 1.0
	for i in range(floori(tether_length/30.0)):
		slack_points.append(i/floorf(tether_length/30.0))
	anim_tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
	anim_tween.tween_property(self,"grapple_offset", 0.0, 0.5)
	is_slack = true
	anim_tween.finished.connect(func () -> void:
		grapple_offset = 0.0
		slack_points.clear()
		is_slack = false
	)
	is_tethering = true


func larp_points(delta:float) -> void:
	var ogPoints := []
	for i in range(slack_points.size() - 2, -1, -1):
		#ogPoints.append(i/ (slack_points.size() as float) )
		slack_points[i] = lerpf(slack_points[i],slack_points[i+1], 10.0 * delta) 

func detach_tether() -> void:
	peak_counts = 0.0
	is_detaching = true
	var detach_time := 0.5
	print(Time.get_ticks_msec() - grapple_start_time)
	if (Time.get_ticks_msec() - grapple_start_time < 300) and can_reel:
		can_reel = false
		get_tree().create_timer(reel_cd).timeout.connect(func () -> void:
			can_reel = true
		)
		reel_grapple.emit()
		anim_tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
		detach_time = 0.25
	else:
		detach_grapple.emit()
		anim_tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	

	anim_tween.tween_property(self, "appeared_length", 0.0, detach_time)
	anim_tween.finished.connect(func () -> void:
		tether_length = 0.0
		appeared_length = 0.0
		is_tethering = false
		tether_position = Vector2.ZERO
		is_detaching = false
		end_tween()
	)
	

	
