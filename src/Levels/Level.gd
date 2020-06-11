extends Node

var score: int = 0 setget set_score
var speed_up_velocity: int = 0
var speed_up_spawner = 2
var enemy_lvl = 3

onready var score_label = $ScoreLabel

func set_score(value) -> void:
	score = value
	score_label.text = 'Score = ' + str(score)

func update_save_data():
	var save_data = SaveAndLoad.load_data_from_file()

	if score > save_data.highscore:
		save_data.highscore = score
	save_data.last_score = score

	SaveAndLoad.save_data_to_file(save_data)

func _on_Player_player_death() -> void:
	update_save_data()
	yield(get_tree().create_timer(1), 'timeout')
	get_tree().change_scene("res://src/Levels/GameOver.tscn")
