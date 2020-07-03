extends Node

class_name Pathfinder

func _ready():
	pass

func bfs(from: SolarSystem, dest: SolarSystem):
	var size = get_node("../Galaxy").solar_systems.size()
	var queue = [from]
	var already_looked = []
	var paths = []
	already_looked.resize(size)
	paths.resize(size)
	for i in range(size):
		already_looked[i] = false
		paths[i] = null
	already_looked[from.id] = true
	paths[from.id] = from
	var current = from
	while(current != dest and not queue.empty()):
		current = queue.pop_front()
		already_looked[current.id] = true
		for other_ss in current.links.keys():
			if !already_looked[other_ss.id]:
				paths[other_ss.id] = current
				queue.append(other_ss)
	if paths[dest.id] != null:
		var final_path = [dest]
		var previous = dest
		while(paths[previous.id] != from):
			final_path.push_front(paths[previous.id])
			previous = paths[previous.id]
		return final_path	
	return null

func bfs_from_id(from:int, dest:int):
	var objfrom = get_node("../Galaxy").solar_systems[from]
	var objdest = get_node("../Galaxy").solar_systems[dest]
	var path = bfs(objfrom, objdest)
	if path == null:
		return null
	var idpath = []
	for x in path:
		idpath.append(x.id)
	return idpath
