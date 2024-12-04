extends Control


func _on_button_pressed() -> void: #Play Button
	get_tree().change_scene_to_file("res://Scenes/Levels/level_0.tscn")
	
func _on_level_pressed() -> void: #Level Select Button
	get_tree().change_scene_to_file("res://Scenes/levels_menu.tscn")

func _on_credits_pressed() -> void: #Credits Button
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
