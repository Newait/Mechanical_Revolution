
extends Node2D

@onready var occluder_left: LightOccluder2D = %OccluderLeft
@onready var occluder_right: LightOccluder2D = %OccluderRight
@export var speed := 5
var is_ready := false
@export var progress := 0.0 :
	set(val): 
		if not is_ready:
			return
		if val <= 0.5: 
			var ScaleFactor := (0.5 - val/0.5) * 2
			var ScaleVector := Vector2(ScaleFactor,ScaleFactor)
			occluder_left.scale = ScaleVector
			#occluder_right.scale = ScaleVector
		else :
			var ScaleFactor := (0.5 - (val -0.5)/0.5) * -2
			var ScaleVector := Vector2(ScaleFactor,ScaleFactor)
			occluder_left.scale = ScaleVector
			occluder_right.scale = ScaleVector
		progress = val

func _ready() -> void:
	is_ready = true
	var tween := create_tween().set_loops()
	tween.tween_property(self,"progress",1.0,speed)
	tween.tween_property(self,"progress", 0.0, speed)
