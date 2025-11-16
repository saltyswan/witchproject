extends CharacterBody2D

const SPEED = 300.0

@export var max_hp: int = 100
@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer

var gameover = false
var hit_damage = 10
var invincible = false
var current_hp = max_hp

func _ready() -> void:
	add_to_group("witch")
	

func _physics_process(delta: float) -> void:
	
	if gameover:
		return
		
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
	
	
	var directionX := Input.get_axis("move_left", "move_right")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionY := Input.get_axis("move_up", "move_down")
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()

func _on_hurtbox_body_entered(body: CharacterBody2D) -> void:
		if not invincible and body.is_in_group("mobs"):
			take_damage()
			invincible_state()
		if current_hp <= 0:
			print("BAM you're dead")
			gameover = true
			_animated_sprite.play("death_down")
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


func take_damage():
	current_hp -= hit_damage
	print("Current HP:", current_hp)

func  _on_dangermode_fight_started() -> void:
	_animated_sprite.play("attack_down")

func _on_dangermode_fight_ended() -> void:
	_animated_sprite.play("idle_down")
	#CHANGE FOR JUST STOPPING PLAY SHOOTING ANIMATION


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death_down":
			get_tree().change_scene_to_file("res://GameOver.tscn")
			print("Now heading to Game Over screen")



	
