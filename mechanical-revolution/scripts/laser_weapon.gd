class_name LaserWeapon extends Weapon
@export var laser : PackedScene


func fire(lookVector:Vector2) -> void:
	add_child(laser.instantiate())
