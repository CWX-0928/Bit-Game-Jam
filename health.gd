extends Label

var LIFE = 100
var player

func _ready() -> void:
	add_to_group("health")
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	player.LIFE_changed.connect(LIFE_show)
	LIFE_show(player.LIFE, player.max_LIFE)

func LIFE_show(current, _max_value):
	LIFE = current
	text = str(LIFE)
	

func _process(_delta: float) -> void:
	pass
