extends CharacterBody2D

const SPEED = 100.0

@export var max_hp: int = 4
@export var hearts_scene: VBoxContainer
@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@export var direction_sprite: AnimatedSprite2D

var gameover = false
var hit_damage = 1
var invincible = false
var current_hp = max_hp
var hearts_list : Array[TextureRect]

func ready():
	add_to_group("witch")
	for child in hearts_scene.get_children():
		hearts_list.append(child)
	print(hearts_list)
	direction_sprite.flip_h = false

func _physics_process(delta: float) -> void:
	if gameover:
		return

	if Input.is_action_pressed("move_left"):
		direction_sprite.flip_h = true
	var input_vector = Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("move_up", "move_down"))
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED
	else:
		direction_sprite.flip_h = false
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()

func _on_hurtbox_body_entered(body: CharacterBody2D) -> void:
		if gameover:
			return
		if not invincible and body.is_in_group("mobs"):
			take_damage()
			invincible_state()
		if current_hp <= 0:
			print("BAM you're dead")
			gameover = true
			_animated_sprite.play("death")
		else:
			return
			
func update_hearts():
		for i:int in range(hearts_list.size()):
			hearts_list[i].visible = i < current_hp
		print("You lost one heart")

func invincible_state(duration: float = 1.0):
	invincible = true
	print("Nothing can stop me!")
	$InvTimer.wait_time = duration
	$InvTimer.start()
	#ADD BLINK FOR DURATION

func _on_inv_timer_timeout() -> void:
	invincible = false
	print("I'm no longer invincible")

func take_damage():
	current_hp -= hit_damage
	print("Current HP:", current_hp)
	update_hearts()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
			get_tree().change_scene_to_file("res://UI_HUD/GameOver.tscn")
			print("Now heading to Game Over screen")


func _on_werewolf_timer_timeout() -> void:
	pass
