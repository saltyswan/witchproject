extends Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func open_portal():
	$AnimationPlayer.play("open")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		close_portal()
	else:
		return


func close_portal():
	$AnimationPlayer.play("close")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
