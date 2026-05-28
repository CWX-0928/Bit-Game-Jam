extends Label

var player

func _ready() -> void:
	add_to_group("ui")
	

func _process(_delta: float) -> void:
	text = "SCORE: " + str(GameState.SCORE)
	
