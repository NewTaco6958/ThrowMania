extends CharacterBody2D


@onready var rockanim = $AnimatedSprite2D
@onready var main = get_node("spawn")
@onready var projectile = load("res://Projectiles/rock.tscn")


func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = global_position
	instance.spawnRot = rotation
	main.add_child.call_deferred(instance)
	
	rockanim.play("throw")
	
	var timer = Timer.new()
	timer.wait_time = 5
	timer.one_shot = true
	timer.connect("timeout", Callable(instance, "_on_timeout"))
	get_tree().current_scene.add_child(timer)
	timer.start()
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
	if Input.is_action_just_pressed("Throw"):
		shoot()



	
	# move_and_slide()

	
	
