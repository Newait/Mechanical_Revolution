class_name Toolbar extends Panel

@export var current_equip := 0
@onready var selected: Panel = %Selected
@onready var items: HBoxContainer = %Items

var weapon_textures: Dictionary[String, Texture2D] = {
	"laser": preload("uid://bn21k2hrg4ffq"),
	"pistol": preload("uid://d0llkc87ed6h7"),
	
}

const TWEEN_TIME := 0.2
var main_tween : Tween

var all_tools : Array[Node]
var all_tool_img : Array[Node]
var init_x_offset : float

func _ready() -> void:
	all_tools = items.get_children()
	for ctrl_item:Node in items.get_children(true):
		if ctrl_item is Button:
			all_tool_img.append(ctrl_item.get_children()[0])
	get_tree().root.size_changed.connect(_on_viewport_resize)
	await get_tree().process_frame
	init_x_offset = (all_tools[0] as Button).size.x/2

func _on_viewport_resize() -> void:
	await get_tree().process_frame
	init_x_offset = (all_tools[0] as Button).size.x/2
	change_slot(current_equip)
func upd_all_tool_imgs(toolbar: Array[WeaponItem]) -> void:
	for i in range(len(all_tool_img)):
		print(i, toolbar[i].WeaponName)
		upd_tool_imgs(i, toolbar[i].WeaponName)

func upd_tool_imgs(index, weapon_name) -> void:
	if weapon_name == "unarmed":
		return
	(all_tool_img[index] as TextureRect).texture = weapon_textures[weapon_name]

func change_slot(new_slot:int) -> void:
	current_equip = new_slot
	if main_tween:
		main_tween.stop()
	main_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	main_tween.tween_property(selected, "position:x", all_tools[new_slot].position.x + init_x_offset - selected.size.x/2, TWEEN_TIME)
