extends HSlider

@export var audio_bus_name: String

var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)

func _on_value_changed(value: float) -> void:
	var  db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)


func _on_unpuase_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	pass # Replace with function body.
