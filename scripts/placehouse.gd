extends Node3D

@export var player = null
@onready var inhouseScene = preload('res://scenes/in_house.tscn')
@onready var house_scene = preload('res://scenes/house.tscn')
var house_preview: Node3D = null

func _ready() -> void:
	house_preview = house_scene.instantiate()
	house_preview._disable_collision()
	# house_preview.modulate.a = 0.5
	add_child(house_preview)
	house_preview.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_house_preview_position()

func update_house_preview_position():
	var raycast :RayCast3D = Global.player_ref.get_node("Knight/Rig/Skeleton3D/Knight_Head/Camera3D/RayCast3D")
	if (raycast.is_colliding()):
		var collision_point = raycast.get_collision_point()
		house_preview.global_position = collision_point
		house_preview.visible = true  # Show the preview when colliding
	else:
		house_preview.visible = false
	if (Input.is_action_just_pressed("interaction")):
		_add_House_in_World()
		

func set_player(p):
	player = p

func _add_House_in_World():
	var new_house: Node3D = house_scene.instantiate()
	new_house.global_position = house_preview.global_position
	new_house.global_transform = house_preview.global_transform
	var new_inhouse: Node3D = inhouseScene.instantiate()
	Global.player_ref.get_parent().get_node("NavigationRegion3D").add_child(new_house)
	Global.player_ref.get_parent().get_node("NavigationRegion3D").add_child(new_inhouse)
	
	new_inhouse.global_position = new_house.global_position
	new_inhouse.global_position.y -= 100
	var back = new_house.global_position
	back.y += 10
	back.x += 10
	new_inhouse.set_return(back)
	new_house.set_pos_inhouse(new_inhouse.global_position)

	queue_free()
