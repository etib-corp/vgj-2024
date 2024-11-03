extends VBoxContainer

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
		child.text = item + ":" + str(global.available_items[item].nbr)
		child.button_down.connect(global.available_items[item].callback)
		list.add_child(child)
