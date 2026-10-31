extends Control

@onready var coins: Label = $Coins
@onready var stamina: TextureProgressBar = $Stamina
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	coins.text = "Coins: " + str(Global.current_coins)
	stamina.value = Global.stamina
