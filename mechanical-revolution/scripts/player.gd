class_name Player extends CharacterBody2D


const MAX_SPEED := 300.0
const ACCELERATION := 1500.0
const DECCELERATION := 1300.0
const AIR_ACCELERATION := 900.0
const JUMP_VELOCITY := -800.0
@export var Projectile : PackedScene
var playerState = "Running"
#@onready var weapon: Weapon = $Weapon
var weapon: Weapon:
	set(val):
		if (weapon):
			weapon.queue_free()
		weapon = val
		add_child(weapon)
@export var toolbar : Array[WeaponItem]
@export var myarr : Array[WeaponItem]
@export var weaponScns: Dictionary[String, PackedScene]
var droppable_scene : PackedScene = preload("uid://bsyfxb11phyub")
#@export var weaponkeybinds : Dictionary
var current_weapon := 0
var current_interactable : Interactable
@onready var interact_range: Area2D = $InteractRange

var is_just_interacted := false
signal tookDamage
var max_health := 100.0
var health := 100.0:
	set(val):
		health = val
		tookDamage.emit(val)

func _ready() -> void:
	if toolbar.size() > 0 and toolbar[0]:
		
		weapon = weaponScns[toolbar[0].WeaponName].instantiate()
		weapon.visible = true
	interact_range.area_entered.connect(_on_area_entered)
	interact_range.area_exited.connect(_on_area_exited)
	
		
func _on_area_entered(area: Node2D) -> void:
	if area is Interactable:
		current_interactable = area


func _on_area_exited(area: Node2D) -> void:
	if area == current_interactable:
		current_interactable = null
func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	#weapon.rotation = (get_local_mouse_position().normalized() * (-1 if weapon.flippedH else 1)).angle()
	#var shouldFlip = (
		#((not weapon.flippedH) and (get_local_mouse_position().x < 0.0))
		#or ((weapon.flippedH) and (get_local_mouse_position().x > 0.0))
	#)
	#if shouldFlip: 
		#weapon.flipH()
		#
	if current_interactable != null and Input.is_action_just_pressed("interact"):
		
		if current_interactable is WeaponPickup:
			var dropItem :Droppable= current_interactable.Interact()
			var replaced := false
			for i in range(toolbar.size()):
				if toolbar[i].WeaponName == "unarmed":
					toolbar[i] = WeaponItem.new().Init(dropItem)
					replaced = true
					change_weapon(i)
					break
			if not replaced:
				drop_weapon(current_weapon, toolbar[current_weapon])
				print("ran", current_weapon)
				toolbar[current_weapon] = WeaponItem.new().Init(dropItem)
				change_weapon(current_weapon)
			
	var desired_velocity : Vector2
	desired_velocity.x = direction * MAX_SPEED
	velocity += get_gravity() * delta
	if Input.is_key_pressed(KEY_1):
		change_weapon(0)
	elif Input.is_key_pressed(KEY_2):
		change_weapon(1)
	elif Input.is_key_pressed(KEY_3):
		change_weapon(2)
	elif Input.is_key_pressed(KEY_4):
		change_weapon(3)
	if Input.is_action_just_pressed("Shoot"):
		weapon.fire(get_local_mouse_position().normalized())
		take_damage(10.0)
	match playerState:
		"Running":
			if direction:
				velocity.x = move_toward(velocity.x, desired_velocity.x, ACCELERATION * delta)
			else:
				velocity.x = move_toward(velocity.x, 0, DECCELERATION * delta)
				# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				playerState = "Jump Up"
		"Jump Up":
			# Add the gravity.
			if velocity.y > 0:
				playerState = "Falling"
			velocity += get_gravity() * delta
			if direction:
				velocity.x = move_toward(velocity.x, desired_velocity.x, AIR_ACCELERATION * delta)
			else:
				velocity.x = move_toward(velocity.x, 0, AIR_ACCELERATION * delta)

		"Falling":
			if is_on_floor():
				playerState = "Running"
			velocity += get_gravity() * delta
			if direction:
				velocity.x = move_toward(velocity.x, desired_velocity.x, AIR_ACCELERATION * delta)
			else:
				velocity.x = move_toward(velocity.x, 0, AIR_ACCELERATION * delta)
	move_and_slide()
	
func knockback(force: Vector2) -> void:
	velocity += force

func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		death()

func heal(healing: float) -> void:
	health += healing
	if health > max_health:
		health = max_health

func change_weapon(index: int) -> void:
	if (toolbar.size() > index and toolbar[index]):
		weapon = weaponScns[toolbar[index].WeaponName].instantiate()
	current_weapon = index

func drop_weapon(index: int, weapon_item:WeaponItem) -> void:
	var dropped_item = droppable_scene.instantiate()
	dropped_item.Init(Droppable.new().Init(weapon_item))
	get_tree().root.add_child(dropped_item)
	toolbar[index] = null

func death() -> void:
	get_tree().reload_current_scene()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
