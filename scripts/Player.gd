extends CharacterBody3D

@export var SPECS = {
	"SPEED": 5.0,
	"JUMP_VELOCITY": 4.5,
	"LIFE": 4,
	"PERFORMANCE": 100
}

var SPEED = SPECS["SPEED"]
var RUN_SPEED = SPEED * 2
var JUMP_VELOCITY = SPECS["JUMP_VELOCITY"]
var mouse_sensitivity = 0.002
var life = SPECS["LIFE"]
var performance = SPECS["PERFORMANCE"]

var double_jump = true

@onready var aTree = $Knight/AnimationTree
@onready var camera = $Knight/Rig/Skeleton3D/Knight_Head/Camera3D

@onready var inventory_list = $CraftPanel/MainContainer/InventorySide/List
@onready var inventory_content = $CraftPanel/MainContainer/InventorySide.available_items

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		aTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var input_dir := Input.get_vector("Move right", "Move left", "Move backward", "Move forward")
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
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
