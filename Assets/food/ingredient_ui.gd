extends Control

@onready var ing: ingredients = preload("res://Assets/food/ingredients/ingredients.tres")
@onready var slots: Array = $ColorRect/GridContainer.get_children()


var is_open = false


func _ready() -> void:
	update_slots()
	close()
	
func update_slots():
	for i in range(min(ing.ingredients.size(), slots.size())):
		slots[i].update(ing.ingredients[i])
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()
	
	
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
	
