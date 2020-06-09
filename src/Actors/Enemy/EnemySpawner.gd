extends Node2D

const Enemy: Object = preload('res://src/Actors/Enemy/Enemy.tscn')

onready var spawn_points: Node2D = $SpawnPoints

func get_spawn_position() -> Vector2:
	var points: Array = spawn_points.get_children()
	points.shuffle()
	return points[0].global_position

func spawn_enemy() -> void:
	var spawn_position: Vector2 = get_spawn_position()
	var enemy: Node2D = Enemy.instance()
	var main = get_tree().current_scene
	main.add_child(enemy)
	enemy.global_position = spawn_position

func _on_Timer_timeout() -> void:
	spawn_enemy()
