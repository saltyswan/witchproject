extends Node2D

@export var Bullet : PackedScene
@export var Spawnbullet : Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	$Timer.start()
	var b = Bullet.instantiate()
	get_tree().get_current_scene().add_child(b)
	b.transform = Spawnbullet.global_transform


func _on_dangermode_fight_started() -> void:
	shoot()


func _on_dangermode_fight_ended() -> void:
	$Timer.stop()
