extends Node

var score: int = 0 setget set_score

onready var score_label = $ScoreLabel

func set_score(value) -> void:
	score = value
	score_label.text = 'Score = ' + str(score)