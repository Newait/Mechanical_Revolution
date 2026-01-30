class_name Weapon extends Node2D
@export var projectile : PackedScene

func fire_projectile() -> void:
	var newProjectile : Node2D= projectile.instantiate()
	
	get_tree().current_scene.add_child(newProjectile)
	if (get_parent() is Node2D ):
		newProjectile.global_position = get_parent().global_position
