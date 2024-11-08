extends CharacterBody3D

const SPEED = 5.0
var accel = 10
var GRAVITY = -90
const ATTACK_RANGE = 2.5

var player:Node3D = null

@onready var nav: NavigationAgent3D = $"NavigationAgent3D"
@onready var animation : AnimationPlayer = $"AnimationPlayer"
@onready var wander = $"Wander"
@onready var hurtbox = $HurtBox

enum {
	IDLE,
	WANDER,
	CHASE,
	DIE
}

var stat = IDLE
var direction = Vector3.ZERO

func _ready() -> void:
	randomize()
	stat = pick_random_state([IDLE, WANDER])
	set_physics_process(false)
	call_deferred("enemies_setup")

func enemies_setup():
	await get_tree().physics_frame
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	if hurtbox.health <= 0:
		stat = DIE
	match stat:
		IDLE:
			animation.play("Idle")
			direction = Vector3.ZERO
			velocity = Vector3.ZERO
			if wander.get_time_left() == 0:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(randi_range(5, 10))
		WANDER:
			animation.play("Walking_B")
			direction = global_transform.origin.direction_to(wander.target_position)
			velocity = velocity.move_toward(direction * SPEED, accel * delta)
			look_at(wander.target_position, Vector3.UP)
			
			if global_transform.origin.distance_to(wander.target_position) <= 5:
				stat = pick_random_state([IDLE, WANDER])
				wander.start_timer_wander(randi_range(5, 10))
		CHASE:
			if _target_in_range():
				animation.play("1H_Melee_Attack_Slice_Diagonal")
				velocity = Vector3.ZERO
			else:
				animation.play("Running_B")
				var direction = global_transform.origin.direction_to(player.get_global_transform().origin)
				velocity = velocity.move_toward(direction * SPEED, accel * delta)
				look_at(Vector3(player.global_position), Vector3.UP)
		DIE:
			animation.play("Death_A")
			
	velocity.y += GRAVITY * delta
	move_and_slide()

func _target_in_range():
	return global_position.distance_to(player.global_position) <= ATTACK_RANGE

func pick_random_state(list_state):
	list_state.shuffle()
	return list_state.pop_front()


func _on_detection_player_body_entered(body: Node3D) -> void:
	stat = CHASE
	player = body

func _on_detection_player_body_exited(body: Node3D) -> void:
	stat = pick_random_state([IDLE, WANDER])
	player = null

func destroy_player() -> void:
	queue_free()
