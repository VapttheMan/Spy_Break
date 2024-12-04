extends Node2D


@export var door_id = 1
@export var door_type : DoorType #Set door type to Front or Side

enum DoorType {Front, Side}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if door_type == DoorType.Front:
		_set_front_door() #Prepare Front Door Animations and Collisions, Remove Side Door Animations and Collisions
	elif door_type == DoorType.Side:
		_set_side_door() #Prepare Side Door Animations and Collisions, Remove Front Door Animations and Collisions


	#Initialize and Prepare computer signaling
	var computer_interfaces = get_tree().get_nodes_in_group("computer_interface")
	for computer_interface in computer_interfaces:
		computer_interface.connect("door_open_signal", Callable(_on_door_open_signal))

#Front and Side for Initialization functions
func _set_front_door(): #Front Door Animation
	$Front_Sprite.play("Door" + str(door_id) + "_Front")
	$Side_Sprite/Side_Static.queue_free()
	$Side_Sprite.visible = false
	$Front_Sprite/Front_Static/Front_CollisionShape_Open.disabled = true

func _set_side_door():
	$Side_Sprite.play("Door" + str(door_id) + "_Side")
	$Front_Sprite/Front_Static.queue_free()
	$Front_Sprite.visible = false
	$Side_Sprite/Side_Static/Side_CollisionShape_Open.disabled = true

func _on_door_open_signal(emitted_id): #If computer is completed, door will recieve completed signal
	if emitted_id == door_id: #If door id is same to computer id
		open_door()
	

func open_door(): #Activate Animations and new Collision based on type of door
	if door_type == DoorType.Front:
		$Front_Sprite.play("Door" + str(door_id) + "_Front_Open")
		$Front_Sprite/Front_Static/Front_CollisionShape_Open.disabled = false
		$Front_Sprite/Front_Static/Front_CollisionShape.disabled = true
		
	elif door_type == DoorType.Side:
		$Side_Sprite.play("Door" + str(door_id) + "_Side_Open")
		$Side_Sprite/Side_Static/Side_CollisionShape_Open.disabled = false
		$Side_Sprite/Side_Static/Side_CollisionShape.disabled = true
