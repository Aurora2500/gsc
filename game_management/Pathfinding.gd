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

func bfs_from_id(from: int, dest: int):
	var objfrom = get_node("../Galaxy").solar_systems[from]
	var objdest = get_node("../Galaxy").solar_systems[dest]
	var path = bfs(objfrom, objdest)
	if path == null:
		return null
	var idpath = []
	for x in path:
		idpath.append(x.id)
	return idpath

func dijkstras(from: SolarSystem, dest:SolarSystem):
	var solar_systems = get_node("../Galaxy").solar_systems
	var size = solar_systems.size()
	var pq = priority_queue.new(size)
	var dist = []
	var prev = []
	dist.resize(size)
	prev.resize(size)
	dist[from.id] = 0
	for ss in solar_systems:
		if ss != from:
			dist[ss.id] = INF
		pq.push(ss, dist[ss.id])
	
	var searching: bool = true
	while searching:
		var current = pq.pop().object
		for other_ss in current.links:
			var new_dist = dist[current.id] + current.links[other_ss].distance()
			if new_dist < dist[other_ss.id]:
				dist[other_ss.id] = new_dist
				prev[other_ss.id] = current
				pq.update(other_ss.id, new_dist)
		searching = pq.non_empty() and dist[dest.id] > pq.peek().distance
	if prev[dest.id] == null:
		return null
	
	var final_path = [dest]
	var prev_ss = dest
	while prev[prev_ss.id] != from:
		final_path.push_front(prev[prev_ss.id])
		prev_ss = prev[prev_ss.id]
	return final_path

func dijkstras_from_id(from: int,dest: int):
	var objfrom = get_node("../Galaxy").solar_systems[from]
	var objdest = get_node("../Galaxy").solar_systems[dest]
	var path = dijkstras(objfrom, objdest)
	if path == null:
		return null
	var idpath = []
	for x in path:
		idpath.append(x.id)
	return idpath

class priority_queue:
	var heap_arr
	var obj_pos
	var size: int = 0
	
	func _init(maxsize: int):
		heap_arr = []
		obj_pos = []
		obj_pos.resize(maxsize)
		heap_arr.resize(maxsize)
	
	func has_parent(pos:int):
		return parent(pos) >= 0
	func parent(pos:int):
# warning-ignore:integer_division
		return (pos-1)/2
	
	func has_left_child(pos:int):
		return left_child(pos) < size
	func left_child(pos:int):
		return (2*pos) + 1
	
	func has_right_child(pos:int):
		return right_child(pos) < size
	func right_child(pos: int):
		return (2*pos)+ 2
	
	func non_empty():
		return size > 0
	
	func pos_cost(pos:int):
		return heap_arr[pos].distance
	func parent_cost(pos:int):
		return pos_cost(parent(pos))
	func left_child_cost(pos:int):
		return pos_cost(left_child(pos))
	func right_child_cost(pos:int):
		return pos_cost(right_child(pos))
	
	func swap(first: int, second: int):
		var tmp = heap_arr[first]
		heap_arr[first] = heap_arr[second]
		heap_arr[second] = tmp
		obj_pos[tmp.object.id] = second
		obj_pos[heap_arr[first].object.id] = first
	
	func heapify_up():
		var  pos = size - 1
		while(has_parent(pos) and parent_cost(pos) > pos_cost(pos)):
			swap(parent(pos), pos)
			pos = parent(pos)
		
	func heapify_down():
		var pos = 0
		while has_left_child(pos):
			var child_pos = left_child(pos)
			if has_right_child(pos) and right_child_cost(pos) < left_child_cost(pos):
				child_pos = right_child(pos)
			if pos_cost(pos) < pos_cost(child_pos):
				break
			swap(pos, child_pos)
			pos = child_pos
	
	func heapify_from(pos: int):
		while has_parent(pos) and parent_cost(pos) > pos_cost(pos):
			swap(pos, parent(pos))
			pos = parent(pos)
	
	func push(object, distance):
		var node = heap_node.new(object, distance)
		heap_arr[size] = node
		obj_pos[object.id] = size
		size += 1
		heapify_up()
	
	func update(obj_id: int, new_distance: float):
		var pos = obj_pos[obj_id]
		if pos == null: return
		heap_arr[pos].distance = new_distance
		heapify_from(pos)
	
	func peek():
		return heap_arr[0]
	
	func pop():
		var return_item = peek()
		obj_pos[return_item.object.id] = null
		size -= 1
		heap_arr[0] = heap_arr[size]
		obj_pos[heap_arr[0].object.id] = 0
		heapify_down()
		return return_item
	
	class heap_node:
		var object
		var distance: float
		
		func _init(obj, dist: float):
			object = obj
			distance = dist
