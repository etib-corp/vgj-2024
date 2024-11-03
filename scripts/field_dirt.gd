extends Node3D

@export var growing_time = 10
@export var growing_state = -1

@onready var child_wheat = $Wheat/Child
@onready var adult_wheat = $Wheat/Adult

@onready var pickable = $PickableWheat

var elapsed_time = 0

var player_in = false
var can_recolt = false

func _disable_collision():
	$StaticBody3D/CollisionShape3D.disabled = true

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
	if growing_state == -1 and adult_wheat.visible == false and can_recolt == true:
		pickable.visible = true
		pickable._enable_collision()
		can_recolt = false
	if growing_state >= 0:
		child_wheat.visible = true
	if growing_state >= growing_time:
		adult_wheat.visible = true
		can_recolt = true

func _on_area_body_entered(body: Node3D) -> void:
	player_in = true

func _on_area_body_exited(body: Node3D) -> void:
	player_in = false

func _on_hurtbox_area_entered(area: Area3D) -> void:
	if area.visible == false:
		return
	if growing_state == -1:
		growing_state = 0
	if growing_state >= growing_time:
		growing_state = -1
