extends Control

@onready var ing: Ing = load("res://Assets/food/ingredients/ingredients.tres")
@onready var slots: Array = $ColorRect/GridContainer.get_children()


var is_open = false


func _ready() -> void:
	update_slots()
	close()
	
func update_slots():
	for i in range(min(ing.listIngredients.size(), slots.size())):
		slots[i].update(ing.listIngredients[i])
	
	
func _process(_delta: float) -> void:
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
	
