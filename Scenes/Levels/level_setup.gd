extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainAudio.play_music_level() #Every level will call continued music, see main_audio script for more
#Main Audio always set to loop and start when game starts
