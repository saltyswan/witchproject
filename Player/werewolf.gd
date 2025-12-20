extends CharacterBody2D

const SPEED = 150.0

@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@export var direction_sprite: AnimatedSprite2D
@onready var claw_node: Node2D = $Claw

var gameover = false
var invincible = false

func _ready():
	add_to_group("witch")
	direction_sprite.flip_h = false
	print("Ready is applied")
	
	#claw_node.hide()

func _physics_process(delta: float) -> void:
	
	if gameover:
		return

	var input_vector = Vector2(Input.get_axis("move_left","move_right"), Input.get_axis("move_up", "move_down"))
	velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED
		
		if input_vector.x < 0:
			direction_sprite.flip_h = true
			$Claw.scale.x = -1.0
			$AnimatedSprite2D/StaticBody2D.scale.x = -1.0
		elif input_vector.x > 0:
			direction_sprite.flip_h = false
			$Claw.scale.x = 1.0
			$AnimatedSprite2D/StaticBody2D.scale.x = 1.0

	move_and_slide()

func _on_hurtbox_body_entered(body: CharacterBody2D) -> void:
		if gameover:
			return
		if not invincible and body.is_in_group("mobs"):
			$HurtboxSound.play()
			HpPlayer.take_damage()
			invincible_state()
			$AnimationPlayer.play("blink")
		if HpPlayer.current_hp <= 0:
			print("[Werewolf] BAM you're dead")
			gameover = true
			$"../Spawner/WitchTimer".stop()
			$"../Hud/GameOver/".show()
			$"../Dangermode/Music/AnimationPlayer".play("fadetogameover")
			$"../Fading".fade_in()
			$"../Hud/MoonSprite".hide()
			$"../Hud/GameOver/GameOverFade".play("fade_in")
			$GameOverWolf.play()
			_animated_sprite.play("death")
		else:
			return

func invincible_state(duration: float = 1.0):
	invincible = true
	print("[Werewolf] Nothing can stop me!")
	$InvTimer.wait_time = duration
	$InvTimer.start()

func _on_inv_timer_timeout() -> void:
	invincible = false
	print("[Werewolf] I'm no longer invincible")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
			get_tree().change_scene_to_file("res://UI_HUD/MainMenu.tscn")
			print("[Werewolf] Now leaving the game")

func _on_pretransfo_timer_timeout() -> void:
	$SurpriseSprite.show()
	$AnimationPlayer2.play("pretransfo")
