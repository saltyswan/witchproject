extends CharacterBody2D

const SPEED = 100.0

@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@export var direction_sprite: AnimatedSprite2D

var gameover = false
var invincible = false

func ready():
	add_to_group("witch")
	direction_sprite.flip_h = false

func _physics_process(delta: float) -> void:
	if gameover:
		return

	if Input.is_action_pressed("move_left"):
		direction_sprite.flip_h = true
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
			
#func update_hearts():
		#for i:int in range(hearts_list.size()):
			#hearts_list[i].visible = i < current_hp
		#print("You lost one heart")

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

func _on_werewolf_timer_timeout():
		print("Full Moon signal connected")
		var witch_scene = preload("res://Player/witch.tscn")
		var witch_instance = witch_scene.instantiate()
		get_tree().get_current_scene().add_child(witch_instance)
		witch_instance.global_position = global_position
		queue_free()


func _on_tree_entered() -> void:
	$"../Dangermode".wolf_timeout.connect(_on_werewolf_timer_timeout) # Replace with function body.
