extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
	
@onready var main = get_node("spawn")
@onready var projectile = load("res://Projectiles/rock.tscn")


func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	main.add_child.call_deferred(instance)
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
<<<<<<< HEAD
		
	if Input.is_action_just_pressed("Throw"):
		shoot()
		
	
	
=======



>>>>>>> 5419cb207f886d0e91f94991d2fe8d996f1b3b3d
	move_and_slide()
	
	
