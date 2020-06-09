extends Area2D

export (int) var SPEED = 40

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func _on_Enemy_body_entered(body: Node) -> void:
	queue_free()
	body.queue_free()
