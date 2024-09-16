class_name scene_manager extends Node

var player: Player
var last_scene_name: String

var scene_dir_path = "res://scenes/"

func change_scene(from, to_scene_name: String) -> void:
	last_scene_name = from.name
	
	player = from.player
	player.get_parent().remove_child(player)
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	ScreenTransition.change_scene(full_path) #(from.)?
