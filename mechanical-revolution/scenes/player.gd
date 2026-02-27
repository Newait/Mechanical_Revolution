extends CharacterBody2D


const MAX_SPEED = 300.0
const JUMP_VELOCITY = -400.0
var playerState = "Running"

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	var desired_velocity : Vector2
	match playerState:
		"Running":
			if direction != 0:
				desired_velocity = direction * MAX_SPEED
				velocity.x = direction * SPEED 
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				# Handle jump.
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				playerState = "Falling"
		"Falling":
			if direction:
				velocity.x = direction * SPEED * 0.5
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				# Handle jump.
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	move_and_slide()
