extends CharacterBody2D

var enemyhealth := 100
var speed := 67
var enemystate := "idle"
var direction := 1
var acceleration := 100
var playerdirection := global_position.direction_to(player_position())
@onready var raycastright: RayCast2D = %Raycastright
@onready var raycastleft: RayCast2D = %Raycastleft

func _physics_process(delta: float) -> void:
	var enemyspeed = speed * delta * position.x 
	match enemystate:
		"idle":
			if enemystate == "idle":
				enemyspeed == 0
				#AnimationPlayer.play("idle_animation")
			else:
				enemyspeed == speed * delta * position.x
		"wander":
			if raycastright.is_colliding():
				direction = -1
				#AnimatedSprite2d.flip_h = true
			if raycastleft.is_colliding():
				direction = 1
				#AnimatedSprite2d.flip_h = false
		"attack":
			var chasespeed = enemyspeed * playerdirection
			velocity = velocity.move_toward(chasespeed, acceleration * 1)
		"death":
			if enemyhealth <= 0:
				#AnimationPlayer2d.play("death_animation")
				#When AnimationPlayer2d.play("death_animation").finished():
					get_tree().get_node("game/enemy").queue_free()
		"stunned":
			enemyspeed == 0
			#AnimationPlayer2d.play("stunned_animation")


func player_position():
	return get_tree().get_node("game/player").global_position


func _on_hitbox_area_shape_entered() -> void:
	pass
	#player_health -= 10
	# tuff
