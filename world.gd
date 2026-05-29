extends Node2D

#@onready var game_over: AudioStreamPlayer = $GameOver - audio
#@onready var game_won: AudioStreamPlayer = $GameWin -audio

func _ready() -> void:
	$"CanvasLayer/GAME OVER".hide()
	#$CanvasLayer/WINN.hide() - UI
	#$CanvasLayer/PAUSE.hide() - UI
	var player = get_tree().get_first_node_in_group("player")
	var death = get_tree().get_first_node_in_group("death")
	var win = get_tree().get_first_node_in_group("Win")
	#var path_sound = preload("res://freesound_community-walkingondirtpath-35341.mp3") - audio
	#player.set_walk_sound(path_sound) - audio
	if player:
		player.game_over.connect(on_game_over)
		
		
	if death:
		death.game_over.connect(on_game_over)
	
	if win:
		win.won_screen.connect(game_win)
	
	
	


func on_game_over():
	get_tree().paused = true
	#game_over.play() - audio
	$"CanvasLayer/GAME OVER".show()
	
func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func game_win():
	get_tree().paused = true
	#game_won.play() - audio
	#$CanvasLayer/WINNING.show()

func game_menu():
	get_tree().paused = true
	#$CanvasLayer/PAUSE.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		game_menu()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
	


func _on_continue_pressed() -> void:
	get_tree().paused = false
	#$CanvasLayer/PAUSE.hide()
