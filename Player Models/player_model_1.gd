extends CharacterBody2D

@onready var rockanim = $AnimatedSprite2D
@onready var projectile = load("res://Projectiles/rock.tscn")

var drag_start_position = Vector2.ZERO
var drag_current_position = Vector2.ZERO
var drag_force = 0.0
var is_dragging = false

var max_drag_distance = 750.0
var max_drag_force = 750.0
var drag_sensitivity = 4.5

var throw_timer: Timer

func _ready():
	throw_timer = Timer.new()
	throw_timer.wait_time = 0.2
	throw_timer.one_shot = true
	add_child(throw_timer)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			drag_start_position = get_global_mouse_position()
		else:
			is_dragging = false
			if drag_force > 1.0:
				shoot()

func _physics_process(delta: float):
	if is_dragging:
		drag_current_position = get_global_mouse_position()
		var drag_distance = drag_start_position.distance_to(drag_current_position)
		drag_force = min(drag_distance * drag_sensitivity, max_drag_force)

func shoot():
	var instance = projectile.instantiate()
	var throw_direction = (drag_current_position - drag_start_position).normalized()
	instance.dir = throw_direction
	instance.speed = drag_force
	instance.global_position = global_position
	instance.rotation = throw_direction.angle()
	get_parent().add_child(instance)
	rockanim.play("throw")
	drag_force = 0.0
