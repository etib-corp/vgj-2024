extends Control

@export var life = 20

@onready var life_node = $MainContainer/Header/Life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var count = life_node.get_child_count()

	if count > Global.player_ref.hurtbox.health / 5 and Global.player_ref.hurtbox.health >= 0:
		life_node.remove_child(life_node.get_children().pop_back())
	elif count < Global.player_ref.hurtbox.health / 5 and Global.player_ref.hurtbox.health <= 20:
		var last_life = life_node.get_children().pop_back()
		var new_life = last_life.duplicate()
		life_node.add_child(new_life)
