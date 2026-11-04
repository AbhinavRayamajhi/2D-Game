extends Area2D

@export var ingredient : item

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body):
	if body is Player:
		if ingredient == null:
			print("Missing ingredient on: ", name)
			return

		Global.add_item(ingredient, 1)
		print("Collected: ", ingredient.title)
		print("Total: ", Global.inventory[ingredient.title])
		queue_free()
