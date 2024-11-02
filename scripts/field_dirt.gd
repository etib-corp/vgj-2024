extends Node3D

@export var growing_time = 10
@export var growing_state = -1

@onready var child_wheat = $Wheat/Child
@onready var adult_wheat = $Wheat/Adult

var elapsed_time = 0

var player_in = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	
	if (elapsed_time >= 1):
		elapsed_time = 0
		if growing_state >= 0:
			growing_state += 1
	if growing_state == -1:
		child_wheat.visible = false
		adult_wheat.visible = false
	if growing_state >= 0:
		child_wheat.visible = true
	if growing_state >= growing_time:
		adult_wheat.visible = true

func _on_hurtbox_body_entered(body: Node3D) -> void:
	if body.visible == false:
		return
	if growing_state == -1:
		growing_state = 0
	if growing_state >= growing_time:
		growing_state = -1

func _on_area_body_entered(body: Node3D) -> void:
	player_in = true

func _on_area_body_exited(body: Node3D) -> void:
	player_in = false
