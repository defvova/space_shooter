extends KinematicBody2D

export (int) var SPEED: int = 100

var Bullet: Object = preload('res://src/Actors/Player/Bullet.tscn')
var velocity: Vector2 = Vector2.ZERO

func get_inputs() -> void:
	velocity.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	velocity = velocity.normalized() * SPEED

	if Input.is_action_just_pressed('ui_accept'):
		fire_bullet()

func _physics_process(delta: float) -> void:
	get_inputs()
	velocity = move_and_slide(SPEED * velocity * delta)

func fire_bullet() -> void:
	var bullet = Bullet.instance()
	var main = get_tree().current_scene
	main.add_child(bullet)
	bullet.global_position = global_position


func _on_Area2D_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
