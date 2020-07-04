extends Panel

signal Cancel
signal Confirm


func _on_YesButton_pressed():
	emit_signal("Confirm")

func _on_CancelButton_pressed():
	emit_signal("Cancel")
