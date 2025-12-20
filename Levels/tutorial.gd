extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PauseMenu.hide()
	$Fading.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event) -> void:
	if event.is_action_pressed("pause_menu"):
		$PauseMenu.show()
		$PauseMenu/VBoxContainer/Return.grab_focus()
		get_tree().paused = true
		print("[Tutorial] I'm taking a break")

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	$Fading/FadingBackground/AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().change_scene_to_file("res://playground.tscn")
