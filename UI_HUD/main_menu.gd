extends CanvasLayer
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	$VBoxContainer/PlayButton.grab_focus()
	$BackgroundMenu/AnimationPlayer.play("default")

func _on_play_pressed():
	$AnimationPlayer.play("fadetoLevel")
	#NOTE: add fade effect
	$VBoxContainer/PlayButton/AudioStreamPlayer.play()
	$Fading.fade_in_main()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in_main":
		#hide()
		get_tree().change_scene_to_file("res://playground.tscn")

func _on_quit_pressed():
	get_tree().quit()

#NOTE: Nice to have: credits

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
