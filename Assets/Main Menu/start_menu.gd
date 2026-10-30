extends Control

@export var start_music: AudioStream 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.play_track(start_music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Level Select/level_select.tscn")
	

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Main Menu/tutorial.tscn")
