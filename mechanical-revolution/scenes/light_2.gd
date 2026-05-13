extends Node2D

@onready var occluder_left: LightOccluder2D = %OccluderLeft
@onready var occluder_right: LightOccluder2D = %OccluderRight
@export var speed := 0.5
@export_range(0.0,1.0,0.01) var progress := 0.0 :
	set(val):
		if progress <= 0.5: 
			(0.5 - progress/0.5) * 2
		else :
			((progress-0.5)/0.5)-1.0

func _process(delta: float) -> void:
	
