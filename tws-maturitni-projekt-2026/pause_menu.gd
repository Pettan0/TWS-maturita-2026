extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options
@onready var player: CharacterBody3D = $"../.."



var pause = false

func _ready() -> void:
	main_buttons.visible = true
	options.visible = false	

func _on_unpuase_pressed() -> void:
	player._pauseMenu()
	
func _on_settings_pressed() -> void:
	main_buttons.visible = false
	options.visible = true

func _on_back_pressed() -> void:
	_ready()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Main menu.tscn")
