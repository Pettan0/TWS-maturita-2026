extends Control

@onready var player: CharacterBody3D = $"../../.."
@onready var settings: Control = $Settings



var pause = false

func _ready() -> void:
	settings.hide()
	
func _on_unpuase_pressed() -> void:
	player._pauseMenu()
	
func _settings_show() -> void:
	settings.show()
	
	
func _on_back_pressed() -> void:
	_ready()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceens/Main menu.tscn")
