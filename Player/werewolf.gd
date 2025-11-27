extends CharacterBody2D

const SPEED = 100.0

@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@export var direction_sprite: AnimatedSprite2D
@onready var _claw_animation: AnimationPlayer = $Claw/AnimationPlay
@onready var claw_node: Node2D = $Claw
@onready var witch_scene = preload("res://Player/witch.tscn")

var gameover = false
var invincible = false
var back_to_witch = false
var transformation_triggered = false

func _ready():
	add_to_group("witch")
	direction_sprite.flip_h = false
	print("Ready is applied")
	claw_node.hide()
	print(witch_scene)

func _physics_process(delta: float) -> void:
	pass
	
	if gameover:
		return

	if Input.is_action_pressed("move_left"):
		direction_sprite.flip_h = true
		#NOTE: add flip position of claw
		#NOTE: detection is clunky
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
			HpPlayer.take_damage()
			invincible_state()
		if HpPlayer.current_hp <= 0:
			print("BAM you're dead")
			gameover = true
			_animated_sprite.play("death")
		else:
			return

func invincible_state(duration: float = 1.0):
	invincible = true
	print("Nothing can stop me!")
	$InvTimer.wait_time = duration
	$InvTimer.start()
	#ADD BLINK FOR DURATION

func _on_inv_timer_timeout() -> void:
	invincible = false
	print("I'm no longer invincible")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
			get_tree().change_scene_to_file("res://UI_HUD/GameOver.tscn")
			print("Now heading to Game Over screen")

func _on_b_2w_timer_timeout() -> void:
	back_to_witch = true
	print("Back to witch possible")
	print(witch_scene)

func _on_werewolf_timer_timeout():
	if back_to_witch and not transformation_triggered:
		transformation_triggered = true
		print("Full Moon signal connected")
		var witch_instance = witch_scene.instantiate()
		get_tree().get_current_scene().add_child(witch_instance)
		witch_instance.global_position = global_position
		queue_free()

func _on_tree_entered() -> void:
	$"../Dangermode".wolf_timeout.connect(_on_werewolf_timer_timeout) # Replace with function body.
	print("Custom signal Full Moon connected to werewolf")
	
func _on_b_2w_timer_tree_entered() -> void:
	$B2WTimer.start()
	print("Werewolf back to witch timer activated")

func _on_claw_timer_timeout() -> void:
	if not gameover:
		_animated_sprite.play("attack")
		claw_node.show()
		_claw_animation.play("default")
		print("Claw attack !")

func _on_animation_play_animation_finished(anim_name: StringName) -> void:
	if anim_name == "default":
		claw_node.hide()
