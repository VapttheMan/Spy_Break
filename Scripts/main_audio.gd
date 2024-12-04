extends AudioStreamPlayer


const level_music = preload("res://Assets/spy_showdownMP3.mp3")

func _play_music(music: AudioStream, volume = 0.0): #Continue playing music, in every scene
	#print("Current stream:", stream)
	#print("New music:", music)
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()
	#print("i am playing")
	
func play_music_level(): #Called function from each level
	_play_music(level_music)
	#print("i played")
