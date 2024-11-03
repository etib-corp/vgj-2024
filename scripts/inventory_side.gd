extends VBoxContainer

@onready var placeholder_farm = preload("res://scenes/placehodler_farm.tscn")
@onready var can_place = $"../CraftSide".can_place

func _do_nothing():
	print("toto")

func _add_farm():
	if (!available_items.has("Shovel")):
		return
	if (available_items["Shovel"].nbr == 0 || !can_place):
		return
	available_items["Shovel"].nbr -= 1
	var instance = placeholder_farm.instantiate()
	Global.player_ref.add_child(instance)

@export var available_items = {
	"Wood": { "nbr": 20, "callback" : _do_nothing},
	"Stone": { "nbr": 5, "callback" :_do_nothing
		},
	"Metal":  { "nbr": 20, "callback" : _do_nothing
		},
	"Farm": {"nbr" : -1, "callback": _add_farm},
	"Wheat": {"nbr": 0, "callback": _do_nothing}
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
		if (available_items[item].nbr == -1):
			child.text = item + ":" + "infinite"
		else:
			child.text = item + ":" + str(available_items[item].nbr)
		child.button_down.connect(available_items[item].callback)
		list.add_child(child)
