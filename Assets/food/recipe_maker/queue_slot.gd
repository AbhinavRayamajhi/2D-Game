
extends Panel

@onready var meal_icon: TextureRect = $MealIcon

signal completed(item, node)

var recipe : Recipe:
	set(value):
		recipe = value

		if value == null:
			return

		cook_time = max(value.cook_time, 0.01)
		time = 0

		if is_node_ready():
			$ProgressBar.max_value = cook_time

var cook_time : float = 0:
	set(value):
		cook_time = value
		if is_node_ready():
			$ProgressBar.max_value = cook_time
			$ProgressBar.value = 0



var time : float = 0:
	set(value):
		time = value
		if is_node_ready():
			$ProgressBar.max_value = cook_time
			$ProgressBar.value = value
			meal_icon.texture = recipe.product.icon

func _ready():
	if recipe != null:
		$ProgressBar.max_value = cook_time
		$ProgressBar.value = time
		meal_icon.texture = recipe.product.icon


func _physics_process(delta):
	time += delta
	$ProgressBar.value = time
	if recipe == null:
		return

	print("Cooking: ", time)
	time += delta

	if time >= cook_time:
		set_physics_process(false)
		completed.emit(recipe, self)


func _on_cancel_pressed():
	if recipe == null:
		return

	for key in recipe.ingredients:
		Global.add_item(key, recipe.ingredients[key])

	queue_free()
