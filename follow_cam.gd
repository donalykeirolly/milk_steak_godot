extends Camera2D

@export var room: TextureRect
@export var follow_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mapRect = room.get_minimum_size()
	limit_right = mapRect.x
	limit_bottom = mapRect.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = follow_node.global_position

