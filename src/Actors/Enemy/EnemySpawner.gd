extends Node2D

const Enemy: Object = preload('res://src/Actors/Enemy/Enemy.tscn')

onready var timer: Timer = $Timer
onready var spawn_points: Node2D = $SpawnPoints

func get_spawn_position() -> Vector2:
	var points: Array = spawn_points.get_children()
	points.shuffle()
	return points[0].global_position

func spawn_enemy() -> void:
	var spawn_position: Vector2 = get_spawn_position()
	var enemy: Node2D = Enemy.instance()

	get_parent().call_deferred('add_child', enemy)
	enemy.global_position = spawn_position

func update_time() -> void:
	var main = get_parent()

	if main.is_in_group('Level'):
		timer.wait_time = main.speed_up_spawner

func _on_Timer_timeout() -> void:
	update_time()
	spawn_enemy()
