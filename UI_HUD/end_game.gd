extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$VBoxContainer/Twitch.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_twitch_pressed() -> void:
	OS.shell_open("https://www.twitch.tv/swan_tinydev")
	
