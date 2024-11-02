extends Node3D

@onready var spawns = $Node3D
#change with the navigation region
@onready var navigation_region = 0

var enemies = load("res://enemy.tscn")
var instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _get_random_child(parent_node):
	print("passed")
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)
	

func _on_spawn_timer_timeout() -> void:
	var spawn_point = _get_random_child(spawns).global_position
	instance = enemies.instantiate()
	instance.set("position", spawn_point)
	add_child(instance)
	
