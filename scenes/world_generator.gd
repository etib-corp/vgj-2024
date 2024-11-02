extends Node

var noise

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise = FastNoiseLite.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_cube(position, color):
	var box_size = Vector3(1,1,1)
	
	var static_body = StaticBody3D.new()
	static_body.position = position
	
	var collision_shape_3d = CollisionShape3D.new()
	collision_shape_3d.shape = BoxShape3D.new()
	collision_shape_3d.shape.size = box_size
	
	var mesh = MeshInstance3D.new()
	
	var boxmesh = BoxMesh.new()
	boxmesh.size = box_size
	
	var material = StandardMaterial3D.new()
	material.albedo_color = color
	
	boxmesh.material = material
	
	mesh.set_mesh(boxmesh)	
	static_body.add_child(mesh)
	static_body.add_child(collision_shape_3d)
	
	add_child(static_body)
	

func get_color_from_noise(noise_value):
	if noise_value <= -.4:
		return Color(1,0,0,1)
	elif noise_value <= -.2:
		return Color(0,1,0,1)
	elif noise_value <= 0:
		return Color(0,0,1,1)
	elif noise_value <= .2:
		return Color(.5,.5,.5,1)
	elif noise_value > .2:
		return Color(.3,.8,.5,1)
