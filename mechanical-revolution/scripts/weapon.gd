#@tool
#Don't worry about this, attempt to make warnings neat
@abstract class_name Weapon extends Node2D
@export var attack : PackedScene
## This timer's wait_time serves as the cooldown for the weapon
@onready var timer: Timer = get_node("CDTimer")
#func _init() -> void:
	#update_configuration_warnings()
#func _get_configuration_warnings() -> PackedStringArray:
	#var warning : Array[String] = []
	#if timer == null:
		#warning.append("You need a timer named 'CDTimer' for weapons.")
	#return warning
var _can_fire := true
@abstract func fire(lookVector:Vector2) -> void
