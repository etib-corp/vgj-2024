extends Node

@export var GENERATION_BOUND_DISTANCE = 8
@export var VERTICAL_AMPLITUDE = 0

@export var noise : FastNoiseLite
var generated_chunks

@onready var city = preload("res://World/blue_city.tscn")
@onready var village = preload("res://World/blue_village.tscn")
@onready var plain = preload("res://World/plain.tscn")

func _ready():
	generated_chunks={}
	generate_new_chunks_from_position(Vector3(0, 0, 0))

func generate_new_chunks_from_position(position):
	for x in range(GENERATION_BOUND_DISTANCE*2):
		x += (position.x - GENERATION_BOUND_DISTANCE)
		for z in range(GENERATION_BOUND_DISTANCE*2):
			z += (position.z - GENERATION_BOUND_DISTANCE)
			generate_chunk_if_new(x,z)

func generate_chunk_if_new(x,z):
	if !has_chunk_been_generated(x,z):
		var generated_noise = noise.get_noise_2d(x + randi() % 2,z + randi() % 2)
		
		create_chunk(Vector3(x * 30, generated_noise * VERTICAL_AMPLITUDE * 2, z * 30), get_model_from_noise(generated_noise))
		register_chunk_generation_at_coordinate(x,z)

func has_chunk_been_generated(x,z):
	if x in generated_chunks and z in generated_chunks[x] and generated_chunks[x][z] == true:
		return true
	else:
		return false
			
func register_chunk_generation_at_coordinate(x,z):
	if x in generated_chunks:
		generated_chunks[x][z] = true
	else:
		generated_chunks[x] = {z: true}
			

func _process(delta):
	$HUD.life = $Player/HurtBox.health
	pass
	
func create_chunk(position, model: PackedScene):
	var scene = model.instantiate()
	scene.global_position = position
	$NavigationRegion3D.add_child(scene)

func get_model_from_noise(noise_value):
	if noise_value < 0.01 and noise_value > -0.01:
		return city
	elif noise_value < 0.05 and noise_value > -0.05 :
		return village
	else:
		return plain
