extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var aTree = $Knight/AnimationTree
@onready var animations = $Knight/AnimationPlayer
@onready var weapon_collision = $"Knight/Rig/Skeleton3D/2H_Sword/RigidBody3D"

var weapon_state = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if aTree.get("parameters/playback").get_current_node() == "Attack":
		weapon_collision.visible = true
	else:
		weapon_collision.visible = false
	if Input.is_action_just_pressed("left_mouse_button"):
		aTree.set("parameters/conditions/is_attacking", true)
		aTree.set("parameters/conditions/is_moving", false)
		aTree.set("parameters/conditions/is_idling", false)
		return
	else:
		aTree.set("parameters/conditions/is_attacking", false)


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	var aVel = Vector2(-velocity.x, velocity.z)
	
	if aVel.x == 0 and aVel.y == 0:
		aTree.set("parameters/conditions/is_moving", false)
		aTree.set("parameters/conditions/is_idling", true)
	else:
		aTree.set("parameters/conditions/is_moving", true)
		aTree.set("parameters/conditions/is_idling", false)
		
	
	aTree.set("parameters/blend_position/blend_position", aVel)
	
	move_and_slide()
