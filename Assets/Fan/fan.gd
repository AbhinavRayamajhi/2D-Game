extends Node2D
@onready var enemy = $"../../Enemy"
@onready var area = $Area2D
var FAN_SPEED = -600
var FAN_ACCEL = 2000.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for body in area.get_overlapping_bodies():
		if body is Player or body == enemy:
			body.velocity.y = FAN_SPEED
			if body == enemy:
				body.fan_grace = 0.1

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body is Player or body == enemy:
		#body.velocity.y = FAN_SPEED
