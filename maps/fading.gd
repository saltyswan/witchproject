extends CanvasLayer

@onready var color_rect = $FadingBackground

signal fadein_finished

func _ready() -> void:
	color_rect.visible = false

func _process(delta: float) -> void:
	pass

func fade_in():
	color_rect.visible = true
	$FadingBackground/AnimationPlayer.play("fade_in")
	print("[Fading] Fade in activated")

func fade_out():
	$FadingBackground/AnimationPlayer.play("fade_out")
	print("[Fading] Fade out activated")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		fadein_finished.emit()
