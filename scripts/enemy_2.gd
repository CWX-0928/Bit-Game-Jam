extends CharacterBody2D

@export var projectile_scene : PackedScene

@onready var player : CharacterBody2D =  get_tree().get_first_node_in_group("player")
@onready var animations: AnimationPlayer = $animations
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shoot_place: Node2D = $shoot_place

var direction : String = "left"

@export var speed = 200
@export var damage = 10
@export var health = 100
@export var safe_distance = Vector2i(20,20)

func _physics_process(delta: float) -> void:
	calculate_direction()
	move_towards_player()
	play_animation()
	move_and_slide()

# Enemy movement func
func move_towards_player():
	var dist = player.global_position - self.global_position 
	if dist.length() > safe_distance :
		velocity = dist*speed
		velocity.normalized()
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
	else:
		if dir.y > 0:
			direction = "down"
		else:
			direction = "up"

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
	projectile.damage = damage
	get_tree().current_scene.add_child(projectile)

# Basic Hurt func
func on_hit(health_damaged):
	health -= health_damaged
	if health <= 0 :
		animations.play("die")

# Repeat shooting process
func _on_shoot_timer_timeout() -> void:
	shoot()
	animations.play("channel")
