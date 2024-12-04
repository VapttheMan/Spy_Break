extends Node2D

@onready var player = get_tree().get_nodes_in_group("player")[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("Arrow")




func _on_area_2d_body_entered(body: Node2D) -> void: #Change to next level if interacted by player
	if body.name ==  "Player":
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		#print(next_level_number)
		#print(current_scene_file)
		var next_level_path = "res://Scenes/Levels/level_" + str(next_level_number) +".tscn"
		#print(next_level_path)
		get_tree().change_scene_to_file(next_level_path)
