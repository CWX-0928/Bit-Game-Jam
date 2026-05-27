extends Node2D

var enemy_load = preload("res://scenes/enemy_1.tscn")
var enemy2_load = preload("res://scenes/enemy_2.tscn")
var max_enemies = 5

func _ready() -> void:
	spawn_loop()

func spawn_loop():
	while true:
		await get_tree().create_timer(5).timeout
		spawn_enemy()

func spawn_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() >= max_enemies:
		return
	var enemy
	
	var roll = randf()
	if roll<=0.8:
		enemy = enemy_load.instantiate()
	else:
		enemy = enemy2_load.instantiate()
	
	get_parent().add_child(enemy)
	enemy.global_position = Vector2(randf_range(100,900), randf_range(200,400))
	enemy.scale = Vector2(0.5,0.5)

func _process(_delta: float) -> void:
	pass
