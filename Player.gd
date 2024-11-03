extends CharacterBody3D


const SPEED = 5.0
const RUN_SPEED = SPEED * 2
const JUMP_VELOCITY = 4.5
const mouse_sensitivity = 0.002

var double_jump = true

var deadScene = preload("res://DeathScreen.tscn")


@onready var aTree = $Knight/AnimationTree
@onready var animations = $Knight/AnimationPlayer
@onready var weapon_collision = $"Knight/Rig/Skeleton3D/2H_Sword/2H_Sword/HitBox"
@onready var hurtbox = $HurtBox

@onready var camera = $Knight/Rig/Skeleton3D/Knight_Head/Camera3D
@onready var inventory_list = $CraftPanel/MainContainer/InventorySide/List
@onready var inventory_content = $CraftPanel/MainContainer/InventorySide.available_items
@onready var audioSteamPlayer: AudioStreamPlayer3D = $AudioStreamPlayer3D

var is_audio_playing_walk = false
var is_audio_playing_run = false

func _ready() -> void:
	Global.player_ref = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if hurtbox.health <= 0:
		aTree.set("parameters/conditions/is_dead", true)
		return

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		aTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
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
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var input_dir := Input.get_vector("Move right", "Move left", "Move backward", "Move forward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction and not Input.is_action_pressed("Run"):
			if !is_audio_playing_walk:
				audioSteamPlayer.play()
				audioSteamPlayer.pitch_scale = 1
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			is_audio_playing_walk = true
			is_audio_playing_run = false
		elif direction and Input.is_action_pressed("Run"):
			if !is_audio_playing_run:
				audioSteamPlayer.play()
				audioSteamPlayer.pitch_scale = 2
			velocity.x = direction.x * RUN_SPEED
			velocity.z = direction.z * RUN_SPEED
			is_audio_playing_run = true
			is_audio_playing_walk = false
		else:
			is_audio_playing_run = false
			is_audio_playing_walk = false
			audioSteamPlayer.stop()
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		var aVel = Vector2(-velocity.x, velocity.z)

		aTree.set("parameters/StateMachine/BlendSpace2D/blend_position", aVel)
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

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))

func player_dead() -> void:
	queue_free()
	get_tree().change_scene_to_packed(deadScene)
	
