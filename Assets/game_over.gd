extends Control

@export var game_over_music : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.play_track(game_over_music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Main Menu/start_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
