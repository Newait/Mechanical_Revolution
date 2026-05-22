extends Weapon
## This timer's wait_time serves as the cooldown for the weapon
@onready var pistol_sprite: Sprite2D = %PistolSprite
@onready var point_light_2d: PointLight2D = %PointLight2D
@onready var barrel: Node2D = %Barrel
@onready var bullet_collision: GPUParticles2D = %BulletCollision
@onready var muzzle_fx: GPUParticles2D = %MuzzleFX
@onready var pistolshot: AudioStreamPlayer = $pistolshot

@export var flip_list : Array[Node2D]
var firing_fx := false

var tween :Tween

func _ready() -> void:
	bullet_collision.finished.connect(func () -> void:
		firing_fx = false
	)

func _process(delta: float) -> void:
	var look := (get_global_mouse_position() - global_position).normalized()
	if look.x < 0.0:
		flip_sprite(true)
		look *= -1.0
	else:
		flip_sprite(false)
	rotation = look.angle()
func flip_sprite(left:bool=false) -> void:
	var flip_val := (-1.0 if left else 1.0)
	for item:Node2D in flip_list:
		item.position.x = absf(item.position.x) *flip_val
	pistol_sprite.flip_h = left
	bullet_collision.scale = Vector2(flip_val,flip_val) * absf(bullet_collision.scale.x)
	muzzle_fx.scale = Vector2(flip_val,flip_val) * absf(muzzle_fx.scale.x)
	
func fire(lookVector:Vector2,add_speed:= 0.0) -> void:
	pistolshot.play()
	if _can_fire:
		_can_fire = false
		point_light_2d.enabled = true
		if tween != null:
			tween.kill()
			point_light_2d.texture_scale = 1.0
		tween = create_tween()
		tween.tween_property(point_light_2d,"texture_scale",2.0, 0.07)
		tween.finished.connect(func () -> void:
			point_light_2d.texture_scale = 1.0
			point_light_2d.enabled = false
		)
		timer.start()
		timer.timeout.connect(func () -> void:
			_can_fire = true
		)
	else:
		return
	if not firing_fx:
		firing_fx = true
		muzzle_fx.restart()
		bullet_collision.restart()
	
	var newProjectile : Projectile= attack.instantiate()
	newProjectile.travel_speed += add_speed
	newProjectile.direction = lookVector
	get_tree().current_scene.add_child(newProjectile)
	newProjectile.global_position = barrel.global_position
	if (get_parent() is Node2D ):
		newProjectile.global_position = get_parent().global_position
