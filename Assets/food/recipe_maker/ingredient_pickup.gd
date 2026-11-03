extends Node2D

@export var ingredient : item

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.add_item(ingredient, 1)
		animated_sprite_2d.hide()
		$Area2D.set_deferred("monitoring", false)
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
		queue_free()
