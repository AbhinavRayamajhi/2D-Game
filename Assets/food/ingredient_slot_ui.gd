extends Panel

@onready var ingredient_visual: Area2D = $CenterContainer/food_display
@onready var ingredient_sprite: AnimatedSprite2D = $CenterContainer/food_display/Sprite2D
@onready var quantity : Label = $Quantity

func update(ingredients: item):
	if ingredients == null:
		ingredient_visual.visible = false
		quantity.text = ""
	else:
		ingredient_visual.visible = true

		var frames = SpriteFrames.new()
		frames.add_frame("default", ingredients.icon)
		ingredient_sprite.sprite_frames = frames
		ingredient_sprite.frame = 0

		quantity.text = str(Global.inventory.get(ingredients.title, 0))
