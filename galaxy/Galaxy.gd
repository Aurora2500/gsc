extends Node2D

export var number_of_stars = 100
export var min_radius = 200
export var max_radius = 1500

var solar_system = preload("res://solar_system/SolarSystem.tscn")

func _ready():
	generate_galaxy()

func generate_galaxy():
	for _i in range(number_of_stars):
		var dist = rand_range(min_radius, max_radius)
		var rot = rand_range(0.0, TAU)
		var coord = Vector2(
			dist * cos(rot),
			dist * sin(rot)
		)
		var current_star = solar_system.instance()
		add_child(current_star)
		current_star.position = coord
