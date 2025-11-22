extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@export var target: CharacterBody2D
@export var max_hp: int = 1
var current_hp: int
var target_position: Vector2
var knockback:  Vector2 = Vector2.ZERO
var knocked = false

const SPEED = 100.0
const KB_FORCE = 300

func _ready() -> void:
	add_to_group("mobs")
	current_hp = max_hp
	target = get_tree().get_nodes_in_group("witch")[0]
	
func _physics_process(delta: float) -> void:
	
	if knocked:
		velocity = knockback
		knockback = knockback.move_toward(Vector2.ZERO, 1200 * delta)
		move_and_slide()
		return

	if not knocked:
		nav_agent.target_position = target.global_position
		velocity = global_position.direction_to(nav_agent.get_next_path_position()) * SPEED
		move_and_slide()
		return
	
	if target == null:
		return
	

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if current_hp > 0:
			current_hp -= 20
			#print("Enemy takes damage")
		else:
			queue_free()

func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	
	if knocked:
		return
	
	if body.is_in_group("witch"):
		var kb_vector = global_position - body.global_position
		if kb_vector.length() == 0:
			kb_vector = Vector2.UP
		knockback = kb_vector.normalized() * KB_FORCE
		#print("Enemy hit the witch")
		#print("Enemy position:", global_position)
		#print("Player position:", body.global_position)
		#print("KB vector:", kb_vector)
		hit_witch()

func hit_witch (duration: float = 0.3):
		$KnockTimer.start()
		$KnockTimer.wait_time = duration
		knocked = true
		#print("Enemy HP:", current_hp)
	

func _on_knock_timer_timeout() -> void:
	knocked = false
	knockback = Vector2.ZERO
	#print("Enemy not knocked anymore")
	
