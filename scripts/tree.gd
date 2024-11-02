extends Node3D

@export var life = 5

@onready var dead_state = preload("res://assets/Map Models/KayKit_Medieval_Hexagon_Pack_1.0_FREE/Assets/gltf/decoration/nature/tree_single_B_cut.gltf")
@onready var hurtbox = $Hurtbox
@onready var area = $Area

var is_alive = true
var player_in = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if life <= 0 && is_alive == true:
		remove_child($StaticBody3D)
		add_child(dead_state.instantiate())
		is_alive = false

func _on_hurtbox_body_entered(body: Node3D) -> void:
	if life > 0 and body.visible:
		life -= 1

func _on_area_body_entered(body: Node3D) -> void:
	player_in = true

func _on_area_body_exited(body: Node3D) -> void:
	player_in = false
