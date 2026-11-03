extends Node

# Global
var current_coins:int = 0
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
	current_coins = 0
	scene_1_cleared = false
	scene_2_cleared = false
	get_tree().change_scene_to_file("res://Assets/game_over.tscn")
	
func add_item(item, amount : int = 1):
	inventory[item] = inventory.get(item, 0) + amount
	
func check_ingredients(ingredients : Dictionary):
	for key in ingredients:
		if inventory.get(key, 0) < ingredients[key]:
			return false
	return true
	
func remove_item(item, amount : int = 1):
	inventory[item] = max(0, inventory.get(item, 0) - amount)


func use_ingredients(ingredients : Dictionary):
	for key in ingredients:
		remove_item(key, ingredients[key])
		

func eat_food():
	for item in inventory:
		if item == null or inventory[item] <= 0:
			continue

		if item is Recipe:
			continue

		if item.title == "Cheese Sandwich" or item.title == "Deluxe Burger" or item.title == "Breakfast Sandwich":
			remove_item(item, 1)
			stamina = min(stamina + 250, 1000)
			print("Food eaten! Stamina: ", stamina)
			return

	print("No cooked food!")
