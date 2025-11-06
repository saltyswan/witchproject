extends Area2D
@onready var dangermode: Node2D = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_danger_zone_body_entered(body: Node2D) -> void:
	#print("DANGER ZONE TRIGGERED")
	#if body.is_in_group("witch"):
		#dangermode.start_fight(body)
#FUNC WAS MOVED TO DANGERMODE SCRIPT
