extends Area2D

export (int) var SPEED = 40
export (int) var ARMOR = 3
export (int) var SCORE_UP = 10

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func score_up() -> void:
	var main = get_tree().current_scene

	if main.is_in_group('Level'):
		main.score += SCORE_UP

func _on_Enemy_body_entered(body: Node) -> void:
	body.queue_free()

	ARMOR -= 1
	if ARMOR <= 0:
		score_up()
		queue_free()
