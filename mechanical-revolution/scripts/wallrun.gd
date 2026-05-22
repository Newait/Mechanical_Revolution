
extends Area2D
@onready var color_rect: ColorRect = %ColorRect
@onready var color_rect_2: ColorRect = %ColorRect2

@export var flip := true:
	set(val):
		if not color_rect or not color_rect_2:
			return
		#(color_rect.material as ShaderMaterial).set_shader_parameter("right_to_left",val)
		#(color_rect_2.material as ShaderMaterial).set_shader_parameter("right_to_left",not val)
		if val:
			(color_rect.material as ShaderMaterial).set_shader_parameter("desired_angle",45.0)
			(color_rect_2.material as ShaderMaterial).set_shader_parameter("desired_angle",135.0)
		else:
			(color_rect.material as ShaderMaterial).set_shader_parameter("desired_angle",135.0)
			(color_rect_2.material as ShaderMaterial).set_shader_parameter("desired_angle",45.0)
		flip = val
		
