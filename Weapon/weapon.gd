extends Node2D

@export var Bullet : PackedScene
@export var Spawnbullet : Marker2D

var game_over = false
var using_mouse = true

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	
	var joy_vec = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	
	if joy_vec.length() > 0.2:
		using_mouse = false
		rotation = joy_vec.angle()
	
	if using_mouse:
			look_at(get_global_mouse_position())

func _on_timer_timeout() -> void: 
	shoot()

#NOTE: add firing effect, change sound.

func shoot():
	$ShootTimer.start()
	var b = Bullet.instantiate()
	get_tree().get_current_scene().add_child(b)
	b.transform = Spawnbullet.global_transform



func _on_dangermode_fight_started() -> void:
	#print("Shooting starts")
	if game_over == false:
		shoot()


func _on_dangermode_fight_ended() -> void:
	$ShootTimer.stop()
	game_over = true
	print("Shooting will stop")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "death_down":
		game_over = true
