extends Node3D

@onready var time: Timer  = $"Timer"

@onready var start_position = global_transform

@onready var target_position = global_transform
 
@export var wander_range = 10

func _ready() -> void:
	updata_taget_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updata_taget_position():
	var target_vector = Vector3(randf_range(-wander_range, wander_range), 0, randf_range(-wander_range, wander_range))
	target_position = start_position.origin + target_vector
	
func get_time_left():
	return time.time_left

func start_timer_wander(duration):
	time.start(duration)

func _on_timer_timeout() -> void:
	updata_taget_position()
