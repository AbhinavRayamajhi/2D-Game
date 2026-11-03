extends Resource
class_name cheese_sandwich_Recipe

@export var name: String
@export var icon: Texture2D
@export var ingredients: Dictionary[ingredient_item, int]
@export var product: ingredient_item 
@export var product_amount: int = 1
@export var cook_time: float = 5.0
