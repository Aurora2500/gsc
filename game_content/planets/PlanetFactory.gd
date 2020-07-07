extends Node

class_name PlanetFactory

var count: int = 0

func _ready():
	pass

func new_planet():
	var new_planet = Planet.new()
	new_planet.id = count
	count += 1
	return new_planet
