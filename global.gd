extends Node

func _do_nothing():
	print("toto")

var available_items = {
	"Wood": { "nbr": 20, "callback" : _do_nothing},
	"Stone": { "nbr": 5, "callback" :_do_nothing
		},
	"Metal":  { "nbr": 20, "callback" : _do_nothing
		}
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
