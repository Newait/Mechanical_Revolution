class_name Explosion extends Area2D

@export var final_radius := 100.0
@export var expand_time := 0.8
@export var max_knockback := 3000.0
@export var player_kb_multi := 1.5
@export var max_damage := 100.0
@export var min_damage := 20.0
@onready var explosion_area: CollisionShape2D = %ExplosionArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(explosion_area.shape,"radius",final_radius, expand_time)
	tween.finished.connect(func () -> void:
		queue_free()
	)
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	pass # Replace with function body.

func _on_body_entered(body:Node2D) -> void:
	if body is CharacterBody2D:
		if body is Player:
			
			fling_character(body, true)
			(body as Player).take_damage(calc_damage(body))
		elif body is Enemy:
			fling_character(body)
			(body as Enemy).take_damage(calc_damage(body))
func _on_area_entered(area:Node2D) -> void:
	if area is Projectile:
		area.queue_free()

func fling_character(obj:CharacterBody2D, player:bool=false) -> void:
	var direction = global_position.direction_to(obj.global_position)
	var dist = global_position.distance_to(obj.global_position)

	var magnitude = maxf(1.0 - dist/final_radius, 0.1) * max_knockback * (player_kb_multi if player else 1.0)
	obj.velocity = obj.velocity + direction * magnitude

func calc_damage(obj:CharacterBody2D) -> float:
	var dist = global_position.distance_to(obj.global_position)
	if (obj is Enemy or dist/final_radius < 0.3):
		print("did")
		return maxf(min_damage, (1.0 - dist/final_radius) * max_damage)
	print("min")
	return min_damage

func InitInfo(info:ExplosionInfo) -> void:
	final_radius = info.final_radius
	expand_time = info.expand_time
	
	max_knockback = info.max_knockback
	
	player_kb_multi = info.player_kb_multi
	max_damage = info.max_damage
	min_damage = info.min_damage

func Init(final_rad, expand_timing, max_kb, max_dmg) -> void:
	final_radius = final_rad
	expand_time = expand_timing
	max_knockback = max_kb
	max_damage = max_dmg
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
