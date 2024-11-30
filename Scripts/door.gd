extends Node2D


@export var door_id = 1
@export var door_type : DoorType
#@onready var computer_interfaces = get_tree().get_nodes_in_group("computer_interface")

enum DoorType {Front, Side}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var target = get_tree().call_group("computer_interface", "connect_signal")
	if door_type == DoorType.Front:
		_set_front_door()
	elif door_type == DoorType.Side:
		_set_side_door()
	#print(door_type)
	
	var computer_interfaces = get_tree().get_nodes_in_group("computer_interface")
	for computer_interface in computer_interfaces:
		computer_interface.connect("door_open_signal", Callable(_on_door_open_signal))
	
func _set_front_door():
	$Front_Sprite.play("Door" + str(door_id) + "_Front")
	$Side_Sprite/Side_Static.queue_free()
	$Side_Sprite.visible = false
	$Front_Sprite/Front_Static/Front_CollisionShape_Open.disabled = true
	
	
func _set_side_door():
	$Side_Sprite.play("Door" + str(door_id) + "_Side")
	$Front_Sprite/Front_Static.queue_free()
	$Front_Sprite.visible = false
	$Side_Sprite/Side_Static/Side_CollisionShape_Open.disabled = true

func _on_door_open_signal(emitted_id):
	"""
	for computer_interface in computer_interfaces:
		if computer_interface.has_method("_get_last_emitted_id"):  # Optional: Ensure this method exists
			var last_emitted_id = computer_interface._get_last_emitted_id()
			if last_emitted_id == door_id:
				open_door()
	"""
	if emitted_id == door_id:
		open_door()
	

func open_door():
	#print("Door", door_id, "is opening!")
	if door_type == DoorType.Front:
		$Front_Sprite.play("Door" + str(door_id) + "_Front_Open")
		#$Front_Sprite/Front_Static.queue_free()
		$Front_Sprite/Front_Static/Front_CollisionShape_Open.disabled = false
		$Front_Sprite/Front_Static/Front_CollisionShape.disabled = true
		
	elif door_type == DoorType.Side:
		$Side_Sprite.play("Door" + str(door_id) + "_Side_Open")
		#$Side_Sprite/Side_Static.queue_free()
		$Side_Sprite/Side_Static/Side_CollisionShape_Open.disabled = false
		$Side_Sprite/Side_Static/Side_CollisionShape.disabled = true
		
		
		
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
