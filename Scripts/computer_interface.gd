extends CanvasLayer

#@onready var check_text = get_node("TextEdit")
@onready var random_char_label = $TextureRect/RichTextLabel
@onready var player = get_tree().get_nodes_in_group("player")[0]
# Called when the node enters the scene tree for the first time.

var computer_id = 1

signal door_open_signal(door_id)

var text_check
var random_chars = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false #Hide computer interface
	_generate_random_character() #Generate random string for each computer
	random_char_label.clear()  # Clear the RichTextLabel's previous content
	random_char_label.bbcode_text = "[center]" + random_chars + "[/center]"  # Display the random string in the RichTextLabel

func _generate_random_character(): #Initialize 5 character string
	var chars = "abcdefghijklmnopqrstuvwxyz0123456789" 
	var special_chars = "?<>!@#"
	random_chars = ""
	
	for i in range(4):
		random_chars += chars[randi() % chars.length()]
	random_chars += special_chars[randi() % special_chars.length()] #Last character is a special character

func set_computer_id(computer) -> void: #When completed signal appropriate door id
	computer_id = computer

func _on_line_edit_text_changed(new_text: String) -> void: #Check player text input
	text_check = new_text 
	_check_text_match()

func _check_text_match(): #Check is player input correct string
	if text_check == random_chars:
		random_char_label.clear()  # Clear the RichTextLabel's previous content
		random_char_label.bbcode_text = "[center][color=green]" + random_chars + "[/color][/center]" #Change to Green
		await get_tree().create_timer(0.3).timeout
		player.set_can_move(true) #Set Player to move
		visible = false #Hide interface
		
		emit_signal("door_open_signal", computer_id) #Send signals to doors
	
