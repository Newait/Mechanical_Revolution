extends Node2D
@onready var player: Player = $Player
@onready var progress_bar: ProgressBar = %ProgressBar



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		player.tookDamage.connect(func (val) -> void:
			progress_bar.value = val
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
