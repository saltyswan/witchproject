extends Node2D

#var pause_state = false

func _ready() -> void:
	$Hud/EndGame.show()
	#NOTE: add fade in, maybe

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
