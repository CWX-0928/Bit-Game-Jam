extends Area2D

var direction = Vector2.ZERO
var speed: float = 200
var despawn_time = 1
var damage = 5


func _ready() -> void:
	despawn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	rotation = direction.angle()
	global_position += direction * speed * delta
	
func despawn() -> void:
	await get_tree().create_timer(despawn_time).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	
	if body.is_in_group("enemy"): 
		print("hit enemy")
		body.on_hit(damage)
		queue_free()
