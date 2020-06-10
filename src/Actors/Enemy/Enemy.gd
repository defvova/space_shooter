extends Area2D

export (int) var SPEED = 40
export (int) var ARMOR = 3
export (int) var SCORE_UP = 10

const ExplosionEffect: Object = preload("res://src/Actors/ExplosionEffect.tscn")
const HitEffect = preload("res://src/Actors/HitEffect.tscn")

func _process(delta: float) -> void:
	position.x -= SPEED * delta

func score_up() -> void:
	var main = get_tree().current_scene

	if main.is_in_group('Level'):
		main.score += SCORE_UP

func _on_Enemy_body_entered(body: Node) -> void:
	body.queue_free()
	create_hit_effect()

	ARMOR -= 1
	if ARMOR <= 0:
		score_up()
		create_explosion()
		queue_free()

func create_explosion() -> void:
	var explosion = ExplosionEffect.instance()
	var main = get_tree().current_scene
	main.add_child(explosion)
	explosion.global_position = global_position

func create_hit_effect() -> void:
	var hit_effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(hit_effect)
	hit_effect.global_position = global_position
