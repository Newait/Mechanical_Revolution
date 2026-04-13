class_name Droppable extends Resource

@export var WeaponName := "laser"
@export var ammo := 100
@export var durability := 100.0
@export var dropped_texture :Texture2D

static var weapon_textures: Dictionary[String, Texture2D] = {
	"laser": preload("uid://bn21k2hrg4ffq"),
	"pistol": preload("uid://d0llkc87ed6h7"),
	"rocket": preload("uid://dy3a2y4r1bhi2")
}

func Init(obj:WeaponItem) -> Droppable:
	WeaponName = obj.WeaponName
	ammo = obj.ammo
	durability = obj.durability
	dropped_texture = weapon_textures[obj.WeaponName]
	return self

func Init_manual(name:String, a:int, dur:float) -> Droppable:
	WeaponName = name
	ammo = a
	durability = dur
	dropped_texture = weapon_textures[name]
	return self
