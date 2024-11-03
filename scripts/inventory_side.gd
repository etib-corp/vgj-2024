extends VBoxContainer

@onready var placeholder_farm = preload("res://scenes/placehodler_farm.tscn")

func _do_nothing():
	print("toto")

@onready var list = $List

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in list.get_children():
		list.remove_child(child)
	for item: String in global.available_items:
		var child = Button.new()
		if (global.available_items[item].nbr == -1):
			child.text = item + ":" + "infinite"
		else:
			child.text = item + ":" + str(global.available_items[item].nbr)
		child.button_down.connect(global.available_items[item].callback)
		list.add_child(child)
