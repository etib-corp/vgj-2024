extends Node3D

@export var pos_to_return: Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_return(pos):
	pos_to_return = pos


func _on_area_3d_body_entered(body: Node3D) -> void:
	Global.player_ref.global_position = pos_to_return
