class_name Enemy extends CharacterBody2D

var enemyhealth := 100
var max_speed := 67
var enemystate := "idle"
var acceleration := 100.0
@onready var detect_box: Area2D = %DetectBox

#@onready var raycastright: RayCast2D = %Raycastright
#@onready var raycastleft: RayCast2D = %Raycastleft
#@onready var player:= get_tree().root.get_node("Node2D/Player")
func _ready() -> void:
	detect_box.body_entered.connect(_on_detection_body_entered)
	detect_box.body_exited.connect(_on_detection_body_exited)

func _get_player_position() -> Vector2:
	return get_tree().root.get_node("Game/Player").global_position

func _physics_process(delta: float) -> void:
	var direction:= 0.0
	var playerdirection := global_position.direction_to(_get_player_position())

	print(direction)
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





func _on_hitbox_area_shape_entered() -> void:
	pass
	#player_health -= 10
	# tuff



func _on_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		if enemystate == "idle":
			enemystate = "pursuit"


func _on_detection_body_exited(body: Node2D) -> void:
	enemystate = "idle"
