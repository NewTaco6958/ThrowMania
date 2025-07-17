extends CharacterBody2D

@onready var animation_player = $AnimatedSprite2D
@onready var projectile_scene = preload("res://Projectiles/rock.tscn")

const MAX_DRAG_DISTANCE = 750.0
const MAX_DRAG_FORCE = 750.0
const DRAG_SENSITIVITY = 4.5

var drag_handler: DragHandler

func _ready():
	drag_handler = DragHandler.new(MAX_DRAG_DISTANCE, MAX_DRAG_FORCE, DRAG_SENSITIVITY, self)
	drag_handler.projectile_thrown.connect(_on_projectile_thrown)

func _input(event):
	drag_handler.handle_input(event)

func _physics_process(delta):
	drag_handler.update(delta)

func _on_projectile_thrown(direction: Vector2, force: float):
	_create_projectile(direction, force)
	_play_throw_animation()

func _create_projectile(direction: Vector2, force: float):
	var projectile = projectile_scene.instantiate()
	projectile.initialize(direction, force, global_position)
	get_parent().add_child(projectile)

func _play_throw_animation():
	animation_player.play("throw")

class DragHandler:
	signal projectile_thrown(direction: Vector2, force: float)
	
	var _start_position: Vector2
	var _current_position: Vector2
	var _is_dragging: bool = false
	var _max_distance: float
	var _max_force: float
	var _sensitivity: float
	var _node_reference: Node
	
	func _init(max_distance: float, max_force: float, sensitivity: float, node: Node):
		_max_distance = max_distance
		_max_force = max_force
		_sensitivity = sensitivity
		_node_reference = node
	
	func handle_input(event: InputEvent):
		if not event is InputEventMouseButton or event.button_index != MOUSE_BUTTON_LEFT:
			return
			
		if event.pressed:
			_start_drag()
		else:
			_end_drag()
	
	func update(delta: float):
		if _is_dragging:
			_current_position = _node_reference.get_global_mouse_position()
	
	func _start_drag():
		_is_dragging = true
		_start_position = _node_reference.get_global_mouse_position()
	
	func _end_drag():
		_is_dragging = false
		var force = _calculate_force()
		if force > 1.0:
			var direction = (_current_position - _start_position).normalized()
			projectile_thrown.emit(direction, force)
	
	func _calculate_force() -> float:
		var distance = _start_position.distance_to(_current_position)
		return min(distance * _sensitivity, _max_force)
