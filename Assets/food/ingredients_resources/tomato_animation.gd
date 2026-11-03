extends Area2D

@export var ingredient : item

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.add_item(ingredient, 1)
		queue_free()
