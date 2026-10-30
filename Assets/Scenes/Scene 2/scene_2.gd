extends Node2D

var player_pos_x = -29
var player_pos_y = -32
var enemy_pos_x = -250
var enemy_pos_y = -400

@onready var player: Player = $Player
@onready var checkpoint_1: Area2D = $"Checkpoints/Checkpoint 1"
@onready var checkpoint_2: Area2D = $"Checkpoints/Checkpoint 2"
@onready var enemy = $Enemy

@export var level_2_music: AudioStream 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_pos()
	Audio.play_track(level_2_music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_player_pos() -> void:
	player.position.x = player_pos_x
	player.position.y = player_pos_y
	
func update_enemy_pos() -> void:
	enemy.position.x = enemy_pos_x
	enemy.position.y = enemy_pos_y
	if player.has_method("reset_physics"):
		player.velocity = Vector2.ZERO

func _on_death_plane_entered(body: Node2D) -> void:
		if body == player:
			update_player_pos()
		elif body == enemy:
			update_enemy_pos()


func _on_checkpoint_1_body_entered(body: Node2D) -> void:
	if body is Player:
		player_pos_x = checkpoint_1.position.x
		player_pos_y = checkpoint_1.position.y
		#checkpoint_1.queue_free()
	elif body == enemy:
		enemy_pos_x = checkpoint_1.position.x
		enemy_pos_y = checkpoint_1.position.y

func _on_checkpoint_2_body_entered(body: Node2D) -> void:
	if body is Player:
		player_pos_x = checkpoint_2.position.x
		player_pos_y = checkpoint_2.position.y
		#checkpoint_2.queue_free()
	elif body == enemy:
		enemy_pos_x = checkpoint_2.position.x
		enemy_pos_y = checkpoint_2.position.y
