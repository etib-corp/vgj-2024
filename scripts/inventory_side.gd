extends VBoxContainer

@export var available_items = {
	"Wood": 20,
	"Stone": 5,
	"Metal": 2
}

@onready var list = $List

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in list.get_children():
		list.remove_child(child)
	for item: String in available_items:
		var child = Button.new()

		child.text = item + ":" + str(available_items[item])
		list.add_child(child)
