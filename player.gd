class_name Player extends CharacterBody2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@export var starting_direction: Vector2 = Vector2(0, 1)
@export var speed: int = 100
@export var run = 1.5
var input_direction: Vector2 = Vector2.ZERO

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

func _physics_process(delta):
	input_direction.x = Input.get_axis("ui_left", "ui_right")
	input_direction.y = Input.get_axis("ui_up", "ui_down")

	if Input.is_action_pressed("ui_shift"):
		velocity = input_direction.normalized() * speed * run
	else:
		velocity = input_direction.normalized() * speed

func _process(delta):
	if Global.state == false:
		input_direction = Vector2.ZERO
		set_active(false)
	else:
		set_active(true)
		update_animation_parameters(input_direction)
		move_and_slide()
		pick_new_state()

func update_animation_parameters(move_input: Vector2):
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		
func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

# все что до этого - передвижение и анимации
# это - активация диалогов
func _unhandled_input(event: InputEvent) -> void:
	set_active(true)
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			if str(actionables[0]).begins_with("Look") == true:
				actionables[0].look()
				return
			else:
				set_active(false)
				input_direction = Vector2.ZERO
				actionables[0].action()
				return
		
# это - чтобы персонаж не ходил и не поворачивался во время диалога
func set_active(active):
	set_physics_process(active)
	set_process(active)
	state_machine.travel("Idle")






