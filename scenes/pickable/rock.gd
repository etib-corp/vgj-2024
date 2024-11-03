extends Node3D

@export var life = 8

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
		stone._enable_collision()
		is_alive = false

func _on_hurtbox_area_entered(area: Area3D) -> void:
	if life > 0 and area.visible:
		life -= 1
