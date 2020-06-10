extends Node

const SAVE_DATA_PATH = 'res://save_data.json'

var default_data = {
	highscore = 0
}

func save_data_to_file(data) -> void:
	var json_data = to_json(data)
	var new_file = File.new()
	new_file.open(SAVE_DATA_PATH, File.WRITE)
	new_file.store_line(json_data)
	new_file.close()

func load_data_from_file():
	var save_file = File.new()
	if not save_file.file_exists(SAVE_DATA_PATH):
		return default_data

	save_file.open(SAVE_DATA_PATH, File.READ)
	var save_data = parse_json(save_file.get_as_text())
	save_file.close()

	return save_data
