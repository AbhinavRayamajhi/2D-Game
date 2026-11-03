extends Panel

@onready var ingredient_visual: Area2D = $CenterContainer/food_display
@onready var ingredient_sprite: AnimatedSprite2D = $CenterContainer/food_display/Sprite2D

func update(ingredients: item):
	if !ingredients:
		ingredient_visual.visible = false
	else:
		ingredient_visual.visible = true
		
		var frames = SpriteFrames.new()
		frames.add_frame("default", ingredients.icon)
		ingredient_sprite.sprite_frames = frames
		ingredient_sprite.frame = 0
