extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ExitButton.grab_focus()

#NOTE: (idea from Vulcainos) replace by CanvasLayer with true/false on visible

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI_HUD/MainMenu.tscn")
