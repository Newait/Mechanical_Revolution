extends RayCast2D

#@onready var laser: RayCast2D = $Laser

func _get_enemy_node() -> void:
	var enemy := get_tree().root.get_node("Game/Enemy")


func _get_player_node() -> void:
	var player := get_tree().root.get_node("Game/Player")

func _take_damage(damage) -> void:
	pass

func ready_() -> void:
	_get_player_node()
	_get_enemy_node()
	if is_colliding():
		pass
		
		
			
