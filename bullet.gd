extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	#if body.is_in_group("mobs"):
		#body.current_hp -= 20
		##NOTE: CHANGE FOR BLINK AND DIE AFTER X NUMBER OF SHOTS
