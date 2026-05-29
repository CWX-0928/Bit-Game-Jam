extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var diretion = Vector2.ZERO
@export var speed = 40
@export var damage = 10

func _ready() -> void:
	animation_player.play("magic")
	rotation = diretion.angle()

func _process(delta: float) -> void:
	global_position += diretion*speed*delta 

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(damage)
		queue_free()
	#take_damage() function will changed based on the real function name in player script
