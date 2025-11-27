extends Node2D

signal wave_started(wave_number)
signal wave_cleared(wave_number)
signal all_waves_cleared

@onready var red_slime_scene = preload("res://Enemies/Red_slime.tscn")
@onready var witch_scene = preload("res://Player/witch.tscn")
@export var spawn1 : Marker2D
@export var spawn2 : Marker2D
@export var spawn3 : Marker2D

var dead = false


var waves = [
	{"count": 2}, #Wave 1 = 3 enemies
	{"count": 4},
	{"count": 6} ]

var current_wave = 0
var enemies_remaining = 0
var spawning = true
var enemies_spawned = 0

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
			print("Next wave started")



func _on_timer_timeout() -> void:
	_spawn_enemy()
	spawning = false

func _spawn_enemy():
	enemies_spawned += 1
	print("Enemies spawned", enemies_spawned)
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
#NOTE: Add spawn animation on tilemap
	
func _on_enemy_died():
	enemies_remaining -= 1
	print("Enemies remaining:", enemies_remaining)
	if enemies_remaining <= 0:
		$ClearDelay.start()
	
func _on_clear_delay_timeout() -> void:
	if not spawning and enemies_remaining <= 0 and current_wave < waves.size():
		emit_signal("wave_cleared", current_wave + 1)
		current_wave += 1
		enemies_spawned = 0
		_start_next_wave()
		print("Current wave:", current_wave)
	elif current_wave >= waves.size():
		all_waves_cleared.emit()
		return

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "death_down":
		dead = true
#NOTE: add other effects of death here?

func _on_dangermode_fight_ended() -> void:
	pass 

func _process(delta: float) -> void:
	pass
