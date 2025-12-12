extends CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_retry_pressed() -> void:
	get_tree().paused = false
	$VBoxContainer/Retry/AudioStreamPlayer.play()
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_return_pressed() -> void:
	get_tree().paused = false
	$VBoxContainer/Return/AudioStreamPlayer.play()
	hide()
	
	#NOTE: close current menu
