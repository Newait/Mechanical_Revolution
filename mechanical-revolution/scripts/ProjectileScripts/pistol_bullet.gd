class_name PistolBullet extends Projectile

@onready var bullet_sprite: Sprite2D = %BulletSprite

func _on_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		(body as Enemy).take_damage(damage)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _travel(delta: float) -> void:
	position += direction * travel_speed * delta

func _rotate() -> void:
	bullet_sprite.rotation = direction.angle()

func _physics_process(delta: float) -> void:
	_travel(delta)
