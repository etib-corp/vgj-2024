extends Node3D

@onready var fiels_dirt = preload("res://World/interactables/field_dirt.tscn")
var fiels_preview: Node3D = null
@onready var raycast :RayCast3D = Global.player_ref.get_node("Knight/Rig/Skeleton3D/Knight_Head/Camera3D/RayCast3D")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fiels_preview = fiels_dirt.instantiate()
	add_child(fiels_preview)
	fiels_preview.visible = false
	fiels_preview._disable_collision()

func _process(delta: float) -> void:
	update_house_preview_position()

func update_house_preview_position():
	if (raycast.is_colliding()):
		var collision_point = raycast.get_collision_point()
		fiels_preview.global_position = collision_point
		fiels_preview.visible = true 
	else:
		fiels_preview.visible = false
	if (Input.is_action_just_pressed("interaction")):
		_add_fiels_in_World()
		
func _add_fiels_in_World():
	var new_fiels = fiels_dirt.instantiate()
	Global.player_ref.get_parent().get_node("NavigationRegion3D").add_child(new_fiels)
	new_fiels.global_transform = fiels_preview.global_transform
	queue_free()
