extends CharacterBody2D

@export var projectile_scene : PackedScene

@onready var player : CharacterBody2D =  get_tree().get_first_node_in_group("player")
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shoot_place: Node2D = $shoot_place

var direction : String = "left"

@export var speed = 150
@export var damage = 5
@export var health = 10
@export var safe_distance: float = 20.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	add_to_group("enemy")

func _physics_process(_delta: float) -> void:
	calculate_direction()
	move_towards_player()
	#play_animation()
	move_and_slide()

# Enemy movement func
func move_towards_player():
	var dist = player.global_position - self.global_position 
	if dist.length() > safe_distance :
		velocity = dist.normalized()*speed
	else:
		velocity =Vector2.ZERO



# Calculate direction where enemy is facing
func calculate_direction():
	var dir = (player.global_position - global_position).normalized()

	if abs(dir.x) > abs(dir.y):
		if dir.x > 0:
			direction = "right"
		else:
			direction = "left"

# Controls animations
func play_animation():
	animations.play('walking')
	match direction:
		"left":
			sprite_2d.flip_h = true
			shoot_place.position = Vector2(-8,-9)
		"right":
			sprite_2d.flip_h = false
			shoot_place.position = Vector2(8,-9)


# Shoot Damage player func
func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = shoot_place.global_position
	projectile.direction = (player.global_position - projectile.global_position).normalized()
	projectile.speed = speed *1.5

	get_tree().current_scene.add_child(projectile)

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		body.take_damage(damage)

func on_hit(health_damaged):
	health -= health_damaged
	if health <= 0 :
		animations.play("die")
		GameState.SCORE += 10
		queue_free()

# Repeat shooting process
func _on_shoot_timer_timeout() -> void:
	shoot()
	animations.play("channel")
