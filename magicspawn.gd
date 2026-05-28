extends Sprite2D

@onready var marker_2d: Marker2D = $Marker2D
var direction = Vector2.ZERO


const MAGIC_1 = preload("res://scenes/magic_1.tscn")

func _ready() -> void:
	pass # Replace with function body.



func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation = direction.angle()

func shoot():
	var new_magic = MAGIC_1.instantiate()
	new_magic.global_position = marker_2d.global_position
	new_magic.direction = (get_global_mouse_position() - marker_2d.global_position).normalized()
	GameState.world.add_child(new_magic)
