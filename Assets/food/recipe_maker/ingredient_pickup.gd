extends Node2D

@export var ingredient : item

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.add_item(ingredient, 1)
		animated_sprite_2d.hide()
		$Area2D.set_deferred("monitoring", false)
		
		queue_free()
