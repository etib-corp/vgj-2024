extends CharacterBody3D

@onready var nav = $"NavigationAgent3D"
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var player_path: NodePath

var player = null

func _ready() -> void:
	player = get_node(player_path)

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	nav.target_position = player.global_transform.origin
	var next_nav_point = nav.get_next_path_position()
	velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)

	move_and_slide()
