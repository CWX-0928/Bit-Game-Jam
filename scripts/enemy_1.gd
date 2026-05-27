extends CharacterBody2D


var player
#@onready var animations: AnimationPlayer = $animations
var direction : String = "left"

@export var speed = 155
@export var damage = 10
@export var health = 3

#signal player_hurt

func _ready() -> void:
	add_to_group("enemy")
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	calculate_direction()
	move_towards_player()
	#play_animation()
	move_and_slide()

# Enemy movement func
func move_towards_player():
	if not player:
		return
	var dist = player.global_position - self.global_position
	velocity = dist.normalized() * speed

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
#func play_animation():
	#match direction:
		#"left":
			#animations.play()
		#"right":
			#animations.play()
		#"up":
			#animations.play()
		#"down":
			#animations.play()

# Basic Damage player func
func _on_damage_area_body_entered(body: Node2D) -> void:

	if body.is_in_group("player"): 
		body.take_damage(damage)
	#take_damage() function will changed based on the real function name in player script


# Basic Hurt func
func on_hit(health_damaged):
	health -= health_damaged
	print("Enemy ded")
	if health<=0:
		GameState.add_score(1)
		queue_free()
