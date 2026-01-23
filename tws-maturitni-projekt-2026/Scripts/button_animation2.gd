extends Button


func _ready() -> void:
	mouse_entered.connect(_button_enter)
	mouse_exited.connect(_button_exit)

func _button_enter():
	create_tween().tween_property(self, "offset_right",(offset_right + 60), 0.1).set_trans(Tween.TRANS_SINE)
	
func _button_exit():
	create_tween().tween_property(self, "offset_right", (217), 0.1).set_trans(Tween.TRANS_SINE)
