extends Node2D

@onready var coins: Label = $Coins
@onready var stamina: Label = $Stamina
@onready var cave: TextureButton = $Cave
@onready var factory: TextureButton = $Factory
@onready var back: TextureButton = $Back
@onready var cave_complete: Sprite2D = $CaveComplete
@onready var factory_complete: Sprite2D = $FactoryComplete


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins.text = "Coins: " + str(Global.current_coins)
	stamina.text = "Stamina: " + str(Global.stamina) + "/1000"
	if Global.scene_1_cleared:
		cave_complete.show()
		factory.show()
	if Global.scene_2_cleared:
		factory_complete.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cave_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 1/Scene_1.tscn")


func _on_factory_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 2/scene_2.tscn")
	
	
func hover(sprite: TextureButton) -> void:
	sprite.scale.x += .1
	sprite.scale.y += .1
	
func unhover(sprite: TextureButton) -> void:
	sprite.scale.x -= .1
	sprite.scale.y -= .1
	

func _on_cave_mouse_entered() -> void:
	hover(cave)
	
func _on_cave_mouse_exited() -> void:
	unhover(cave)
	

func _on_factory_mouse_entered() -> void:
	hover(factory)

func _on_factory_mouse_exited() -> void:
	unhover(factory)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Main Menu/start_menu.tscn")
	
func _on_back_mouse_entered() -> void:
	hover(back)

func _on_back_mouse_exited() -> void:
	unhover(back)
