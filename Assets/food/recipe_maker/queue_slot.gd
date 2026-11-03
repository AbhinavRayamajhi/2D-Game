extends Panel

signal completed(item, node)

var recipe : Recipe:
	set(value):
		recipe = value
 
		if value == null:
			return
		$TextureRect.texture = value.icon
		cook_time = value.cook_time
 


@onready var meal_name : Label = $MealName
@onready var timer : Timer = $Timer

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


func _physics_process(delta):
	if recipe == null:
		return
	
	if time >= 0 and get_index() == 0:
		time += delta
		
	if time >= cook_time:
			completed.emit(recipe, self)
			set_physics_process(false)
 
func _on_cancel_pressed():
	for key in recipe.ingredients:
		Global.add_item(key, recipe.ingredients[key])
	queue_free()
 
