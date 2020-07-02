extends Node

const galaxy_scene = preload("res://galaxy/Galaxy.tscn")
var current_galaxy

func _ready():
	current_galaxy = galaxy_scene.instance()
	add_child(current_galaxy)
	current_galaxy.generate_galaxy()
