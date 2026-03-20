@abstract class_name Weapon extends Node2D
@export var attack : PackedScene
## This timer's wait_time serves as the cooldown for the weapon
@onready var timer: Timer = get_node("CDTimer")

		
var _can_fire := true
@abstract func fire(lookVector:Vector2) -> void
