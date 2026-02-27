extends Weapon
@export var flippedH:= false
## This timer's wait_time serves as the cooldown for the weapon

@onready var _handle: ColorRect = %Handle
@onready var _barrel: ColorRect = %Barrel


func flipH() -> void:
	flippedH = not flippedH
	_handle.position.x *= -1
	_handle.position.x -= _handle.size.x
	_barrel.position.x *= -1
	_barrel.position.x -= _barrel.size.x
func fire(lookVector:Vector2) -> void:
	if _can_fire:
		_can_fire = false
		timer.start()
		timer.timeout.connect(func () -> void:
			_can_fire = true
		)
	else:
		return
	var newProjectile : PlayerProjectileGB= attack.instantiate()
	newProjectile.direction = lookVector
	get_tree().current_scene.add_child(newProjectile)
	if (get_parent() is Node2D ):
		newProjectile.global_position = get_parent().global_position
