extends CharacterBody2D

@export var speed  = 150
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func handleInput():
	var inputmoving = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = inputmoving * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleInput()
	move_and_slide()
