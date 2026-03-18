extends Weapon
## This timer's wait_time serves as the cooldown for the weapon
@onready var pistol_sprite: Sprite2D = %PistolSprite

func fire(lookVector:Vector2) -> void:
	if _can_fire:
		_can_fire = false
		timer.start()
		timer.timeout.connect(func () -> void:
			_can_fire = true
		)
	else:
		return
	pistol_sprite.rotation = get_angle_to(lookVector.orthogonal())
	var newProjectile : PlayerProjectileGB= attack.instantiate()
	newProjectile.direction = lookVector
	get_tree().current_scene.add_child(newProjectile)
	if (get_parent() is Node2D ):
		newProjectile.global_position = get_parent().global_position
