extends KinematicBody2D

export (int) var SPEED: int = 100

const Bullet: Object = preload('res://src/Actors/Player/Bullet.tscn')
const ExplosionEffect: Object = preload("res://src/Actors/ExplosionEffect.tscn")
var velocity: Vector2 = Vector2.ZERO
var screen_size

signal player_death

func _ready():
	screen_size = get_viewport_rect().size

func get_inputs() -> void:
	velocity.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	velocity = velocity.normalized() * SPEED

	if Input.is_action_just_pressed('ui_accept'):
		fire_bullet()

	if Input.is_action_just_pressed('ui_cancel'):
		queue_free()

func _physics_process(delta: float) -> void:
	get_inputs()
	velocity = move_and_slide(SPEED * velocity * delta)
	global_position.y = clamp(global_position.y, 20, screen_size.y - 20)

func _exit_tree() -> void:
	var explosion = ExplosionEffect.instance()

	get_parent().call_deferred('add_child', explosion)
	explosion.global_position = global_position
	emit_signal('player_death')

func fire_bullet() -> void:
	var bullet = Bullet.instance()

	get_parent().call_deferred('add_child', bullet)
	bullet.global_position = global_position

func _on_Area2D_area_entered(area: Area2D) -> void:
	area.queue_free()
	queue_free()
