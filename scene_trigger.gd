class_name SceneTrigger extends Area2D

@export var connected_scene: String #название сцены на которую переходим
var scene_folder = "res://scenes/"

func _on_body_entered(body):
	if body is Player:
		SceneManager.change_scene(get_owner(), connected_scene)

