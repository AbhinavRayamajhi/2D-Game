extends Panel

signal selected(recipe, node)

var recipe : Recipe:
	set(value):
		recipe = value
		%Label.text = value.name
		%Meal.texture = value.icon
		for i in range(value.ingredients.size()):
			var key = value.ingredients.keys()[i]
			%ingredient.get_child(i).texture = key.icon
			%ingredient.get_child(i).find_child("Amount").text = str(value.ingredients[key])


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			selected.emit(recipe, self)
