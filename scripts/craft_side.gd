extends VBoxContainer

@export var available_recipes = {
	"Axe": {
		"Wood": 3,
		"Stone": 3
	},
	"Spoon": {
		"Wood": 1
	},
	"Pickaxe": {
		"Wood": 2,
		"Stone": 2
	},
	"Shovel": {
		"Wood": 2,
		"Stone": 1
	},
	"Hammer": {
		"Wood": 2,
		"Stone": 2
	},
	"Bowl": {
		"Wood": 1
	},
	"Arrow": {
		"Wood": 1,
		"Stone": 1
	},
	"Boat": {
		"Wood": 5
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
