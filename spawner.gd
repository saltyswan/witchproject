extends Node2D

signal wave_started(wave_number)
signal wave_cleared(wave_number)
signal all_waves_cleared

@onready var red_slime_scene = preload("res://Enemies/Red_slime.tscn")
@onready var witch_scene = preload("res://Player/witch.tscn")
@export var spawn1 : Marker2D
@export var spawn2 : Marker2D
@export var spawn3 : Marker2D


var waves = [
	{"count": 3, "delay": 1.0}, #Wave 1 = 3 enemies
	{"count": 5, "delay": 0.8},
	{"count": 8, "delay": 0.6} ]

var current_wave = 0
var enemies_remaining = 0
var spawning = true


#func _on_dangermode_fight_started() -> void:
	#spawning = true

func _on_wave_started():
	if spawning:
		current_wave = 0
		_start_next_wave()
	else:
		return

func _start_next_wave():
	if current_wave >= waves.size():
		all_waves_cleared.emit()
		return
	var wave_data = waves[current_wave]
	emit_signal("wave_started", current_wave + 1)
	enemies_remaining = wave_data.count
	for i in range(wave_data.count):
		await get_tree().create_timer(wave_data.delay).timeout
		_spawn_enemy()
		spawning = false

func _spawn_enemy():
	var enemy = red_slime_scene.instantiate()
	enemy.connect("tree_exited", Callable(self, "_on_enemy_died")) #detect when freed
	add_child(enemy)
	if current_wave == 0:
		enemy.global_position = spawn1.global_position
	if current_wave == 1:
		enemy.global_position = spawn2.global_position
	if current_wave == 2:
		enemy.global_position = spawn3.global_position
	
func _on_enemy_died():
	#print("Enemies:", enemies_remaining)
	enemies_remaining -= 1
	if enemies_remaining <= 0 and not spawning:
		emit_signal("wave_cleared", current_wave + 1)
		current_wave += 1
		_start_next_wave()


func _on_dangermode_fight_ended() -> void:
	pass # Replace with function body.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
