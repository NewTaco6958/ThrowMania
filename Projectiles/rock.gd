extends CharacterBody2D

@export var gravity: float = 500.0
@export var lifetime: float = 3.0

var _lifetime_timer: Timer

func _ready():
	_setup_lifetime_timer()

func initialize(direction: Vector2, speed: float, start_position: Vector2):
	velocity = direction * speed
	rotation = velocity.angle()
	global_position = start_position

func _physics_process(delta):
	_apply_gravity(delta)
	_update_rotation()
	move_and_slide()

func _setup_lifetime_timer():
	_lifetime_timer = Timer.new()
	_lifetime_timer.wait_time = lifetime
	_lifetime_timer.one_shot = true
	_lifetime_timer.timeout.connect(_destroy)
	add_child(_lifetime_timer)
	_lifetime_timer.start()

func _apply_gravity(delta: float):
	velocity.y += gravity * delta

func _update_rotation():
	rotation = velocity.angle()

func _destroy():
	queue_free()
