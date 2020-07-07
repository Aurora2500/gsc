extends Node

var current_galaxy: Galaxy
var galaxy_factory: GalaxyFactory

var pathfinder

func _ready():
	# galaxy
	galaxy_factory = GalaxyFactory.new()
	current_galaxy = galaxy_factory.get_galaxy()
	galaxy_factory.generate_galaxy(current_galaxy)
	add_child(current_galaxy)
	galaxy_factory.generate_galaxy(current_galaxy)
	
	# PathFinder
	pathfinder = Pathfinder.new()
	add_child(pathfinder)

func save():
	return current_galaxy.save()

func load_save(savedata):
	# delete current galaxy
	current_galaxy.queue_free()
	
	# load
	current_galaxy = galaxy_factory.load_save(savedata)
	add_child(current_galaxy)
