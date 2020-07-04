extends Panel

signal CloseSaveMenu
const ListItem = preload("res://user_interface/scenes/ListItem.tscn")

func _input(event):
	if event.is_action_pressed("pause"):
		_on_CancelButton_pressed()


func _on_CancelButton_pressed():
	get_node("SaveNameInput").text = ""
	emit_signal("CloseSaveMenu")


func _on_NewSaveButton_pressed():
	var new_save_name = get_node("SaveNameInput").text
	if new_save_name != "":
		var new_save = ListItem.instance()
		new_save.text = "  " + new_save_name
		new_save.rect_min_size = Vector2(310, 35)
		$ScrollContainer/VBoxContainer.add_child(new_save)


func _on_OverwriteSaveButton_pressed():
	var confirm = load("res://user_interface/scenes/ConfirmPopup.tscn").instance()
	confirm.get_node("Label").text = "Are you sure you want\nto overwrite this save?"
	add_child(confirm)
	get_node("ConfirmPopup").connect("CloseConfirmPopup", self, "CloseConfirmPopup")
	

func CloseConfirmPopup():
	get_node("ConfirmPopup").queue_free()
	
