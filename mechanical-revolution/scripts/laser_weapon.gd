class_name LaserWeapon extends Weapon
@export var laser : PackedScene


func fire(lookVector:Vector2) -> void:
	#if _can_fire:
		#_can_fire = false
		#timer.start()
		#timer.timeout.connect(func () -> void:
			#_can_fire = true
		#)
	#else:
		#return
	var newLaser : Laser= laser.instantiate()
	
