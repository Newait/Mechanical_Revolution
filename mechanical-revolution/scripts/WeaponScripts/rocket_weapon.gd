class_name RocketWeapon extends Weapon

var laserInstance : Laser
var damage := 5.0
var is_firing := false
@onready var rocket_sprite: Sprite2D = $RocketSprite



func _process(delta: float) -> void:
	var look := (get_global_mouse_position() - global_position).normalized()
	if look.x < 0.0:
		flip_sprite(true)
		look *= -1.0
	else:
		flip_sprite(false)
	rotation = look.angle()
func flip_sprite(left:bool=false) -> void:
	rocket_sprite.position.x = absf(rocket_sprite.position.x) * (-1.0 if left else 1.0)
	rocket_sprite.flip_h = left

func _ready() -> void:
	timer.timeout.connect(func () -> void:
		_can_fire = true
	)

func contFire(lookVector:Vector2) -> void:
	laserInstance.upd_direction(lookVector)	

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
