extends Node2D

@onready var gameScene = load("res://map.tscn")

func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_packed(gameScene)


func _on_beat_addiction_pressed() -> void:
	get_tree().quit()
