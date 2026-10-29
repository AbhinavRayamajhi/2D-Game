extends Node2D

@onready var end_label: Label = $"../End_Label"
@onready var end_timer: Timer = $"../End_Label/End_Timer"
@onready var scene: Node2D = $".."
@onready var enemy: CharacterBody2D = $"../Enemy"

@export var scene_name: String

var end_label_duration = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	end_timer.timeout.connect(end_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		end_label.show()
		end_timer.start(end_label_duration)
		Global.scene_cleared(scene_name)

func end_level():
	get_tree().change_scene_to_file("res://Assets/Level Select/level_select.tscn")
