class_name LaserWeapon extends Weapon
@onready var cd_timer: Timer = %CDTimer

@export var laser := Laser
var laserInstance : Laser
var damage := 5.0
var is_firing := false

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
func fire(lookVector:Vector2) -> void:
	if _can_fire:
		laserInstance = laser.new(lookVector, damage)
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
	
