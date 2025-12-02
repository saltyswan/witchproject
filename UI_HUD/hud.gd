extends CanvasLayer

var hearts_list : Array[TextureRect]
@export var hearts_scene: VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$MoonSprite.hide()
	$FullMoon.hide()
	
	HpPlayer.hp_lost.connect(on_hp_lost)

	for child in hearts_scene.get_children():
		hearts_list.append(child)
		#print(hearts_list)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_hp_lost(current_hp):
	for i:int in range(hearts_list.size()):
		hearts_list[i].visible = i < current_hp
	print("Witch lost one heart")

func _on_heart_1_visibility_changed() -> void:
	pass


func _on_dangermode_fight_started() -> void:
	$MoonSprite.show()
	$MoonSprite.play("default")


func _on_dangermode_fight_ended() -> void:
	$MoonSprite.hide()
