extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("roll")
	await get_tree().create_timer(28).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")
