extends CharacterBody2D

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var animations: AnimationPlayer = $animations

var direction : String = "left"

@export var speed = 200
@export var damage = 10
@export var health = 100

signal player_hurt

func _process(delta: float) -> void:
	calculate_direction()
	move_towards_player()
	play_animation()
	move_and_slide()

# Enemy movement func
func move_towards_player():
	var dist = player.global_position - self.global_position
	velocity = (dist*speed).normalized()

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
	match direction:
		"left":
			animations.play("move_left")
		"right":
			animations.play("move_right")

# Basic Damage player func
func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		body.take_damage(damage)
		animations.play("attack_" + direction)
	#take_damage() function will changed based on the real function name in player script

# Basic Hurt func
func on_hit(health_damaged):
	health -= health_damaged
	self_modulate = Color.RED
	await get_tree().create_timer(0.2).timeout
	self_modulate = Color.WHITE
