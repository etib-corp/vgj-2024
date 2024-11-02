extends VBoxContainer

func _do_nothing():
	print("toto")

@export var available_items = {
	"Wood": { "nbr": 20, "callback" : _do_nothing},
	"Stone": { "nbr": 5, "callback" :_do_nothing
		},
	"Metal":  { "nbr": 20, "callback" : _do_nothing
		}
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
		child.text = item + ":" + str(available_items[item].nbr)
		child.button_down.connect(available_items[item].callback)
		list.add_child(child)
