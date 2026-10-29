
extends Control


@onready var tomatoes: Label = $TomatoCount


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	tomatoes.text = "EATEN: " + str(Global.tomatoes)
