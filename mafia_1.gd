extends CharacterBody2D
@onready var target = $"../Player"
@onready var animated_sprite_2d = $DirectionFlip/AnimatedSprite2D
@onready var ground_detector = $DirectionFlip/GroundDetector
@onready var wall_detector = $DirectionFlip/WallDetector
@onready var orientation = $DirectionFlip

const SPEED = 200.0
const DASH_SPEED = 600.0
const JUMP_VELOCITY = -400.0
const WORLD_MASK = 1
const SCAN_STEP = 16
const MAX_SCAN = 600
enum JumpType { NONE, NORMAL, DOUBLE, DASH }
var direction_x = 0.0
var chasing = true
var attacking = false
var jumping = false
var jump_type = JumpType.NONE
var air_jump_used = false #if already double jumped
var dash_timer = 0.0 #amount of time left in dash speed


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumping = false
		jump_type = JumpType.NONE
		air_jump_used = false
		dash_timer = 0.0

	if chasing:
		animated_sprite_2d.play("run")
		direction_x = sign(target.global_position.x - global_position.x)
		velocity.x = (direction_x * SPEED)
		if direction_x != 0: #flip sprite + detectors
			orientation.scale.x = direction_x
		if dash_timer > 0.0: #if time in dash jump still remains, reduce it and apply the speed
			dash_timer -= delta
			velocity.x = direction_x * DASH_SPEED
		else: #move at regular speed
			velocity.x = direction_x * SPEED
		var hit_wall = wall_detector.is_colliding()
		var near_gap = not ground_detector.is_colliding()
		if is_on_floor() and not jumping:
			if hit_wall:
				jump(JumpType.NORMAL)
			elif near_gap:
				jump(choose_jump_for_gap())
		#if using double jump on 1st try and at apex of jump then jump again
		if jump_type == JumpType.DOUBLE and not air_jump_used and not is_on_floor() and velocity.y > 0:
			air_jump_used = true
			velocity.y = JUMP_VELOCITY
			
		#if (not ground_detector.has_overlapping_bodies() or wall_detector.has_overlapping_bodies()) and not jumping:
			#jumping = true
			#jump()
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
		attack()


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
	Global.stamina -= 20
	$AttackTimer.start()

func jump_air_time() -> float:
	return 2.0 * (abs(JUMP_VELOCITY) / get_gravity().y)

	
func choose_jump_for_gap() -> int:
	var gap = measure_gap()
	var normal_range = SPEED * jump_air_time()
	var double_range = normal_range * 1.7
	if gap <= normal_range:
		return JumpType.NORMAL
	elif gap <= double_range:
		return JumpType.DOUBLE
	else:
		return JumpType.DASH
	
func measure_gap() -> float:
	var space = get_world_2d().direct_space_state
	var x = SCAN_STEP
	while x <= MAX_SCAN:
		var from = global_position + Vector2(direction_x * x, -10)
		var to = from + Vector2(0, 450)
		var query = PhysicsRayQueryParameters2D.create(from, to, WORLD_MASK)
		query.exclude = [get_rid()] #don't count the enemy body
		#check if something intersects with the ray labeled query
		#if it does, that means there is space to land
		if not space.intersect_ray(query).is_empty():
			return x
		x += SCAN_STEP
	return MAX_SCAN
	
	
func jump(type: int) -> void:
	jumping = true
	velocity.y = JUMP_VELOCITY
	if type == JumpType.DASH:
		dash_timer = jump_air_time()
	animated_sprite_2d.play("jump")
