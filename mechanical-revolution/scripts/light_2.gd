
extends Node2D

#@onready var occluder_left: LightOccluder2D = %OccluderLeft
#@onready var occluder_right: LightOccluder2D = %OccluderRight
@onready var light_connectors: Node2D = %LightConnectors
@export var speed := 5
var is_ready := false
@export var progress := 0.0 :
	set(val): 
		if not is_ready:
			return
		light_connectors.rotation = 2 *PI * progress
		progress = val

func _ready() -> void:
	is_ready = true
	var tween := create_tween()
	
	tween.tween_property(self,"progress",1.0,speed)
	tween.set_loops()
	tween.loop_finished.connect(func (_loop_count:int) -> void:
		progress = 0.0
	)
