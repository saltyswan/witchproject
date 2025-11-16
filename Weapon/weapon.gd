extends Node2D

@export var Bullet : PackedScene
@export var Spawnbullet : Marker2D

var gameover = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
	var joy_vec = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	
	if Input.get_mouse_mode() != Input.MOUSE_MODE_HIDDEN:
		look_at(get_global_mouse_position())
	else:
		rotation = joy_vec.angle()

func _on_timer_timeout() -> void: 
	shoot()

func shoot():
	$ShootTimer.start()
	var b = Bullet.instantiate()
	get_tree().get_current_scene().add_child(b)
	b.transform = Spawnbullet.global_transform



func _on_dangermode_fight_started() -> void:
	#print("Shooting starts")
	if gameover == false:
		shoot()


func _on_dangermode_fight_ended() -> void:
	$ShootTimer.stop()
	gameover = true
	print("Shooting will stop")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "death_down":
		gameover = true
