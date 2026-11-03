extends Control

@onready var recipe_slot_node: PackedScene = preload("res://Assets/food/recipe_maker/recipe_slot.tscn")

@export var recipes : Array[Recipe]:
	set(value):
		recipes = value
		
		if recipe_container:
			free_slots()
			load_recipes()

@export var recipe_container : VBoxContainer 

var selected_recipe: Recipe
var selected_rect: Rect2

func _ready():
	free_slots()
	load_recipes()

func _draw():
	draw_rect(selected_rect, Color.WHITE, false, 1)


func load_recipes():
	for recipe in recipes:
		var recipe_slot = recipe_slot_node.instantiate()
		recipe_container.add_child(recipe_slot)
		recipe_slot.recipe = recipe
		recipe_slot.selected.connect(selection)

func free_slots():
	for slot in recipe_container.get_children():
		slot.free()

func selection(item : Recipe, node : Panel):
	selected_recipe = item
	selected_rect = Rect2(node.global_position, node.size)
	queue_redraw()
	print(item.name)


func _on_create_pressed() -> void:
	pass # Replace with function body.
	
func finished_cooking(item: Recipe, node : Panel):
	if item == null:
		return
		

	
