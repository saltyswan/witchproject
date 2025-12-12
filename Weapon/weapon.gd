extends Node2D

@export var Bullet : PackedScene
@export var Spawnbullet : Marker2D

var game_over = false
var using_mouse = true
var shooting_mode = false

func _ready() -> void:
	
	$"../../Dangermode".fight_ended.connect(_on_dangermode_fight_ended)
	$"../../Dangermode".fight_started.connect(_on_dangermode_fight_started)
	
	if shooting_mode:
		shoot()
		print("[Weapon] Ready = shooting")
	
func _process(delta: float) -> void:
	
	var joy_vec = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	
	if joy_vec.length() > 0.2:
		using_mouse = false
		rotation = joy_vec.angle()
	
	if using_mouse:
			look_at(get_global_mouse_position())

#NOTE: add firing effect, change sound.

func shoot():
	$ShootTimer.start()
	call_deferred("instantiate_bullet")
	
func _on_timer_timeout() -> void: 
	instantiate_bullet()

func instantiate_bullet():
	var b = Bullet.instantiate()
	get_tree().get_current_scene().add_child(b)
	b.transform = Spawnbullet.global_transform

func _on_dangermode_fight_started() -> void:
	print("[Weapon] Shooting starts")
	if not shooting_mode:
		shooting_mode = true
		shoot()
		print("[Weapon] Combat mode ON: shooting started")

func _on_dangermode_fight_ended() -> void:
	shooting_mode = false
	$ShootTimer.stop()
	print("[Weapon] Shooting will stop")

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "death_down":
		$ShootTimer.stop()
