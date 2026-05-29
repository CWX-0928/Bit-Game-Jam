extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("roll")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _process(_delta):
	if Input.is_action_pressed("click"):
		animation_player.speed_scale = 3.0
	else:
		animation_player.speed_scale = 1.0
