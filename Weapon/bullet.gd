extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		speed = 0
		$AnimationPlayer.play("explode")
	else:
		queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "explode":
		print("Bullet has exploded")
		queue_free()
