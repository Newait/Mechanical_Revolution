class_name WeaponItem extends Resource

@export var WeaponName := "unarmed"
@export var ammo := 100
@export var durability := 100.0
@export var inventory_texture :Texture2D

func Init(obj:Droppable) -> WeaponItem:
	WeaponName = obj.WeaponName
	ammo = obj.ammo
	durability = obj.durability
	return self

func init_manual(name:String, a:int, dur:float) -> void:
	WeaponName = name
	ammo = a
	durability = dur
