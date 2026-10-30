extends Node2D

@onready var coins: Label = $Coins
@onready var stamina: Label = $Stamina

@onready var cave: TextureButton = $Cave
@onready var factory: TextureButton = $Factory
@onready var forest: TextureButton = $Forest

@onready var back: TextureButton = $Back

@onready var cave_complete: Sprite2D = $CaveComplete
@onready var factory_complete: Sprite2D = $FactoryComplete

@export var level_select_music: AudioStream 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coins.text = "Coins: " + str(Global.current_coins)
	stamina.text = "Stamina: " + str(Global.stamina) + "/1000"
	if Global.scene_1_cleared:
		cave_complete.show()
		factory.show()
	if Global.scene_2_cleared:
		factory_complete.show()
		forest.show()
	Audio.play_track(level_select_music)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func hover(sprite: TextureButton) -> void:
	sprite.scale.x += .1
	sprite.scale.y += .1

func unhover(sprite: TextureButton) -> void:
	sprite.scale.x -= .1
	sprite.scale.y -= .1


func _on_cave_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 1/Scene_1.tscn")

func _on_cave_mouse_entered() -> void:
	hover(cave)

func _on_cave_mouse_exited() -> void:
	unhover(cave)
	

func _on_factory_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 2/scene_2.tscn")

func _on_factory_mouse_entered() -> void:
	hover(factory)

func _on_factory_mouse_exited() -> void:
	unhover(factory)


func _on_forest_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Scene 3/scene_3.tscn")

func _on_forest_mouse_entered() -> void:
	hover(forest)

func _on_forest_mouse_exited() -> void:
	unhover(forest)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Main Menu/start_menu.tscn")

func _on_back_mouse_entered() -> void:
	hover(back)

func _on_back_mouse_exited() -> void:
	unhover(back)


func _on_button_pressed() -> void:
	Global.stamina = 1000
	stamina.text = "Stamina: " + str(Global.stamina) + "/1000"
