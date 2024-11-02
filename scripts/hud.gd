extends Control

@export var life = 4
@export var performance = 0

@onready var performance_label = $MainContainer/Header/Dependency/Performance
@onready var life_node = $MainContainer/Header/Life

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var count = life_node.get_child_count()
	
	if performance > 100:
		performance = 100
	if performance < 0:
		performance = 0
		
	performance_label.text = str(performance) + "%"
	
	var min_color = Color(1, 0, 0)  # Red
	var max_color = Color(0, 1, 0)  # Green
	var performance_ratio = performance / 100.0
	var interpolated_color = min_color.lerp(max_color, performance_ratio)
	performance_label.add_theme_color_override("font_color", interpolated_color)

	if count > life and life >= 0:
		life_node.remove_child(life_node.get_children().pop_back())
	elif count < life and life < 5:
		var last_life = life_node.get_children().pop_back()
		var new_life = last_life.duplicate()
		life_node.add_child(new_life)
		
	if Input.is_action_just_pressed("left_mouse_button"):
		performance -= 1
	if Input.is_action_just_pressed("ui_accept"):
		performance += 1
