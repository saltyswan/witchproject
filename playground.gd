extends Node2D

@onready var fading_scene = preload("res://maps/fading.tscn")
@onready var pause_menu = $PauseMenu
var dangermode = false
#var pause_state = false

func _ready() -> void:
	
	$Spawner.connect("wave_started", Callable(self, "_on_wave_started"))
	$Spawner.connect("wave_cleared", Callable (self, "_on_wave_cleared"))
	$Spawner.connect ("all_waves_cleared", Callable (self, "_on_waves_cleared"))
	
	$Dangermode.fight_ended.connect(on_fight_ended)
	$Dangermode.fight_started.connect(on_fight_started)

	pause_menu.hide()

func on_fight_started():
	dangermode = true
	print("Fight mode started")
	$Spawner.wave_started.emit()
	
func on_fight_ended():
	dangermode = false
	print("Fight mode ended")

func _on_wave_started(wave_number):
	print("Wave ", wave_number, " started!")

func _on_wave_cleared(wave_number):
	print("Wave ", wave_number, " cleared!")

func _input(event) -> void:
	if event.is_action_pressed("pause_menu"):
		pause_menu.show()
		get_tree().paused = true
		print("I'm taking a break")
#func take_a_break():
	#if paused:

func _process(delta: float) -> void:
	pass

func _on_dangermode_fight_started() -> void:
	pass # Replace with function body.

func _on_spawner_wave_started(wave_number: Variant) -> void:
	pass # Replace with function body.


func _on_go_to_lv_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("witch") and not dangermode:
		fade_out_switch()
	

func fade_out_switch():
		var fading_in = fading_scene.instantiate()
		add_child(fading_in)
		fading_in.fadein_finished.connect(on_fadein_complete)
		fading_in.fade_in()

func on_fadein_complete():
		print("Your screen should be black now...")
		var fading_out = fading_scene.instantiate()
		add_child(fading_out)
		fading_out.fade_out()
		get_tree().change_scene_to_file("res://Levels/Level2.tscn")
