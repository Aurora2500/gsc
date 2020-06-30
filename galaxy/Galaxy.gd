extends Node2D

export var number_of_stars = 100
export var min_radius = 200
export var max_radius = 1500
export var star_separation = 100
# since it only needs to compare, it is more optimized to use squared
onready var star_sep_squared = star_separation*star_separation
export var tries = 200

var solar_system_scene = preload("res://solar_system/SolarSystem.tscn")
var solar_systems = []

func _ready():
	generate_galaxy()

func generate_galaxy():
	for _i in range(number_of_stars):
		# generate the coordinate for the solar system
		var is_coliding = true
		var coord
		var tries_as_far = 0
		while is_coliding and tries_as_far < tries:
			tries_as_far += 1
			
			var dist = rand_range(min_radius, max_radius)
			var rot = rand_range(0.0, TAU)
			coord = Vector2(
				dist * cos(rot),
				dist * sin(rot)
			)
			# supose there are no colisions
			is_coliding = false
			for other_star in solar_systems:
				if star_sep_squared > coord.distance_squared_to(other_star.position):
					is_coliding = true
					break
		
		if tries_as_far >= tries:
			break
		
		var current_star = solar_system_scene.instance()
		add_child(current_star)
		solar_systems.append(current_star)
		current_star.position = coord
