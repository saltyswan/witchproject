extends Node2D

@onready var pause_menu = $PauseMenu
var dangermode = false
#var pause_state = false

func _ready() -> void:
	
	$Spawner.connect("wave_started", Callable(self, "_on_wave_started"))
	$Spawner.connect("wave_cleared", Callable (self, "_on_wave_cleared"))
	$Spawner.connect ("all_waves_cleared", Callable (self, "_on_waves_cleared"))
	$Hud/EndGame.hide()

	pause_menu.hide()
	#NOTE: add fade in, maybe
	

func on_fight_started():
	dangermode = true
	print("[Playground] Fight mode started")
	$Spawner.wave_started.emit()
	$Spawner/WolfTimer.start()
	$Dangermode.now_in_combat = true
	print("[Playground] Now in combat = ", $"Dangermode".now_in_combat)
	
func on_fight_ended():
	dangermode = false
	print("[Playground] Fight mode ended")
	$Spawner/WolfTimer.stop()
	$Spawner/WitchTimer.stop()

func _on_wave_started(wave_number):
	print("[Playground] Wave ", wave_number, " started!")

func _on_wave_cleared(wave_number):
	print("[Playground] Wave ", wave_number, " cleared!")

func _input(event) -> void:
	if event.is_action_pressed("pause_menu"):
		pause_menu.show()
		$PauseMenu/VBoxContainer/Return.grab_focus()
		get_tree().paused = true
		print("[Playground] I'm taking a break")
#func take_a_break():
	#if paused:

func _process(delta: float) -> void:
	pass

func _on_spawner_wave_started(wave_number: Variant) -> void:
	pass # Replace with function body.


func _on_go_to_lv_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("witch") and not dangermode:
		fade_out_switch()

func fade_out_switch():
	$Fading.fadein_finished.connect(on_fadein_complete)
	$Fading.fade_in()

func on_fadein_complete():
		print("[Playground] Your screen should be black now...")
		$Fading.fade_out()
		get_tree().change_scene_to_file("res://Levels/Level2.tscn")
