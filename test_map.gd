extends Node3D

@export var NSPAWN = 2
@export var maxX = 10
@export var maxZ = 10
@onready var spawns = [Vector2(randi() % maxX, randi() % maxZ) * NSPAWN]
#change with the navigation region
@onready var navigation_region = 0

var enemy = preload("res://enemy.tscn")
var instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var spawn_point = spawns.pick_random()
	instance = enemy.instantiate()
	instance.set("position", spawn_point)
	print("1 enemy spawned")
	add_child(instance)
	
