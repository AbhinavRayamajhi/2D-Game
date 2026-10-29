extends Node2D

var player_pos_x = -29
var player_pos_y = -32

@onready var player: Player = $Player
@onready var checkpoint_1: Area2D = $"Checkpoints/Checkpoint 1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_player_pos() -> void:
	player.position.x = player_pos_x
	player.position.y = player_pos_y
	
func _on_death_plane_entered(body: Node2D) -> void:
	if body is Player:
		update_player_pos()


func _on_checkpoint_1_body_entered(body: Node2D) -> void:
	if body is Player:
		player_pos_x = checkpoint_1.position.x
		player_pos_y = checkpoint_1.position.y
