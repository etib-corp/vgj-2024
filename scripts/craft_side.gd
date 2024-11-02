extends VBoxContainer

@onready var houseplacing = preload('res://scenes/placehouse.tscn')
@export var can_place = true

func _do_nothing():
	print("toto")

func _add_placeholder():
	if (can_place):
		var instance = houseplacing.instantiate()
		Global.player_ref.add_child(instance)

@export var available_recipes = {
	"Axe": {
		"Wood": 3,
		"Stone": 3,
		"callback": _do_nothing
	},
	"Spoon": {
		"Wood": 1,
		"callback": _do_nothing
	},
	"Pickaxe": {
		"Wood": 2,
		"Stone": 2,
		"callback": _do_nothing
	},
	"Shovel": {
		"Wood": 2,
		"Stone": 1,
		"callback": _do_nothing
	},
	"Hammer": {
		"Wood": 2,
		"Stone": 2,
		"callback": _do_nothing
	},
	"Bowl": {
		"Wood": 1,
		"callback": _do_nothing
	},
	"Arrow": {
		"Wood": 1,
		"Stone": 1,
		"callback": _do_nothing
	},
	"Boat": {
		"Wood": 5,
		"callback": _do_nothing
	},
	"House": {
		"Wood": 20,
		"callback": _add_placeholder
	},
}

@onready var list = $List
@onready var search_bar = $SearchBar.text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
