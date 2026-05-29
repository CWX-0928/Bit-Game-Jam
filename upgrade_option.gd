extends Control

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_button_1_pressed():
	print("button1 press")
	player.attack_time *= 0.8
	get_tree().current_scene.close_upgrade()
	

func _on_button_2_pressed():
	print("button2 pressed")
	GameState.magic_damage *= 1.2
	get_tree().current_scene.close_upgrade()
