class_name Enemy extends CharacterBody2D

var enemyhealth := 100.0
var enemyworth := 50.0
var max_speed := 250.0
var enemystate := "idle"
var acceleration := 100.0
var contact_damage := 10.0
var kb_force := 1000.0
@onready var detect_box: Area2D = %DetectBox
@onready var hitbox: Area2D = %Hitbox

#@onready var raycastright: RayCast2D = %Raycastright
#@onready var raycastleft: RayCast2D = %Raycastleft
#@onready var player:= get_tree().root.get_node("Node2D/Player")
func _ready() -> void:
	detect_box.body_entered.connect(_on_detection_body_entered)
	detect_box.body_exited.connect(_on_detection_body_exited)
	hitbox.body_entered.connect(_on_hitbox_area_shape_entered)

func _get_player_node() -> Player:
	var player := get_tree().root.get_node("Game/Player")
	if (player):
		return player
	else:
		return null

func _get_player_position() -> Vector2:
	return _get_player_node().global_position

func _physics_process(delta: float) -> void:
	var direction:= 0.0
	var playerdirection := global_position.direction_to(_get_player_position())

	var desired_velocity : Vector2
	match enemystate:
		"idle":
			direction = 0.0
			#AnimationPlayer.play("idle_animation")
		"wander":
			#if raycastright.is_colliding():
				direction = -1.0
				#AnimatedSprite2d.flip_h = true
			#if raycastleft.is_colliding():
				direction = 1.0
				#AnimatedSprite2d.flip_h = false
		"pursuit":
			if _get_player_position():
				if playerdirection.x > 0.0:
					direction = 1.0
				elif playerdirection.x < 0.0:
					direction = -1.0
		#"attack":
			#var chasespeed = enemyspeed * playerdirection
			#velocity = velocity.move_toward(chasespeed, acceleration * 1)
		#"stunned":
			#enemyspeed == 0
			##AnimationPlayer2d.play("stunned_animation")
			##spawn_weapon()
	desired_velocity.x = direction * max_speed
	velocity.x = move_toward(velocity.x, desired_velocity.x, acceleration * delta)
	velocity += get_gravity() * delta 
	move_and_slide()

func take_damage(damage: float) -> void:
	enemyhealth -= damage
	if (enemyhealth <= 0.0):
		_on_death()

func _on_hitbox_area_shape_entered(body: Node2D) -> void:
	if body is Player:
		var player := body as Player
		player.take_damage(10.0)
		var kb_direction := global_position.direction_to(player.global_position)
		player.knockback(kb_direction * kb_force)
		
	#player_health -= 10
	# tuff

func _on_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		if enemystate == "idle":
			enemystate = "pursuit"

func _on_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		if enemystate == "pursuit":
			enemystate = "idle"

#func _on_self_body_entered(body: Node2D) -> void:
	#if body is PlayerProjectileGB:
		#print("Happen")
		#enemyhealth -= 20.0
		#if enemyhealth <= 0.0:
			#_on_death()
func _on_death() -> void:
	_get_player_node().heal(enemyworth)
	queue_free()
