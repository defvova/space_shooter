extends Node

onready var highscoreLabel = $HighscoreContainer/HighscoreLabel
onready var scoreLabel = $CurrentScoreContainer/CurrentScoreLabel

func _ready() -> void:
	var save_data = SaveAndLoad.load_data_from_file()
	highscoreLabel.text = 'Highscore : ' + str(save_data.highscore)
	scoreLabel.text = 'Score : ' + str(save_data.last_score)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_accept'):
		get_tree().change_scene("res://src/Levels/StartMenu.tscn")
