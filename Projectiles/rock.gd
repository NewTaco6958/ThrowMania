extends CharacterBody2D

@export var gravity = 500.0
@export var speed = 0.0

var dir: Vector2 = Vector2.ZERO

func _ready():
	velocity = dir * speed
	rotation = velocity.angle()
	$Timer.timeout.connect(_on_timeout)
	$Timer.start()

func _physics_process(delta):
	velocity.y += gravity * delta
	rotation = velocity.angle()
	move_and_slide()

func _on_timeout():
	queue_free()
