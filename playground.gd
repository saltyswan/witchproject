extends Node2D

@onready var red_slime: CharacterBody2D = $RedSlime
#@onready var red_slime_scene = preload("res://Enemies/Red_slime.tscn")

#signal timeout

func _ready() -> void:
	pass
	
func _on_dangermode_fight_started():
	print("CONNECTED TO MAIN")
	#emit_signal("timeout")

func _on_dangermode_fight_ended():
	$Dangermode.exit_combat_mode()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_slime_timer_timeout() -> void:
		#print("Enemies should spawn")
		#var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
		#mob_spawn_location.progress_ratio = randf()
		#var player_position = $Witch.position
		#red_slime.initialize(mob_spawn_location.position, player_position)
		##NOTE: CREATE A DEDICATED NODE FOR IT?
