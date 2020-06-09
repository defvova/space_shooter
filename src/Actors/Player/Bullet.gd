extends RigidBody2D

const HitEffect = preload("res://src/Actors/HitEffect.tscn")

func _exit_tree() -> void:
	create_hit_effect()

func create_hit_effect() -> void:
	var hit_effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(hit_effect)
	hit_effect.global_position = global_position
