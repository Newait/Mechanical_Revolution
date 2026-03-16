class_name Laser extends RayCast2D

var damage := 5.0
var direction := Vector2.ZERO
var range := 1000.0

@onready var laser_sprite: Sprite2D = $LaserSprite

func _init(look: Vector2, dps: float) -> void:
	direction = look
	damage = dps

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	target_position = direction * range
	laser_sprite.position = (target_position/2 + position)
	laser_sprite.scale.x = target_position.length()
	if is_colliding():
		
		if (get_collider() is Enemy):
			(get_collider() as Enemy).take_damage(damage)

func upd_direction(lookvector:Vector2) -> void:
	direction = lookvector
