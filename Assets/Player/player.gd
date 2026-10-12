extends AnimatedSprite2D

@export var moveSpeed = 1
@export var jumpHeight = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not Input.is_anything_pressed():
		play("idle")
		
	if Input.is_action_pressed("left"):
		play("walk")
		flip_h = true
		position.x -= moveSpeed
		
	if Input.is_action_pressed("right"):
		play("walk")
		flip_h = false
		position.x += moveSpeed
