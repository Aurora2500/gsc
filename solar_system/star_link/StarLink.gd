extends Line2D


func _ready():
	pass

func setup_positions(start: Vector2, end: Vector2):
	position = Vector2.ZERO
	clear_points()
	add_point(Vector2.ZERO)
	add_point(start - end)
	z_as_relative = false
