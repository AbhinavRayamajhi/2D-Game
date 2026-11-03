extends Control

@export var ingredients : Array[item] = []
@onready var slots: Array = $ColorRect/GridContainer.get_children()


var is_open = false


func _ready() -> void:
	for ingredient in ingredients:
		if ingredient != null:
			Global.add_item(ingredient, 10)

	update_slots()
	open()
	
func update_slots():
	for i in range(slots.size()):
		if i < ingredients.size():
			slots[i].update(ingredients[i])
		else:
			slots[i].update(null)
	
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
	
func add_item(item, amount : int = 1):
	Global.add_item(item, amount)
	update_slots()


func check_ingredients(ingredients : Dictionary):
	return Global.check_ingredients(ingredients)


func remove_item(item, amount : int = 1):
	Global.remove_item(item, amount)
	update_slots()


func use_ingredients(ingredients : Dictionary):
	Global.use_ingredients(ingredients)
	update_slots()
