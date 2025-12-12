extends Node2D

@onready var pause_menu = $PauseMenu
var dangermode = false
#var pause_state = false

func _ready() -> void:
	
	Spawner.connect("wave_started", Callable(self, "_on_wave_started"))
	Spawner.connect("wave_cleared", Callable (self, "_on_wave_cleared"))
	Spawner.connect ("all_waves_cleared", Callable (self, "_on_waves_cleared"))
	
	Dangermode.fight_ended.connect(on_fight_ended)
	Dangermode.fight_started.connect(on_fight_started)

	pause_menu.hide()
	#NOTE: add fade in, maybe

func on_fight_started():
	dangermode = true
	print("[Level 2] Fight mode started")
	Spawner.wave_started.emit()
	$WolfTimer.start()
	Dangermode.now_in_combat = true
	print("[Level 2] Now in combat = ", Dangermode.now_in_combat)
	
func on_fight_ended():
	dangermode = false
	print("[Level 2] Fight mode ended")
	$WolfTimer.stop()
	$WitchTimer.stop()

func _on_wave_started(wave_number):
	print("Wave ", wave_number, " started!")

func _on_wave_cleared(wave_number):
	print("Wave ", wave_number, " cleared!")

func _input(event) -> void:
	if event.is_action_pressed("pause_menu"):
		pause_menu.show()
		$PauseMenu/VBoxContainer/Return.grab_focus()
		get_tree().paused = true
		print("[Level 2] I'm taking a break")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
