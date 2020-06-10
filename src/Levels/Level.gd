extends Node

var score: int = 0 setget set_score

onready var score_label = $ScoreLabel

func set_score(value) -> void:
	score = value
	score_label.text = 'Score = ' + str(score)

func _on_Player_player_death() -> void:
	yield(get_tree().create_timer(1), 'timeout')
	get_tree().change_scene("res://src/Levels/GameOver.tscn")
