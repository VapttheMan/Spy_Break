extends CanvasLayer

#@onready var check_text = get_node("TextEdit")
@onready var random_char_label = $TextureRect/RichTextLabel
@onready var player = get_tree().get_nodes_in_group("player")[0]
# Called when the node enters the scene tree for the first time.

var computer_id = 1

signal door_open_signal(door_id)

var text_check
var random_chars = ""

func _ready() -> void:
	visible = false
	_generate_random_character()
	random_char_label.clear()  # Clear the RichTextLabel's previous content
	#random_char_label.add_text('[center]' + random_chars + '[/center]')  # Display the random string in the RichTextLabel
	random_char_label.bbcode_text = "[center]" + random_chars + "[/center]"

func set_computer_id(computer) -> void:
	computer_id = computer

"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(get_text(check_text))
"""

func _on_line_edit_text_changed(new_text: String) -> void:
	text_check = new_text 
	_check_text_match()

func _generate_random_character():
	var chars = "abcdefghijklmnopqrstuvwxyz0123456789" #ABCDEFGHIJKLMNOPQRSTUVWXYZ
	var special_chars = "?<>!@#"
	random_chars = ""
	
	for i in range(4):
		random_chars += chars[randi() % chars.length()]
	random_chars += special_chars[randi() % special_chars.length()]
	#random_chars = '[center]' + random_chars + '[/center]' 
	
func _check_text_match():
	if text_check == random_chars:
		random_char_label.clear()  # Clear the RichTextLabel's previous content
		random_char_label.bbcode_text = "[center][color=green]" + random_chars + "[/color][/center]"
		await get_tree().create_timer(0.3).timeout
		player.set_can_move(true)
		visible = false
		
		emit_signal("door_open_signal", computer_id)
	
