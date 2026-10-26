extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BOOST_SPEED = 800.0
const BOOST_DURATION = 0.3
const BOOST_COOLDOWN = 1.3

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var boost_timer: Timer = $BoostTimer
@onready var boost_cooldown: Timer = $BoostCooldown

var is_jumping = false
var is_boosting = false
var is_boost_cooldown = false
var facing_direction = 1.0

func _ready() -> void:
	
	boost_timer.timeout.connect(stop_boost)
	boost_cooldown.timeout.connect(boost_cooldown_reset)

func _physics_process(delta: float) -> void:
	# Add the gravity. No gravity on boost
	if not is_on_floor() and not is_boosting:
		velocity += get_gravity() * delta
	else:
		is_jumping = false #if on floor not jumping
	
	# No movement allowed if no stamina
	# Need to add a game over thing
	if Global.stamina <= 0:
		animated_sprite_2d.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
		return
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	
	if direction and not is_boosting:
		facing_direction = direction
	
	if is_boosting:
		velocity.x = facing_direction * BOOST_SPEED
		velocity.y = 0 # No up down movement during boost
		animated_sprite_2d.play("boost")
	else:
		if direction:
			Global.stamina -= 1
			velocity.x = direction * SPEED
			animated_sprite_2d.flip_h = direction < 0
				
			if not is_jumping :
				animated_sprite_2d.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
			if not is_jumping:
				animated_sprite_2d.play("idle")
			
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Global.stamina -= 2
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		animated_sprite_2d.play("jump")
	
	# Handle boost
	if Input.is_action_just_pressed("boost") and not is_boosting and not is_boost_cooldown:
		start_boost()
		
	move_and_slide()

func start_boost() -> void:
	Global.stamina -= 4
	is_boosting = true
	is_boost_cooldown = true
	boost_timer.start(BOOST_DURATION)
	boost_cooldown.start(BOOST_COOLDOWN)

func stop_boost() -> void:
	is_boosting = false
	velocity.x = move_toward(velocity.x, 0, SPEED)
	
func boost_cooldown_reset() -> void:
	is_boost_cooldown = false
