extends Node2D

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Coins: " + str(Global.current_coins)


func _on_cave_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 1/Scene_1.tscn")


func _on_factory_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 2/scene_2.tscn")
