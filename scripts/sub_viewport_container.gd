extends SubViewportContainer

@onready var camera = $SubViewport/Camera3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	camera.global_position.x = Global.player_ref.global_position.x
	camera.global_position.z = Global.player_ref.global_position.z
