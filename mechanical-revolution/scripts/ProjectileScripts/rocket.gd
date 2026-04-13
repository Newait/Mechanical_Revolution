class_name RocketProjectile extends Projectile

@onready var rocket_sprite: Sprite2D = %RocketSprite
@export var friendly_fire_dmg := 20.0
@export var max_explosion_dmg := 200.0

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if (body is Enemy):
		(body as Enemy).take_damage(damage)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	_travel(delta)
func _travel(delta: float) -> void:
	position += direction * travel_speed * delta

func _rotate() -> void:
	rocket_sprite.rotation = direction.angle()
