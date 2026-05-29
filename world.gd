extends Node2D

#@onready var game_over: AudioStreamPlayer = $GameOver - audio
#@onready var game_won: AudioStreamPlayer = $GameWin -audio
var next_upgrade_score = 50
var choosing_upgrade = false
@onready var upgrade_option: Control = $"CanvasLayer/Upgrade Option"
@onready var canvas_layer: CanvasLayer = $"CanvasLayer/Upgrade Option/CanvasLayer"




func _ready():
	$"CanvasLayer/GAME OVER".hide()
	$"CanvasLayer/GAME PAUSED".hide()
	upgrade_option.hide()
	canvas_layer.hide()
	await get_tree().process_frame

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
	GameState.SCORE = 0
	get_tree().paused = false
	get_tree().reload_current_scene()




func game_win():
	get_tree().paused = true
	#game_won.play() - audio
	#$CanvasLayer/WINNING.show()

func game_menu():
	get_tree().paused = true
	$"CanvasLayer/GAME PAUSED".show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		game_menu()
	if not choosing_upgrade and GameState.SCORE >= next_upgrade_score:
		choose_upgrade()
		next_upgrade_score += 50
	
func choose_upgrade():
	choosing_upgrade = true
	get_tree().paused = true
	upgrade_option.show()
	canvas_layer.show()

func close_upgrade():
	choosing_upgrade = false
	get_tree().paused = false
	upgrade_option.hide()
	canvas_layer.hide()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
	


func _on_continue_pressed() -> void:
	get_tree().paused = false
	$"CanvasLayer/GAME PAUSED".hide()
