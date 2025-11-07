extends CharacterBody2D

const SPEED = 300.0

@export var max_hp: int = 100
@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@export var Bullet : PackedScene
@onready var timer: Timer = $Timer

var current_hp: int

func _ready() -> void:
	add_to_group("witch")

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("move_right"):
		_animated_sprite.play("walk_down")
		
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.play("walk_down")
		
	elif Input.is_action_pressed("move_up"):
		_animated_sprite.play("walk_down")
		
	elif Input.is_action_pressed("move_down"):
		_animated_sprite.play("walk_down")
		
	else:
		_animated_sprite.play("idle_down")
		
	look_at(get_global_mouse_position())
	
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
	
	for i in (get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("mobs"):
			queue_free()
			print("BAM you're dead")
			#NOTE: GET NOTION OF HP
	


func  _on_dangermode_fight_started() -> void:
	_animated_sprite.play("attack_down")

func _on_dangermode_fight_ended() -> void:
	_animated_sprite.play("idle_down")
	#CHANGE FOR JUST STOPPING PLAY SHOOTING ANIMATION

func _on_timer_timeout() -> void: 
	shoot()

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform =$SpawnBullet.global_transform
