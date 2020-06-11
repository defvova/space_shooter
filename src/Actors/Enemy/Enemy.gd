extends Area2D

export (int) var SPEED = 40
export (int) var ARMOR = 3
export (int) var SCORE_UP = 10
export (int) var MAX_SPEED_UP = 100
export (int) var SPEED_UP_BY = 2

const ExplosionEffect: Object = preload("res://src/Actors/ExplosionEffect.tscn")
const HitEffect = preload("res://src/Actors/HitEffect.tscn")

func _process(delta: float) -> void:
	var main = get_parent()
	var speed_velocity: int = 0

	if main.is_in_group('Level'):
		speed_velocity = main.speed_up_velocity

	position.x -= (SPEED + speed_velocity) * delta

func score_up() -> void:
	var main = get_parent()

	if main.is_in_group('Level'):
		main.score += SCORE_UP
		var speed = main.speed_up_velocity

		if speed < MAX_SPEED_UP:
			main.speed_up_velocity += SPEED_UP_BY

			if speed > (MAX_SPEED_UP / 3):
				main.speed_up_spawner = 1

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

	get_parent().call_deferred('add_child', explosion)
	explosion.global_position = global_position

func create_hit_effect() -> void:
	var hit_effect = HitEffect.instance()

	get_parent().call_deferred('add_child', hit_effect)
	hit_effect.global_position = global_position
