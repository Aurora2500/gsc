extends Node2D

class_name SolarSystem

const solar_system_scene = preload("res://solar_system/SolarSystem.tscn")

# link : linked ss
var links = {}
var id: int

func _ready():
	pass

func linked_with(other):
	return other in links.keys()

func link_to_group(others, link_scene):
	var links = []
	for target in others:
		links.append(link_to(target, link_scene))
	return links

func link_to(target, link_scene):
	var link_obj = link_scene.instance()
	target.add_child(link_obj)
	link_obj.setup_positions(self.position, target.position)
	
	# add to links on both
	links[link_obj] = target
	target.links[link_obj] = self
	
	return link_obj

func save():
	var linked_systems_save = []
	for ls in links.keys():
		linked_systems_save.append(ls.id)
	var save_dict = {
		"id": id,
		"position": [position.x, position.y],
		"links": linked_systems_save
	}
	return save_dict

static func load_save(savedata, solar_systems, link_scene):
	
	var loaded_solar_system = solar_system_scene.instance()
	
	# id
	loaded_solar_system.id = savedata.id
	
	# position
	loaded_solar_system.position = Vector2(
		savedata.position.x,
		savedata.position.y
	)
	
	# links
	for ls_id in savedata.links:
		if ls_id < savedata.id:
			loaded_solar_system.link_to(solar_systems[ls_id])
	
	return loaded_solar_system
