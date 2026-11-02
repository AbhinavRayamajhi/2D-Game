extends Panel

@onready var ingredient_visual: Area2D = $CenterContainer/food_display

func update(ingredients: ingredient_item):
	if !ingredients:
		ingredient_visual.visible = false
	else:
		ingredient_visual.visible = ingredients.texture
