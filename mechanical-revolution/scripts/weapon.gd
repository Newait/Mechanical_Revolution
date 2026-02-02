class_name Weapon extends Node2D
@export var projectile : PackedScene
@export var flippedH:= false
## This timer's wait_time serves as the cooldown for the weapon
@onready var timer: Timer = %CDTimer
@onready var handle: ColorRect = %Handle
@onready var barrel: ColorRect = %Barrel

		
var _can_fire := true
func flipH() -> void:
	flippedH = not flippedH
	handle.position.x *= -1
	handle.position.x -= handle.size.x
	barrel.position.x *= -1
	barrel.position.x -= barrel.size.x
func fire(lookVector:Vector2) -> void:
	if _can_fire:
		_can_fire = false
		timer.start()
		timer.timeout.connect(func () -> void:
			_can_fire = true
		)
	else:
		return
	var newProjectile : PlayerProjectileGB= projectile.instantiate()
	newProjectile.direction = lookVector
	get_tree().current_scene.add_child(newProjectile)
	if (get_parent() is Node2D ):
		newProjectile.global_position = get_parent().global_position
