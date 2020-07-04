extends Panel

signal CloseConfirmPopup


func _on_YesButton_pressed():
	emit_signal("CloseConfirmPopup")

func _on_CancelButton_pressed():
	emit_signal("CloseConfirmPopup")
