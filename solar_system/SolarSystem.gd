extends Node2D

class_name SolarSystem



var linked_systems = []

func _ready():
	pass

func linked_with(other):
	return other in linked_systems

func link_to(others, link_scene):
	var links = []
	for target in others:
		linked_systems.append(target)
		target.linked_systems.append(self)
		var link_obj = link_scene.instance()
		target.add_child(link_obj)
		link_obj.setup_positions(self.position, target.position)
		links.append(link_obj)
	return links
