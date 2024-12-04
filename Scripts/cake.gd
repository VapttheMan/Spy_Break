extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var player = get_tree().get_nodes_in_group("player")[0]


func _on_area_2d_body_entered(body: Node2D) -> void: #Return player to main menu
	if body.name == "Player":
		await get_tree().create_timer(9).timeout 
		$AnimatedSprite2D.visible = false
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
