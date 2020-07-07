extends Node2D

class_name Galaxy

var solar_systems = []

func save():
	var ss_saves := []
	for ss in solar_systems:
		ss_saves.append(ss.save())
	var save_dict := {
		solar_systems = ss_saves
	}
	return save_dict


