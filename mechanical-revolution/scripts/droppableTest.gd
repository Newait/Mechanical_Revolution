class_name WeaponPickup extends Interactable

var attachedDroppable := Droppable.new()
var within_range := false
@onready var interact_text: Label = %InteractText

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func Init(dropResource:Droppable):
	attachedDroppable = dropResource
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
	print("thing")
	#call_deferred("queue_free")
	return attachedDroppable
