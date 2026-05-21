class_name PistolBullet extends Projectile

@onready var bullet_sprite: Sprite2D = %BulletSprite
@export var bullet_collide :PackedScene
@onready var ray_cast_2d: RayCast2D = %RayCast2D

func _on_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		(body as Enemy).take_damage(damage)
	var particle :GPUParticles2D = bullet_collide.instantiate() 
	get_tree().current_scene.add_child(particle)
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():

		particle.rotation = (-ray_cast_2d.get_collision_normal().orthogonal()).angle()
	particle.global_position = global_position
	particle.emitting = true
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _travel(delta: float) -> void:
	position += travel_speed * delta * direction

func _rotate() -> void:
	rotation = direction.angle()

func _physics_process(delta: float) -> void:
	_travel(delta)
