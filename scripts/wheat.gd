extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape3D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if "Player" in body.name:
		global.available_items["Wheat"]["nbr"] += 1
		visible = false
		_disable_collision()

func _enable_collision():
	$CollisionShape3D.disabled = false

func _disable_collision():
	$CollisionShape3D.disabled = true
