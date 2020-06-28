extends Camera2D

# how far away the camera can move from the origin
export var x_size = 2000
export var y_size = 2000

export var max_zoom = 4.0
export var min_zoom = 0.4

export var zoom_sensitivity = 1.2

var mouse_button_down: bool = false

# keep track of where dragging the camera started
var origin_camera_pos: Vector2
var origin_mouse_pos: Vector2

# keep track of the zoom
var current_zoom: float = 1 

func _ready():
	print("oke")

func _input(event):
	### Dragging events
	if event is InputEventMouseButton:
		# start of button press
		if event.button_index == BUTTON_LEFT and event.pressed:
			mouse_button_down = true
			origin_camera_pos = position
			origin_mouse_pos = event.position
		# end of button press
		if mouse_button_down and !event.pressed:
			mouse_button_down = false
	
	# dragging
	if event is InputEventMouseMotion and mouse_button_down:
		# set the position to the original one plus the difference
		var difference = (origin_mouse_pos - event.position) * current_zoom
		var new_pos = origin_camera_pos + difference
		var clamped_pos = Vector2(
			clamp(new_pos.x, -x_size, x_size),
			clamp(new_pos.y, -y_size, y_size)
		)
		position = clamped_pos
	
	### Zooming events
	if event is InputEventMouseButton:
		# zoom in
		if event.button_index == BUTTON_WHEEL_UP:
			current_zoom /= zoom_sensitivity
			
		if event.button_index == BUTTON_WHEEL_DOWN:
			current_zoom *= zoom_sensitivity
			
		current_zoom = clamp(current_zoom, min_zoom, max_zoom)
		zoom = Vector2(current_zoom, current_zoom)
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
