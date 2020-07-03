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
	var save_menu = load("res://user_interface/SaveScreen.tscn").instance()
	add_child(save_menu)
	get_node("SaveMenu").connect("CloseSaveMenu", self, "CloseSaveMenu")
	
func CloseSaveMenu():
	get_node("SaveMenu").queue_free()
	SecondaryWindowOpen = false
