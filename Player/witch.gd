extends CharacterBody2D

const SPEED = 200.0

@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@onready var step_sound = $StepSound

var gameover = false
var invincible = false
var combat_mode = false
var blinking = false
#var current_hp = max_hp

func _ready() -> void:
	
	$"../Dangermode".fight_ended.connect(on_dangermode_fight_ended)
	$"../Dangermode".fight_started.connect(on_dangermode_fight_started)
	
	add_to_group("witch")
	if combat_mode:
		$Weapon.shoot()
	#for child in hearts_scene.get_children():
		#hearts_list.append(child)
	#print(hearts_list)

func _physics_process(delta: float) -> void:
	
	if not step_sound.playing and velocity.length() > 0:
		step_sound.play()
	
	if gameover:
		return
	
	if not blinking:
	
		if Input.is_action_pressed("move_up"):
			_animated_sprite.play("walk_up")
			$Weapon.show_behind_parent = true
			
		elif Input.is_action_pressed("move_down"):
			_animated_sprite.play("walk_down")
			$Weapon.show_behind_parent = false
			
		else:
			_animated_sprite.play("idle_down")
			$Weapon.show_behind_parent = false
		#wont work anymore : reformulate for "when nothing is pressed"
	
	var input_vector = Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("move_up", "move_down"))
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	move_and_slide()

func _on_hurtbox_body_entered(body: CharacterBody2D) -> void:
		if gameover:
			return
		if not invincible and body.is_in_group("mobs"):
			_animated_sprite.play("blink")
			blinking = true
			HpPlayer.take_damage()
			invincible_state()
		if HpPlayer.current_hp <= 0:
			print("[Witch] BAM you're dead")
			$GameOverWitch.play()
			gameover = true
			_animated_sprite.play("death_down")
		else:
			return



func invincible_state(duration: float = 1.0):
	invincible = true
	print("[Witch] Nothing can stop me!")
	$InvTimer.wait_time = duration
	$InvTimer.start()
	#ADD BLINK FOR DURATION

func _on_inv_timer_timeout() -> void:
	invincible = false
	blinking = false
	print("[Witch] I'm no longer invincible")

func on_dangermode_fight_started() -> void:
	_animated_sprite.play("attack_down")
	combat_mode = true
	print("[Witch] Combat mode is true, you can transform.")

func on_dangermode_fight_ended() -> void:
	_animated_sprite.play("idle_down")
	combat_mode = false
	print("[Witch] I can't transform anymore")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death_down":
			get_tree().change_scene_to_file("res://UI_HUD/GameOver.tscn")
			print("[Witch] Now heading to Game Over screen")
	if anim_name == "blink":
		print("[Witch] I blinked!")
#NOTE: add slow down here?
