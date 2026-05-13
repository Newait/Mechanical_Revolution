class_name WeaponPickup extends Interactable

var attachedDroppable := Droppable.new()
var within_range := false
var readied := false
@onready var interact_text: Label = %InteractText
@onready var drop_sprite: Sprite2D = %DropSprite
#static var weapon_textures: Dictionary[String, Texture2D] = {
	#"laser": preload("uid://bn21k2hrg4ffq"),
	#"pistol": preload("uid://d0llkc87ed6h7"),
	#"rocket": preload("uid://dy3a2y4r1bhi2")
#}

func _ready() -> void:
	readied = true
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)


func Init(dropResource:Droppable):
	attachedDroppable = dropResource
	if not readied:
		get_node("%DropSprite").texture = attachedDroppable.dropped_texture
		get_node("%InteractText").text = attachedDroppable.WeaponName
	else:
		drop_sprite.texture = attachedDroppable.dropped_texture
		interact_text.text = attachedDroppable.WeaponName
	pass

func _physics_process(_delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("interact") and within_range:
		#pick_up()
	

func on_body_entered(_body:Node2D) -> void:
	within_range = true
	interact_text.visible = true

func on_body_exited(_body: Node2D) -> void:
	within_range = false
	interact_text.visible = false

func Interact() -> Droppable:
	queue_free()
	return attachedDroppable
