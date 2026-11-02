extends Control

@onready var recipe_slot_node: PackedScene = preload("res://Assets/food/recipe_maker/recipe_slot.tscn")

@export var recipes : Array[Recipe]

@export var recipe_container : VBoxContainer
