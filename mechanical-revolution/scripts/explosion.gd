class_name Explosion extends Area2D

@export var final_radius := 100.0
@export var expand_time := 0.8
@export var max_knockback := 3000.0
@export var max_damage := 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	
	pass # Replace with function body.

func Init(final_rad, expand_timing, max_kb, max_dmg) -> void:
	final_radius = final_rad
	expand_time = expand_timing
	max_knockback = max_kb
	max_damage = max_dmg
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
