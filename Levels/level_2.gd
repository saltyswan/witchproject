extends Node2D

func _ready() -> void:
	
	$Spawner.connect("wave_started", Callable(self, "_on_wave_started"))
	$Spawner.connect("wave_cleared", Callable (self, "_on_wave_cleared"))
	$Spawner.connect ("all_waves_cleared", Callable (self, "_on_waves_cleared"))

var dangermode = false

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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
