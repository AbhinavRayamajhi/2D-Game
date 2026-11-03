extends Control

@onready var recipe_slot_node: PackedScene = preload("res://Assets/food/recipe_maker/recipe_slot.tscn")
@onready var queue_slot_node : PackedScene = preload("res://Assets/food/recipe_maker/queue_slot.tscn")

@export var recipes : Array[Recipe]:
	set(value):
		recipes = value
		
		if recipe_container:
			free_slots()
			load_recipes()

@export var recipe_container : VBoxContainer 
@onready var queue : VBoxContainer = $Panel2/ScrollContainer/Queue
var selected_recipe: Recipe
var selected_rect: Rect2

func _ready():
	free_slots()
	load_recipes()

func _draw():
	draw_rect(selected_rect, Color.WHITE, false, 1)


func load_recipes():
	for recipe in recipes:	
		#for ingredient in recipe.ingredients:
			#Global.add_item(ingredient, 10)
		
		
		
		var recipe_slot = recipe_slot_node.instantiate()
		recipe_container.add_child(recipe_slot)
		recipe_slot.recipe = recipe
		recipe_slot.selected.connect(selection)

func free_slots():
	for slot in recipe_container.get_children():
		slot.free()

func selection(item : Recipe, node : Panel):
	selected_recipe = item
	selected_rect = Rect2(
		node.global_position - global_position,
		node.size
	)
	queue_redraw()
	print(item.name)


func queue_item(item : Recipe):
	if item == null:
		return

	var queue_slot = queue_slot_node.instantiate()
	queue.add_child(queue_slot)
	queue_slot.completed.connect(finished_cooking)
	queue_slot.recipe = item


func finished_cooking(item : Recipe, node : Panel):
	if item == null:
		return

	Global.add_item(item.product, item.product_amount)
	node.queue_free()
	print(item.name + " added.")

func _on_create_pressed() -> void:
	print("CREATE CLICKED")

	if not selected_recipe:
		print("NO RECIPE SELECTED")
		return

	if not Global.check_ingredients(selected_recipe.ingredients):
		print("NOT ENOUGH ITEMS")
		return

	Global.use_ingredients(selected_recipe.ingredients)
	queue_item(selected_recipe)
	print("QUEUE ADDED")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Assets/Level Select/level_select.tscn")


func _on_eat_pressed():
	Global.eat_food()
