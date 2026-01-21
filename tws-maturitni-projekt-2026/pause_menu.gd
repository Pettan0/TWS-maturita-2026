extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options
@onready var pause_menu: Control = $PauseMenu


var pause = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_pauseMenu()
	
func _pauseMenu():
	if pause:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	pause = !pause

func _ready() -> void:
	main_buttons.visible = true
	options.visible = false	

func _on_unpuase_pressed() -> void:
	_pauseMenu()
	
func _on_settings_pressed() -> void:
	main_buttons.visible = false
	options.visible = true

func _on_back_pressed() -> void:
	_ready()


func _on_menu_pressed() -> void:
	pass # Replace with function body.
