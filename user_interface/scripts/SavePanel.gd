extends Panel

signal CloseSaveMenu
var saves = []
var current_selection = -1
var current_action = -1
enum actions {SAVE, DELETE}


func _ready():
	refresh_saves()


func _input(event):
	if event.is_action_pressed("pause"):
		_on_CancelButton_pressed()


func refresh_saves():
	while $ItemList.get_item_count() > 0:
		$ItemList.remove_item(0)
	for save_name in saves:
		$ItemList.add_item(save_name)


func add_new_save(save_name):
	saves.append(save_name)
	refresh_saves()

func delete_save(index):
	$ItemList.remove_item(index)
	saves.remove(index)

func load_save():
	pass
	
func overwrite_save():
	pass

func _on_CancelButton_pressed():
	get_node("SaveNameInput").text = ""
	emit_signal("CloseSaveMenu")


func _on_NewSaveButton_pressed():
	var new_save_name = get_node("SaveNameInput").text
	if new_save_name != "":
		add_new_save(new_save_name)


func _on_OverwriteSaveButton_pressed():
	current_action = actions.SAVE
	if current_selection > -1:
		get_parent().confirmation_popup("Are you sure you want to overwrite this save?", self)
			
	
func _on_DeleteButton_pressed():
	current_action = actions.DELETE
	if current_selection > -1:
		get_parent().confirmation_popup("Are you sure you want to delete this save?", self)
		

func handle_confirm():
	if current_action == actions.DELETE:
		delete_save(current_selection)
	get_parent().close_confirm_popup()


func _on_ItemList_item_selected(index):
	current_selection = index

