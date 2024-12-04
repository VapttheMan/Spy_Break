extends Node2D

@onready var gun_item = get_node("Gun_Sprite")
@onready var player = get_tree().get_nodes_in_group("player")[0]

var is_player_inside = false


func _process(delta):
	if is_player_inside: #Actions can only be done inside area if set true
		if Input.is_action_just_pressed("ui_accept"): #If Press E
			gun_item.visible = false #Give player gun
			player.set_has_gun(true) #Change player animations and enable gun shooting

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside = true #If player in area of interaction, set true
