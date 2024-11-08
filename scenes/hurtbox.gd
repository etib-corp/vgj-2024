class_name HurtBox
extends Area3D

signal received_damage(damage: int)

@export var audio : AudioStreamPlayer3D
@export var health : int

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		audio.play()
		health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		print(health)
