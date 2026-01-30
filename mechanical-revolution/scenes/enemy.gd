extends CharacterBody2D

var Health = 100
var Speed = 67
var EnemyState = "Idle"

func _physics_process(delta: float) -> void:
	
		
	
	var EnemySpeed = Speed * delta * position.x 
	#if PlayerState == "Seen":
		#EnemyState == "Attack"
	#else:
		#EnemyState == "Idle"
	
	#if EnemyState == "Idle"
		#AnimationPlayer.play("idle animation")
		#EnemySpeed == 0

func _on_hitbox_area_shape_entered() -> void:
	pass
	#player_health -= 10
	# tuff


func stunned() -> void:
	pass
	
