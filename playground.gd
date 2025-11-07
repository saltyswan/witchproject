extends Node2D

@onready var red_slime: CharacterBody2D = $RedSlime
#@onready var red_slime_scene = preload("res://Enemies/Red_slime.tscn")

#signal timeout

func _ready() -> void:
	
	$Spawner.connect("wave_started", Callable(self, "_on_wave_started"))
	$Spawner.connect("wave_cleared", Callable (self, "_on_wave_cleared"))
	$Spawner.connect ("all_waves_cleared", Callable (self, "_on_waves_cleared"))
	#$Spawner.start_waves()
	
	$Dangermode.connect("fight_ended", Callable(self, "on_fight_ended"))
	$Dangermode.fight_started.connect(on_fight_started)
	

var dangermode = false

func on_fight_started():
	dangermode = true
	$Spawner.wave_started.emit()

func _on_wave_started(wave_number):
	print("Wave ", wave_number, " started!")

func _on_wave_cleared(wave_number):
	print("Wave ", wave_number, " cleared!")
	
#func _on_dangermode_fight_started():
	#print("CONNECTED TO MAIN")
	#emit_signal("timeout")

#func _on_dangermode_fight_ended():
	#$Dangermode.exit_combat_mode()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_slime_timer_timeout() -> void:
		#print("Enemies should spawn")
		#var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
		#mob_spawn_location.progress_ratio = randf()
		#var player_position = $Witch.position
		#red_slime.initialize(mob_spawn_location.position, player_position)
		##NOTE: MOVED IN SPAWNER


func _on_dangermode_fight_started() -> void:
	pass # Replace with function body.


func _on_spawner_wave_started(wave_number: Variant) -> void:
	pass # Replace with function body.
