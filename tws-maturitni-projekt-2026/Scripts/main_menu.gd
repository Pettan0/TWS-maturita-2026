extends Control

@onready var settings: Control = $Settings

func _ready() -> void:
	settings.hide()
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level1.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_pressed() -> void:
	_ready()

func _settings_show() -> void:	
	settings.show()
