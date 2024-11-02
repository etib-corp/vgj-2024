extends Node3D

@onready var citizen = preload("res://assets/Character/KayKit_Adventurers_1.0_FREE/Characters/fbx/Rogue.fbx").instantiate()
var nbr = 0

func _ready() -> void:
	randomize()
	var pos = Vector2
	nbr = randi() % 20
	for i in range(0, nbr):
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
