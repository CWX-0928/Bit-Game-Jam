extends Label


var SCORE = 0
var player

func _ready() -> void:
	add_to_group("ui")
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	text = "SCORE: 0"


func add_score(amount):
	SCORE += amount
	text = "SCORE: " + str(SCORE)
	var score_store = get_tree().get_first_node_in_group("score")
	if score_store.has_method("score_show"):
		score_store.score_show(SCORE)



func _process(_delta: float) -> void:
	pass
	
