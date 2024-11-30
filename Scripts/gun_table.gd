extends Node2D

@onready var gun_item = get_node("Gun_Sprite")
@onready var player = get_tree().get_nodes_in_group("player")[0]

var is_player_inside = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	if is_player_inside: #Actions can only be done inside area
		if Input.is_action_just_pressed("ui_accept"):
			gun_item.visible = false
			player.set_has_gun(true)

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_inside = true
