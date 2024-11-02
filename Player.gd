extends CharacterBody3D


const SPEED = 5.0
const RUN_SPEED = SPEED * 2
const JUMP_VELOCITY = 4.5
const mouse_sensitivity = 0.002

var double_jump = true

@onready var aTree = $Knight/AnimationTree
@onready var camera = $Knight/Rig/Skeleton3D/Knight_Head/Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		aTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and not Input.is_action_pressed("Run"):
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif direction and Input.is_action_pressed("Run"):
		velocity.x = direction.x * RUN_SPEED
		velocity.z = direction.z * RUN_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	var aVel = Vector2(-velocity.x, velocity.z)
		
	aTree.set("parameters/StateMachine/BlendSpace2D/blend_position", aVel)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
