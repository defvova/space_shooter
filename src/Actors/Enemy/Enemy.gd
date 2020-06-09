extends Area2D

export (int) var SPEED = 40
export (int) var ARMOR = 3

signal score_up

func _ready() -> void:
	var main = get_tree().current_scene

	if main.is_in_group('Level'):
		connect('score_up', main, '_on_Enemy_score_up')

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_Enemy_body_entered(body: Node) -> void:
	body.queue_free()

	ARMOR -= 1
	if ARMOR <= 0:
		emit_signal('score_up')
		queue_free()
