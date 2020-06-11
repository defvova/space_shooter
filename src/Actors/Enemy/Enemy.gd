extends Area2D

export (int) var SPEED = 40
export (int) var MAX_SPEED_UP = 100
export (int) var SPEED_UP_BY = 2

const ENEMY_PROPS = {
	0: {
		armor = 0,
		color = 'ffffff',
		score = 10,
		can_fire = false
	},
	1: {
		armor = 1,
		color = 'ffffff',
		score = 10,
		can_fire = false
	},
	2: {
		armor = 2,
		color = 'edcf66',
		score = 20,
		can_fire = false
	},
	3: {
		armor = 3,
		color = 'ff2626',
		score = 30,
		can_fire = false
	},
	4: {
		armor = 4,
		color = 'c634e5',
		score = 40,
		can_fire = false
	},
	5: {
		armor = 5,
		color = 'f78438',
		score = 100,
		can_fire = true
	}
}
var enemy_props
var enemy_score = 10
var can_fire = false

const ExplosionEffect: Object = preload("res://src/Actors/ExplosionEffect.tscn")
const HitEffect = preload("res://src/Actors/HitEffect.tscn")
const Bullet = preload("res://src/Actors/Player/Bullet.tscn")

func _ready() -> void:
	var main = get_parent()
	var lvl = 3

	if main.is_in_group('Level'):
		lvl = main.enemy_lvl

	var rand = randi() % lvl + 1
	enemy_props = ENEMY_PROPS[rand]
	set_modulate(enemy_props.color)
	enemy_score = enemy_props.score
	can_fire = enemy_props.can_fire
	fire()

func _process(delta: float) -> void:
	var main = get_parent()
	var speed_velocity: int = 0

	if main.is_in_group('Level'):
		speed_velocity = main.speed_up_velocity

	position.x -= (SPEED + speed_velocity) * delta

func score_up() -> void:
	var main = get_parent()

	if main.is_in_group('Level'):
		main.score += enemy_score
		var speed = main.speed_up_velocity

		if speed < MAX_SPEED_UP:
			main.speed_up_velocity += SPEED_UP_BY

			if main.score >= 200 and main.score <= 400:
				main.speed_up_spawner = 1

			if main.score >= 1000 and main.score <= 1500:
				main.speed_up_spawner = 0.5

			if main.score >= 200 and main.score <= 500:
				main.enemy_lvl = 4

			if main.score >= 500 and main.score <= 1000:
				main.enemy_lvl = 5

func _on_Enemy_body_entered(body: Node) -> void:
	body.queue_free()
	create_hit_effect()
	hit_enemy()

	if enemy_props.armor <= 0:
		score_up()
		create_explosion()
		queue_free()

func hit_enemy() -> void:
	var index = enemy_props.armor - 1
	enemy_props = ENEMY_PROPS[index]
	set_modulate(enemy_props.color)

func create_explosion() -> void:
	var explosion = ExplosionEffect.instance()

	get_parent().call_deferred('add_child', explosion)
	explosion.global_position = global_position

func create_hit_effect() -> void:
	var hit_effect = HitEffect.instance()

	get_parent().call_deferred('add_child', hit_effect)
	hit_effect.global_position = global_position

func fire() -> void:
	if not can_fire:
		return

	var bullet = Bullet.instance()
	bullet.rotation_degrees = 180
	bullet.global_position = global_position
	bullet.collision_mask = 1
	bullet.linear_velocity.x = -200

	get_parent().call_deferred('add_child', bullet)

func _on_Timer_timeout() -> void:
	fire()
