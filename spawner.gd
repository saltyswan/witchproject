extends Node2D

signal wave_started(wave_number)
signal wave_cleared(wave_number)
signal all_waves_cleared

@onready var red_slime_scene = preload("res://Enemies/Red_slime.tscn")
@onready var witch_scene = preload("res://Player/witch.tscn")
@onready var wolf_scene = preload("res://Player/werewolf.tscn")
@export var moon_anim: AnimationPlayer
@export var portal_anim: Area2D
@export var spawn1 : Marker2D
@export var spawn2 : Marker2D
@export var spawn3 : Marker2D
@export var full_moon : TextureRect
@export var witch_instance : CharacterBody2D

var waves = [
	{"count": 4}, #Wave 1 = 3 enemies
	{"count": 8},
	{"count": 12} ]

var current_wave = 0
var enemies_remaining = 0
var spawning = true
var enemies_spawned = 0
var wolf_instance : CharacterBody2D = null
var dead = false
var portal_opened = false

func _ready() -> void:
	pass

func _on_wave_started():
	if spawning:
		current_wave = 0
		_start_next_wave()
	else:
		return

func _start_next_wave():
	if current_wave < waves.size():
		var wave_data = waves[current_wave]
		if enemies_spawned < wave_data.count and not dead:
		#for i in range(wave_datas.count):
			$WaveDelay.start()
			spawn_portal()
			print("[Spawner] Next wave started")

func _on_timer_timeout() -> void:
	print("[Spawner] WaveDelay timer started")
	_spawn_enemy()
	spawning = false

func _on_wolftimer_timeout() -> void:
	print("ROARRRRRR")
	wolf_instance = wolf_scene.instantiate()
	get_tree().get_current_scene().add_child(wolf_instance)
	wolf_instance.global_position = witch_instance.global_position
	witch_instance.queue_free()
	$WitchTimer.start()
	full_moon.show()

func _on_witch_timer_timeout():
	print("[Spawner] I'm human again!")
	witch_instance = witch_scene.instantiate()
	get_tree().get_nodes_in_group("weapon")
	witch_instance.combat_mode = true
	get_tree().get_current_scene().add_child(witch_instance)
	witch_instance.global_position = wolf_instance.global_position
	wolf_instance.queue_free()
	$WolfTimer.start()
	moon_anim.play("default")
	full_moon.hide()


func _spawn_enemy():
	enemies_spawned += 1
	print("[Spawner] Enemies spawned", enemies_spawned)
	enemies_remaining += 1
	var enemy = red_slime_scene.instantiate()
	enemy.connect("tree_exited", Callable(self, "_on_enemy_died")) #detect when freed
	add_child(enemy)
	if current_wave == 0: 
		enemy.global_position = spawn1.global_position
	if current_wave == 1:
		enemy.global_position = spawn2.global_position
	if current_wave == 2:
		enemy.global_position = spawn3.global_position
	_start_next_wave()

func spawn_portal():
	if not portal_opened:
		print("[Spawner] Portal activated")
		if current_wave == 0:
			$Portal.global_position = spawn1.global_position
			portal_anim.open_portal()
			portal_opened = true
		if current_wave == 1:
			$Portal.global_position = spawn2.global_position
			$Portal/AnimatedSprite2D.set_rotation_degrees(-90)
			portal_anim.open_portal()
			portal_opened = true
		if current_wave == 2:
			$Portal.global_position = spawn3.global_position
			$Portal/AnimatedSprite2D.set_rotation_degrees(0)
			portal_anim.open_portal()
			portal_opened = true
			

func _on_enemy_died():
	enemies_remaining -= 1
	print("[Spawner] Enemies remaining:", enemies_remaining)
	if enemies_remaining <= 0:
		$ClearDelay.start()
	
func _on_clear_delay_timeout() -> void:
	if not spawning and enemies_remaining <= 0 and current_wave < waves.size():
		emit_signal("wave_cleared", current_wave + 1)
		portal_opened = false
		current_wave += 1
		enemies_spawned = 0
		_start_next_wave()
		print("[Spawner] Current wave:", current_wave)
	elif current_wave >= waves.size():
		all_waves_cleared.emit()
		return

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "death_down":
		dead = true
#NOTE: add other effects of death here?

func _on_dangermode_fight_ended() -> void:
	if wolf_instance:
		witch_instance = witch_scene.instantiate()
		get_tree().get_nodes_in_group("weapon")
		get_tree().get_current_scene().add_child(witch_instance)
		witch_instance.global_position = wolf_instance.global_position
		wolf_instance.queue_free()
		print("[Spawner] Moon is deactivated")
	else:
		return

func _process(delta: float) -> void:
	pass
	#print($WitchTimer.time_left)


func _on_animated_sprite_2d_animation_finished() -> void:
	pass # Replace with function body.
