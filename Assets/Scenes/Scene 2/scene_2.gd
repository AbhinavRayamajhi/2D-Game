extends Node2D

var player_pos_x = -29
var player_pos_y = -32

@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_pos()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_player_pos() -> void:
	player.position.x = player_pos_x
	player.position.y = player_pos_y

func _on_death_plane_entered(body: Node2D) -> void:
	update_player_pos()
