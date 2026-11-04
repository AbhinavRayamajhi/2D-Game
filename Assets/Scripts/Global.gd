extends Node

# Global
var stamina:int = 1000

var scene_1_cleared:bool = false
var scene_2_cleared:bool = false
var inventory : Dictionary = {}


func scene_cleared(scene: String) -> void:
	if scene == "Scene 1":
		scene_1_cleared = true
	elif scene == "Scene 2":
		scene_2_cleared = true
	else:
		print("Invalid Scene argument for scene_cleared")

func end_game() -> void:
	stamina = 1000
	scene_1_cleared = false
	scene_2_cleared = false
	get_tree().change_scene_to_file("res://Assets/game_over.tscn")
	
func add_item(ingredient, amount : int = 1):
	inventory[ingredient.title] = inventory.get(ingredient.title, 0) + amount

func check_ingredients(ingredients : Dictionary):
	for key in ingredients:
		if inventory.get(key.title, 0) < ingredients[key]:
			return false
	return true

func remove_item(ingredient, amount : int = 1):
	inventory[ingredient.title] = max(0, inventory.get(ingredient.title, 0) - amount)

func use_ingredients(ingredients : Dictionary):
	for key in ingredients:
		remove_item(key, ingredients[key])
		

func eat_food():
	var food_stamina = {
		"Cheese Sandwich": 150,
		"Breakfast Sandwich": 250,
		"Deluxe Burger": 400
	}

	for food_name in food_stamina:
		if inventory.get(food_name, 0) > 0:
			inventory[food_name] -= 1
			stamina = min(stamina + food_stamina[food_name], 1000)
			print("Ate ", food_name, "! +", food_stamina[food_name], " stamina")
			return true

	print("No cooked food!")
	return false

	print("No cooked food!")
