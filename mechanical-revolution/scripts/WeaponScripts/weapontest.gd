extends Weapon
## This timer's wait_time serves as the cooldown for the weapon
@onready var pistol_sprite: Sprite2D = %PistolSprite
	
func _process(delta: float) -> void:
	var look := (get_global_mouse_position() - global_position).normalized()
	if look.x < 0.0:
		flip_sprite(true)
		look *= -1.0
	else:
		flip_sprite(false)
	rotation = look.angle()
func flip_sprite(left:bool=false) -> void:
	pistol_sprite.position.x = absf(pistol_sprite.position.x) * (-1.0 if left else 1.0)
	pistol_sprite.flip_h = left
func fire(lookVector:Vector2) -> void:
	if _can_fire:
		_can_fire = false
		timer.start()
		timer.timeout.connect(func () -> void:
			_can_fire = true
		)
	else:
		return
	print(typeof(attack.instantiate()))
	var newProjectile : Projectile= attack.instantiate()
	newProjectile.direction = lookVector
	get_tree().current_scene.add_child(newProjectile)
	if (get_parent() is Node2D ):
		newProjectile.global_position = get_parent().global_position
