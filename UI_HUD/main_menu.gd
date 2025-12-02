extends CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_play_pressed():
	hide()
	get_tree().change_scene_to_file("res://playground.tscn")

func _on_quit_pressed():
	get_tree().quit()

#NOTE: Nice to have: credits

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
