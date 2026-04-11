class_name Droppable extends Resource

@export var WeaponName := "laser"
@export var ammo := 100
@export var durability := 100.0
@export var dropped_texture :Texture2D


func Init(obj:WeaponItem) -> Droppable:
	WeaponName = obj.WeaponName
	ammo = obj.ammo
	durability = obj.durability
	return self

func Init_manual(name:String, a:int, dur:float) -> Droppable:
	WeaponName = name
	ammo = a
	durability = dur
	return self
