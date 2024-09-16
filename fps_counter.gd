extends Control

func _process(delta) -> void:
	$Label.text = str(Engine.get_frames_per_second())
