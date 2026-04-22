class_name LaserWeapon extends Weapon
@onready var cd_timer: Timer = %CDTimer

@export var laser : PackedScene = preload("uid://bjb5k7eu0d6is")
var laserInstance : Laser
var damage := 5.0
var is_firing := false
@onready var laser_sprite: Sprite2D = $Sprite2D


func _process(delta: float) -> void:
	var look := (get_global_mouse_position() - global_position).normalized()
	if look.x < 0.0:
		flip_sprite(true)
		look *= -1.0
	else:
		flip_sprite(false)
	rotation = look.angle()
func flip_sprite(left:bool=false) -> void:
	laser_sprite.position.x = absf(laser_sprite.position.x) * (-1.0 if left else 1.0)
	laser_sprite.flip_h = left

func _ready() -> void:
	cd_timer.timeout.connect(func () -> void:
		_can_fire = true
	)

func contFire(lookVector:Vector2) -> void:
	laserInstance.upd_direction(lookVector)

func _physics_process(delta: float) -> void:
	if is_firing:
		contFire(get_local_mouse_position().normalized())
		if Input.is_action_just_released("Shoot"):
			stop_fire()

func stop_fire() -> void:
	_can_fire = false
	laserInstance.queue_free()
	is_firing = false
	cd_timer.start()
func fire(lookVector:Vector2, _speed:float) -> void:
	#_speed does not apply to lasers
	if _can_fire:
		laserInstance = laser.instantiate()
		laserInstance.Init(lookVector, damage)
		add_child(laserInstance)
		is_firing = true
	#if _can_fire:
		#_can_fire = false
		#timer.start()
		#timer.timeout.connect(func () -> void:
			#_can_fire = true
		#)
	#else:
		#return
	
