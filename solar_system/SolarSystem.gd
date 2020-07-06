extends Node2D

class_name SolarSystem

var id: int

# key: other solar system; value: the link between them
var links = {}

func _init():
	z_index = 1

func _ready():
	pass

func linked_with(other):
	return links.has(other)

func link_to(others, link_scene):
	for target in others:
		var link_obj = link_scene.instance()
		target.add_child(link_obj)
		link_obj.setup_positions(self.position, target.position)
		links[target] = link_obj
		target.links[self] = link_obj

func save():
	
	var linked_system_ids = []
	for ss in links:
		linked_system_ids.append(ss.id)
	
	var save_dict = {
		id = id,
		position = [position.x, position.y],
		linked_system_ids = linked_system_ids
	}
	return save_dict

func load_save(savedata):
	id = savedata.id
	position = Vector2(savedata.position[0], savedata.position[1])
	var to_link_with = []
	var list_of_lesser_ss = get_parent().solar_systems
	# make sure it's not empty first
	while (not savedata.linked_system_ids.empty()) \
	and savedata.linked_system_ids.front() < id:
		to_link_with.append(list_of_lesser_ss[savedata.linked_system_ids.pop_front()])
	link_to(to_link_with, get_parent().link_scene)
