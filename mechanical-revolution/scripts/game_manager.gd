extends Node2D
@onready var player: Player = $Player
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var toolbar: Toolbar = $CanvasLayer/Toolbar



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if player:
		toolbar.upd_all_tool_imgs(player.toolbar)
		player.tookDamage.connect(func (val) -> void:
			progress_bar.value = val
		)
		player.changedWeapon.connect(func (val) -> void:
			toolbar.change_slot(val)
		)
		player.updateToolbar.connect(func (idx, wpn) -> void:
			toolbar.upd_tool_imgs(idx, wpn)
		)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
