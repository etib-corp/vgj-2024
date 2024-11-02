extends Node3D


@export var pos_inhouse: Vector3 = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _disable_collision():
	$building_home_B_yellow2/CollisionShape3D.disabled = true
	$building_home_B_yellow2/CollisionShape3D2.disabled = true
	$building_home_B_yellow2/CollisionShape3D3.disabled = true
	$building_home_B_yellow2/CollisionShape3D4.disabled = true
	$building_home_B_yellow2/CollisionShape3D5.disabled = true

func set_pos_inhouse(pos):
	pos_inhouse = pos

func _on_rigid_body_3d_body_entered(body: Node3D) -> void:
	Global.player_ref.global_position = pos_inhouse
