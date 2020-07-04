extends CanvasLayer

var SecondaryWindowOpen = false

func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pause") and not SecondaryWindowOpen:
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		get_node("PauseMenu").visible = new_pause_state


func _on_ResumeButton_pressed():
	get_node("PauseMenu").hide()
	get_tree().paused = false


func _on_SaveButton_pressed():
	SecondaryWindowOpen = true
	var save_menu = load("res://user_interface/scenes/SaveScreen.tscn").instance()
	add_child(save_menu)
	get_node("SaveMenu").connect("CloseSaveMenu", self, "close_save_menu")
	
func close_save_menu():
	get_node("SaveMenu").queue_free()
	SecondaryWindowOpen = false


func confirmation_popup(input_text, source):
	var confirm = load("res://user_interface/scenes/ConfirmPopup.tscn").instance()
	confirm.get_node("Label").text = input_text
	add_child(confirm)
	get_node("ConfirmPopup").connect("Cancel", self, "close_confirm_popup")
	get_node("ConfirmPopup").connect("Confirm", source, "handle_confirm")
	

func close_confirm_popup():
	get_node("ConfirmPopup").queue_free()
