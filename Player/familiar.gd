extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target: CharacterBody2D = $"."

var speed = 500


func _physics_process(delta: float) -> void:
	
	#DEBUG
	#print(position.distance_to(witch.position))
	
	if target == null:
		return
	
	if position.distance_to(target.position) > 5:
		nav_agent.target_position = target.global_position
		velocity = global_position.direction_to(nav_agent.get_next_path_position()) * speed
	
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)


func _on_ready() -> void:
	
	var witches = get_tree().get_nodes_in_group("witch")
	if witches.size() > 0:
		target = witches[0]
	else:
		print("⚠️ No witch found in scene tree")
		
