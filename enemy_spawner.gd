extends Node2D

var enemy_load = preload("res://scenes/enemy_1.tscn")
var enemy2_load = preload("res://scenes/enemy_2.tscn")
var min_spawn_dist = 300
var max_enemies = 5
var spawn_time = 3

func _ready() -> void:
	spawn_loop()

func spawn_loop():
	while true:
		update_spawn_rate()
		await get_tree().create_timer(spawn_time).timeout
		spawn_enemy()

func spawn_enemy():
	var screen_size = get_viewport_rect().size
	var enemies = get_tree().get_nodes_in_group("enemy")
	var player = get_tree().get_first_node_in_group("player")
	if enemies.size() >= max_enemies:
		
		return
	var enemy
	
	var roll = randf()
	if roll<=0.8:
		enemy = enemy_load.instantiate()
	else:
		enemy = enemy2_load.instantiate()
	enemy.speed += int(GameState.SCORE / 100) * 20
	
	while true:
		enemy.global_position = Vector2(randf_range(0, screen_size.x), randf_range(0, screen_size.x))
		if enemy.global_position.distance_to(player.global_position) > min_spawn_dist:
			break
		
	
	get_parent().add_child(enemy)
	enemy.scale = Vector2(0.5,0.5)

func update_spawn_rate():
	spawn_time = max(0.5, 3.0 - GameState.SCORE / 50.0)
