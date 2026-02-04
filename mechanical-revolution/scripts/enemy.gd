class_name Enemy extends CharacterBody2D

var enemyhealth := 100
var max_speed := 67
var enemystate := "idle"
var acceleration := 100.0
var playerdirection := global_position.direction_to(player_position())
@onready var raycastright: RayCast2D = %Raycastright
@onready var raycastleft: RayCast2D = %Raycastleft
@onready var player: Player = %Player

func _physics_process(delta: float) -> void:
	var direction:= 0.0
	if player:
		if global_position.direction_to(player.global_position).x > 0.0:
			direction = 1.0
		elif global_position.direction_to(player.global_position).x < 0.0:
			direction = -1.0

	var desired_velocity : Vector2
	match enemystate:
		"idle":
			desired_velocity = Vector2.ZERO
			#AnimationPlayer.play("idle_animation")
		"wander":
			if raycastright.is_colliding():
				direction = -1.0
				#AnimatedSprite2d.flip_h = true
			if raycastleft.is_colliding():
				direction = 1.0
				#AnimatedSprite2d.flip_h = false
		#"attack":
			#var chasespeed = enemyspeed * playerdirection
			#velocity = velocity.move_toward(chasespeed, acceleration * 1)
		#"stunned":
			#enemyspeed == 0
			##AnimationPlayer2d.play("stunned_animation")
			##spawn_weapon()
	desired_velocity.x = direction * max_speed
	velocity.x = move_toward(velocity.x, desired_velocity.x, acceleration * delta)
	move_and_slide()



func player_position():
	return player.global_position


func _on_hitbox_area_shape_entered() -> void:
	pass
	#player_health -= 10
	# tuff



func _on_detection_body_entered(body: Node2D) -> void:
	player_position()
