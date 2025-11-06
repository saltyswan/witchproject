extends CharacterBody2D

const SPEED = 300.0

@export var max_hp: int = 100
var current_hp: int
@onready var _animated_sprite: AnimationPlayer = $AnimationPlayer
@onready var danger_mode: Node2D = $"."



func _ready() -> void:
	add_to_group("witch")

	
func _physics_process(delta: float) -> void:
	
	#var callback = Callable(self, "witch_detected")
	#func witch_detected():
		#_animated_sprite.play("attack_down")
	#
	#Signalfight.connect(("witch_entered_danger_zone"), callback
	
	
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
		
	
		
	#DOESNT WORK: get_global_mouse_position().angle_to_point(position)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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
	
@export var Bullet : PackedScene
@onready var timer: Timer = $Timer

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
