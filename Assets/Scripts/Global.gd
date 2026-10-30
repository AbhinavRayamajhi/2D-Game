extends Node

# Global
var current_coins:int = 0
var stamina:int = 1000

var scene_1_cleared:bool = false
var scene_2_cleared:bool = false
var indgredients: int = 0

func scene_cleared(scene: String) -> void:
	if scene == "Scene 1":
		scene_1_cleared = true
	elif scene == "Scene 2":
		scene_2_cleared = true
	else:
		print("Invalid Scene argument for scene_cleared")

func end_game() -> void:
	stamina = 1000
	current_coins = 0
	indgredients = 0
	scene_1_cleared = false
	scene_2_cleared = false
	get_tree().change_scene_to_file("res://Assets/game_over.tscn")
