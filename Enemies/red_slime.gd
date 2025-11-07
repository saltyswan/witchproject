extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var target: CharacterBody2D = $"../Witch"
@export var max_hp: int = 100
var current_hp: int
var target_position: Vector2

const SPEED = 100.0

func _ready() -> void:
	add_to_group("mobs")
	current_hp = max_hp

func initialize(spawn_position: Vector2, player_position: Vector2) -> void:
	position = spawn_position
	target_position = player_position

func _physics_process(delta: float) -> void:
	
	if target == null:
		return
	
	nav_agent.target_position = target.global_position
	velocity = global_position.direction_to(nav_agent.get_next_path_position()) * SPEED
	
	move_and_slide()
	
	if current_hp <= 0:
			queue_free()


func _on_slime_timer_timeout() -> void:
	pass # Replace with function body.
