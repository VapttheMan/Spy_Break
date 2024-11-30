extends Node2D


@onready var interface = get_node("Spy_Computer_Interface")
@onready var player = get_tree().get_nodes_in_group("player")[0]
var is_interface_open = false
var is_player_inside = false

@export var computer_id = 1

func _ready():
	interface.set_computer_id(computer_id)
	$Computer_Sprite.play("computer" + str(computer_id))

func _process(delta):
	if is_player_inside: #Actions can only be done inside area
		if Input.is_action_just_pressed("ui_accept") and !is_interface_open:
			interface.visible = true
			player.set_can_move(false)
			is_interface_open = true
		elif Input.is_action_just_pressed("ui_cancel") and is_interface_open:
			interface.visible = false
			player.set_can_move(true)
			is_interface_open = false

func _on_area_2d_body_entered(body: Node2D) -> void: #Detect Player Enter
	if body.name == "Player":
		is_player_inside = true


func _on_interact_area_body_exited(body: Node2D) -> void: #Detect Player Exit
	if body.name == "Player":
		is_player_inside = false
