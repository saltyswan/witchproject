extends Node2D

#@onready var witch: CharacterBody2D = $Witch
#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#signal witch_entered_danger_zone
var combat_mode = preload('res://dangermode.tscn').instantiate()


@onready var red_slime: CharacterBody2D = $RedSlime
#@onready var combat_music: AudioStreamPlayer = $"../CombatMusic"
#@onready var danger_zone: Area2D = $DangerZone
#@onready var threshold: CollisionShape2D = $DangerZone/Threshold
#var triggered = false




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	
func _on_dangermode_fight_started(player):
	print("COMBAT MODE ENTERED")

func _on_dangermode_fight_ended():
	$Dangermode.exit_combat_mode()

#NOTE: Convertir ça en signal
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	

func _on_slime_timer_timeout() -> void:
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	var player_position = $Witch.position
	red_slime.initialize(mob_spawn_location.position, player_position)



#func _on_witch_entered_danger_zone() -> void:
	#
	#if triggered:
		#return
		#
	#else:
		#print("DANGER ZONE ACTIVATED")
		##Signalfight.emit_signal("witch_entered_danger_zone")
		
		##issue: music starts again each time i step on danger zone, 
		##must activate only one time before fight ends
		#
		##danger_zone.monitoring = false
		##threshold.disabled = true
		#triggered = true
