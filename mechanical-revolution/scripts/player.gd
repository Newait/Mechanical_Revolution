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
@onready var inventory: Node2D = $Inventory
@export var toolbar : Array[WeaponItem]
@export var weaponScns: Dictionary[String, PackedScene]
var droppable_scene : PackedScene = preload("uid://bsyfxb11phyub")
#@export var weaponkeybinds : Dictionary
var current_weapon := 0

signal tookDamage
var max_health := 100.0
var health := 100.0:
	set(val):
		health = val
		tookDamage.emit(val)

func _ready() -> void:
	if len(toolbar) > 0 and toolbar[0]:
		weapon = weaponScns[toolbar[0].WeaponName].instantiate()
		weapon.visible = true
		
		
func _on_area_entered(area: Node2D) -> void:
	if area is Interactable:
		if area is WeaponPickup:
			var dropped := (area as WeaponPickup).Interact()
			if len(toolbar) < 4:
				toolbar.append(WeaponItem.new(dropped))
			else:
				drop_weapon(current_weapon, toolbar[current_weapon])
				toolbar[current_weapon] = WeaponItem.new(dropped)
		
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
	if (len(toolbar) > index and toolbar[index]):
		weapon = weaponScns[toolbar[index].WeaponName].instantiate()

func drop_weapon(index: int, weapon_item:WeaponItem) -> void:
	var dropped_item = droppable_scene.instantiate()
	dropped_item.Init(Droppable.new().Init(weapon_item))
	get_tree().root.add_child(dropped_item)
	toolbar[index] = null

func death() -> void:
	get_tree().reload_current_scene()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
