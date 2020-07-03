extends Panel

signal CloseSaveMenu

func _input(event):
	if event.is_action_pressed("pause"):
		_on_CancelButton_pressed()


func _on_CancelButton_pressed():
	get_node("SaveNameInput").text = ""
	emit_signal("CloseSaveMenu")


func _on_ConfirmSaveButton_pressed():
	get_node("SaveNameInput").text = ""
	emit_signal("CloseSaveMenu")
