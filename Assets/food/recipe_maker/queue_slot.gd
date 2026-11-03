extends Panel

signal completed(item, node)

var recipe : Recipe:
	set(value):
		recipe = value
 
		if value != null:
			#return
		#$TextureRect.texture = value.icon
			cook_time = value.cook_time
			time = 0
 


@onready var meal_name : Label = $MealName
#@onready var timer : Timer = $Timer

var cook_time : float = 0:
	set(value):
		cook_time = value
		if is_node_ready():
			$ProgressBar.max_value = max(value, 0.01)
 
var time : float = 0:
	set(value):
		time = value
		if is_node_ready():
			$ProgressBar.value = value


func _ready():
	cook_time = max(cook_time, 5.0)
	$ProgressBar.max_value = cook_time
	$ProgressBar.value = 0
	set_physics_process(true)


func _physics_process(delta):
	if recipe == null:
		return

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
