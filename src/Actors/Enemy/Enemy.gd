extends Area2D

export (int) var SPEED = 40
export (int) var ARMOR = 3

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_Enemy_body_entered(body: Node) -> void:
	body.queue_free()

	ARMOR -= 1
	if ARMOR <= 0:
		queue_free()
