extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@export var target: CharacterBody2D
@export var direction_sprite: AnimatedSprite2D
@export var max_hp: int = 6
var current_hp: int
var target_position: Vector2
var knockback:  Vector2 = Vector2.ZERO
var knocked = false
var speed = 100.0
const KB_FORCE = 300
signal last_enemy_killed

func _ready() -> void:
	add_to_group("mobs")
	current_hp = max_hp
	var werewitch = get_tree().get_nodes_in_group("witch")
	target = werewitch[0]
	direction_sprite.flip_h = false
	
func _physics_process(delta: float) -> void:
	
	if not is_instance_valid(target):
		var werewitch = get_tree().get_nodes_in_group("witch")
		print(werewitch)
		if werewitch.size() > 0:
			target = werewitch[0]
	
	if knocked:
		velocity = knockback
		knockback = knockback.move_toward(Vector2.ZERO, 1800 * delta)
		move_and_slide()

	elif not knocked:
		nav_agent.target_position = target.global_position
		velocity = global_position.direction_to(nav_agent.get_next_path_position()) * speed
		move_and_slide()

	if velocity.x < 0:
		direction_sprite.flip_h = true
		
	elif velocity.x >= 0 :
		direction_sprite.flip_h = false
	
	else:
		return

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		if current_hp > 0:
			print("[Skeleton] I have now", current_hp)
			current_hp -= 1
			$AnimationPlayer.play("blink")
			#print("Enemy takes damage")
		else:
			last_enemy_killed.emit()
			print("[Skeleton] You killed me")
			queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:

	if knocked:
		return
	
	if body.is_in_group("witch"):
		var kb_vector = global_position - body.global_position
		print("[Skeleton] I hit the witch")
		if kb_vector.length() == 0:
			kb_vector = Vector2.UP
		knockback = kb_vector.normalized() * KB_FORCE
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

func _on_attack_timer_timeout() -> void:
	$AnimationPlayer.play("attack")
	speed = 60
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		$AttackTimer.start()
		speed = 100
