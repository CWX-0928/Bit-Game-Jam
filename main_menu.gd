extends Control

@onready var sprite_animation: AnimationPlayer = $"Animated Sprite/Sprite_animation"
@onready var theme_animation: AnimationPlayer = $Theme_animation

func _ready() -> void:
	
	sprite_animation.play("walk_down")
	theme_animation.play("Theme_reveal")
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
	
func _on_setting_pressed() -> void:
	get_tree().change_scene_to_file("res://setting.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
