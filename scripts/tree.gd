extends Node3D

@export var life = 5

@onready var dead_state = preload("res://assets/Map Models/KayKit_Medieval_Hexagon_Pack_1.0_FREE/Assets/gltf/decoration/nature/tree_single_B_cut.gltf")

@onready var hurtbox = $Hurtbox
@onready var area = $Area
@onready var wood = $Wood

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
		wood.visible = true
		is_alive = false

func _on_area_body_entered(body: Node3D) -> void:
	player_in = true

func _on_area_body_exited(body: Node3D) -> void:
	player_in = false

func _on_hurtbox_area_entered(area: Area3D) -> void:
	if life > 0 and area.visible:
		life -= 1
