extends Control

@onready var inventory_list = $MainContainer/InventorySide/List
@onready var inventory_content = $MainContainer/InventorySide.available_items

@onready var craft_items = $MainContainer/CraftSide.available_recipes
@onready var craft_list = $MainContainer/CraftSide/List
@onready var search_bar = $MainContainer/CraftSide/SearchBar.text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in craft_list.get_children():
		craft_list.remove_child(child)
	var field: String = search_bar

	for recipe: String in craft_items:
		if (recipe.capitalize().contains(field.capitalize()) or field == ""):
			var child = Button.new()
			child.text = recipe
			child.pressed.connect(on_button_pressed.bind(craft_items[recipe], recipe))
			craft_list.add_child(child)

func can_craft(ressources: Dictionary, new_item: String) -> bool:
	for ressource: String in ressources:
		if (inventory_content[ressource] < ressources[ressource]):
			return false
	return true

func on_button_pressed(ressources: Dictionary, new_item: String):
	if (can_craft(ressources, new_item)):
		for ressource: String in ressources:
			inventory_content[ressource] -= ressources[ressource]
		if (inventory_content.has(new_item)):
			inventory_content[new_item] += 1
		else:
			inventory_content[new_item] = 1
	else:
		print("Not enough ressources to craft " + new_item)
