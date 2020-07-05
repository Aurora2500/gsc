extends Node2D

var rng = RandomNumberGenerator.new()

export var number_of_stars = 120
export var min_radius = 500
export var max_radius = 1500
export var star_separation = 100
# since it only needs to compare, it is more optimized to use squared
onready var star_sep_squared = star_separation*star_separation
export var tries = 200

export var link_distance = 300
onready var link_distance_squared = link_distance*link_distance

var solar_system_scene = preload("res://solar_system/SolarSystem.tscn")
var link_scene = preload("res://star_link/StarLink.tscn")
var solar_systems = []

func _ready():
	rng.randomize()

func generate_galaxy():
	for i in range(number_of_stars):
		# generate the coordinate for the solar system
		var is_coliding = true
		var coord
		var tries_as_far = 0
		while is_coliding and tries_as_far < tries:
			tries_as_far += 1
			
			var dist = rng.randf_range(min_radius, max_radius)
			var rot = rng.randf_range(0.0, TAU)
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
		current_star.z_index = 1
		current_star.id = i
		current_star.link_to(linkable_systems(current_star), link_scene)

func linkable_systems(target:Node2D):
	var linkable_systems_array = []
	for other in solar_systems:
		
		var can_connect = true
		
		if other == target:
			continue
		if link_distance_squared < target.position.distance_squared_to(other.position):
			continue
		for intersect_1 in solar_systems:
			if other == intersect_1:
				continue
			for intersect_2 in intersect_1.links:
				if doIntersect(
					target.position,
					other.position,
					intersect_1.position,
					intersect_2.position
				):
					can_connect = false
		if can_connect:
			linkable_systems_array.append(other)
	return linkable_systems_array

func doIntersect(p1: Vector2, q1: Vector2, p2: Vector2, q2: Vector2) -> bool:
	# p1-q1 is one segment and p2-q2 is another
	# check if they intersect.
	var o1 = orientation(p1, q1, p2) 
	var o2 = orientation(p1, q1, q2) 
	var o3 = orientation(p2, q2, p1) 
	var o4 = orientation(p2, q2, q1)
	return ((o1 != o2) and (o3 != o4))

enum {CLOCKWISE, COUNTERCLOCKWISE}
func orientation(p: Vector2, q: Vector2, r: Vector2):
	var val = (q.y-p.y)*(r.x-q.x) - (q.x-p.x)*(r.y-q.y)
	if val > 0:
		return CLOCKWISE
	return COUNTERCLOCKWISE

func save():
	var ss_saves = []
	for ss in solar_systems:
		ss_saves.append(ss.save())
	var save_dict = {
		solar_systems = ss_saves
	}
	return save_dict

func load_save(savedata):
	for ss_savedata in savedata.solar_systems:
		load_solar_system_save(ss_savedata)

func load_solar_system_save(savedata):
	var current_star = solar_system_scene.instance()
	add_child(current_star)
	solar_systems.append(current_star)
	current_star.load_save(savedata)
