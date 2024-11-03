extends Node

func _do_nothing():
	print("toto")
	
var can_place = true

@onready var placeholder_farm = preload("res://scenes/placehodler_farm.tscn")

func _give_player_life(number: int):
	if Global.player_ref.hurtbox.health < 20:
		print("bread consuming")
		if Global.player_ref.hurtbox.health + number > 20:
			print("bread full")
			Global.player_ref.hurtbox.health = 20
		else:
			print("bread partial")
			Global.player_ref.hurtbox.health += number

func _consume_bread():
	if Global.player_ref.inventory_content["Bread"]["nbr"] > 0:
		_give_player_life(5)
		Global.player_ref.inventory_content["Bread"]["nbr"] -= 1

func _add_farm():
	if (!available_items.has("Shovel")):
		return
	if (available_items["Shovel"].nbr == 0 || !can_place):
		return
	available_items["Shovel"].nbr -= 1
	var instance = placeholder_farm.instantiate()
	Global.player_ref.add_child(instance)

var available_items = {
	"Wood": { "nbr": 0, "callback" : _do_nothing},
	"Stone": { "nbr": 0, "callback" :_do_nothing
		},
	"Metal":  { "nbr": 0, "callback" : _do_nothing
		},
	"Farm": {"nbr": -1, "callback": _add_farm},
	"Wheat": {"nbr": 0, "callback": _do_nothing},
	"Bread": {"nbr": 3, "callback": _consume_bread}
}

var first_step = false
var second_step = false
var third_step = false
var fourth_step = false
var fifth_step = false

func update_first_step() -> bool:
	if global.available_items["Wood"].nbr >= 5 and not first_step:
		global.available_items["Wood"].nbr -= 5
		global.first_step = true
	return true

func update_second_step() -> bool:
	if global.available_items["Stone"].nbr >= 10 and not second_step:
		global.available_items["Stone"].nbr -= 10
		global.second_step = true
	return true

func update_third_step() -> bool:
	if global.available_items["Metal"].nbr >= 20 and not third_step:
		global.available_items["Metal"].nbr -= 20
		global.third_step = true
	return true

func update_fourth_step() -> bool:
	if global.available_items["Wheat"].nbr >= 25 and not fourth_step:
		global.available_items["Wheat"].nbr -= 25
		global.fourth_step = true
	return true

func update_fifth_step() -> bool:
	if global.available_items["Bread"].nbr >= 1 and not fifth_step:
		global.available_items["Bread"].nbr -= 1
		global.fifth_step = true
	return true
