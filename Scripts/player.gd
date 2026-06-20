extends CharacterBody3D

const SPEED = 1.1

# This pulls the exact gravity number from your Project Settings (usually 9.8)
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# 1. Apply gravity if the player is in the air
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# ... your existing walking input code goes here ...
	
	# 2. Tell the engine to calculate the movement and floor snapping
	move_and_slide()
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.z += 1
	if Input.is_action_pressed("ui_up"):
		input_dir.z -= 1

	input_dir = input_dir.normalized()

	velocity.x = input_dir.x * SPEED
	velocity.z = input_dir.z * SPEED

	move_and_slide()
