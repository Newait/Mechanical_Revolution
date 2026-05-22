class_name Laser extends RayCast2D

var damage := 5.0
var direction := Vector2.ZERO
@export var range := 1000.0

@export var laser_sparks :PackedScene
var laser_sparks_instance:GPUParticles2D
@export var laser_sear :PackedScene
var laser_sear_instance:GPUParticles2D
#@onready var laser_sprite: Sprite2D = %LaserSprite
@export var laser_line: Line2D
@export var max_width := 50.0
func Init(look: Vector2, dps: float) -> void:
	direction = look
	damage = dps

func _ready() -> void:
	laser_sear_instance = laser_sear.instantiate()
	get_tree().current_scene.add_child(laser_sear_instance) 
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.set_loops()
	tween.tween_property(laser_line as Line2D,"width", max_width *0.8, 0.25)
	tween.tween_property(laser_line as Line2D, "width", max_width, 0.25)
	

func _physics_process(delta: float) -> void:
	var parent_local_mouse_position = (get_parent() as CanvasItem).get_local_mouse_position() if get_parent() != null else get_local_mouse_position()
	target_position = parent_local_mouse_position.normalized() * range
	
	var point_direction := target_position
	if is_colliding():
		if laser_sparks_instance == null:
			
			laser_sparks_instance = laser_sparks.instantiate()
			
			get_tree().current_scene.add_child(laser_sparks_instance)
			#
		if laser_sear_instance != null and not laser_sear_instance.emitting:
			laser_sear_instance.emitting = true
			#upd_particles()
		#if laser_sear_instance == null and (get_collision_point()- global_position):
			#
			#laser_sear_instance = laser_sear.instantiate()
			#
			#get_tree().current_scene.add_child(laser_sear_instance)
			#
			#upd_particles()
		#if laser_sear_instance != null and not laser_sear_instance.emitting:
			#laser_sear_instance.emitting= true
		if laser_sparks_instance != null and laser_sear_instance != null:
			#if (not laser_sear_instance.emitting):
				#laser_sear_instance.emitting = true
			upd_particles()

		if (get_collider() is Enemy):
			(get_collider() as Enemy).take_damage(damage)
		point_direction = parent_local_mouse_position.normalized() * (get_collision_point() - global_position).length() *2.4
	else:
		if (laser_sparks_instance != null):
			laser_sparks_instance.queue_free()
			laser_sparks_instance = null
		if (laser_sear_instance != null) and laser_sear_instance.emitting:
			laser_sear_instance.emitting = false
			laser_sear_instance.global_position = global_position
			#cut_off_sear()
		#if (laser_sear_instance != null and laser_sear_instance.emitting):
			#laser_sear_instance.emitting = false
	
	
	# Grab the global position of the enemy and convert to local coordinates
	#var enemy : Node2D
	#to_local
	
	laser_line.clear_points()
	
	laser_line.add_point(Vector2.ZERO)
	laser_line.add_point(point_direction)

func upd_direction(lookvector:Vector2) -> void:
	direction = lookvector

func cut_off_sear() -> void:
	laser_sear_instance.emitting = false
	laser_sear_instance.one_shot = true
	laser_sear_instance.finished.connect(func () -> void:
		print("clearing")
		laser_sear_instance.queue_free()
		
	)
	laser_sear_instance = null

func upd_particles() -> void:
	laser_sparks_instance.global_position = get_collision_point()
	laser_sparks_instance.rotation = (-get_collision_normal().orthogonal()).angle()
	if laser_sear_instance != null:
		laser_sear_instance.global_position = get_collision_point()
		laser_sear_instance.rotation = (-get_collision_normal().orthogonal()).angle()
		
