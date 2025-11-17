extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("doors")

func open_doors():
	$AnimationPlayer.play("open")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
