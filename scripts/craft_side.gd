extends VBoxContainer

func _do_nothing():
	print("toto")


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
	}
}

@onready var list = $List
@onready var search_bar = $SearchBar.text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
