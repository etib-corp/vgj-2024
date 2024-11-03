extends Node2D

@onready var gameScene = preload("res://map.tscn")


func _on_play_pressed() -> void:
	get_tree().quit()


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_packed(gameScene)
