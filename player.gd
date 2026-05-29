extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $cd/AnimationPlayer

@export var speed  = 200

var max_LIFE = 100
var LIFE = 100
var damage = 1
var can_attack = true
var attacking = false

signal LIFE_changed
signal game_over

func _ready() -> void:
	add_to_group("player")

func handleInput():
	var inputmoving = Input.get_vector("action_left", "action_right", "action_up", "action_down")
	velocity = inputmoving * speed

func _input(_event):
	if Input.is_action_just_pressed("click") and can_attack:
		get_node("Magicspawn").shoot()
		animation_player.play("cd_animation")
		await get_tree().create_timer(1).timeout
		can_attack = true
	else:
		can_attack = false
		return

func _process(_delta: float) -> void:
	handleInput()
	move_and_slide()

func take_damage(amount):
	#hurt_sfx.play()
	LIFE-=amount
	print("PLayer Hurt")
	LIFE_changed.emit(LIFE, max_LIFE)
	
	if LIFE<=0:
		game_over.emit()
