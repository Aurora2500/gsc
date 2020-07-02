extends Panel

func _input(event):
	if event.is_action_pressed("pause") and visible == true:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state


func _on_SaveButton_pressed():
	visible = true
	get_child(0).text = ""


func _on_CancelButton_pressed():
	visible = false


func _on_ConfirmSaveButton_pressed():
	visible = false
