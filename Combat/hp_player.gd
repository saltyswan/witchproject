extends Node

var max_hp = 4
var current_hp = max_hp
var hit_damage = 1
signal hp_lost(current_hp: int)

func _ready() -> void:
	pass 

func take_damage():
	current_hp -= hit_damage
	print("[HP Player] Witch HP:", current_hp)
	hp_lost.emit(current_hp)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
