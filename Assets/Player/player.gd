extends AnimatedSprite2D

@export var moveSpeed = 1
@export var jumpHeight = 0 # set to 0 cuz need gravity otherwise player doesn't come back down

var is_jumping = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
	if Input.is_action_pressed("left"):
		flip_h = true
		position.x -= moveSpeed
		if not is_jumping:
			play("walk")
		
	elif Input.is_action_pressed("right"):
		flip_h = false
		position.x += moveSpeed
		if not is_jumping:
			play("walk")
		
	else:
		if not is_jumping:
			play("idle")
		
	if Input.is_action_just_pressed("jump") and not is_jumping:
		is_jumping = true
		play("jump")
		position.y -= jumpHeight
		await animation_finished
		is_jumping = false
