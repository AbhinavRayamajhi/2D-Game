extends Node

var audio_player : AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.bus = "res://Assets/Music/the_mountain-retro-game-593063.mp3"
	

func play_track(stream: AudioStream) -> void:
	if audio_player.stream == stream and audio_player.playing:
		return
	audio_player.volume_db = -15.0 
	audio_player.stream = stream
	audio_player.play()

func stop_music() -> void:
	audio_player.stop()
