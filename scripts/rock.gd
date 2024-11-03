extends Node3D

@export var life = 6

@onready var hurtbox = $Hurtbox
@onready var stone = $Stone

var is_alive = true
var player_in = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if life <= 0 && is_alive == true:
		remove_child($StaticBody3D)
		stone.visible = true
		is_alive = false
