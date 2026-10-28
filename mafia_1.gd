extends CharacterBody2D
@onready var target = $"../Player"
@onready var animated_sprite_2d = $DirectionFlip/AnimatedSprite2D
@onready var ground_detector = $DirectionFlip/GroundDetector
@onready var wall_detector = $DirectionFlip/WallDetector
@onready var orientation = $DirectionFlip

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction_x = 0.0
var chasing = true
var attacking = false
var jumping = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumping = false

	if chasing:
		animated_sprite_2d.play("run")
		direction_x = sign(target.global_position.x - global_position.x)
		velocity.x = (direction_x * SPEED)/3
		if direction_x != 0:
			#animated_sprite_2d.flip_h = direction_x < 0
			orientation.scale.x = direction_x
		if (not ground_detector.has_overlapping_bodies() or wall_detector.has_overlapping_bodies()) and not jumping:
			jumping = true
			jump()
	elif attacking:
		attack()
	else:
		if not attacking:
			animated_sprite_2d.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()



func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	print("entered area2d")
	if body == target:
		print("player entered enemy area")
		chasing = false
		attacking = true


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if body == target:
		attacking = false
		chasing = true
		$AttackTimer.stop()


func _on_attack_timer_timeout() -> void:
	if attacking:
		attack()
	
func attack():
	if not attacking:
		return
	animated_sprite_2d.play("attack")
	Global.stamina -= 5
	$AttackTimer.start()
	
func jump():
	print("jumping")
	if not jumping:
		return
	velocity.y = JUMP_VELOCITY * 2
	animated_sprite_2d.play("jump")
