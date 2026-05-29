extends Node2D

@onready var world: Node2D = $"."



var SCORE = 0

func _ready() -> void:
	pass

func add_score(amount):
	SCORE +=amount

func _process(_delta: float) -> void:
	pass
