extends Node

signal full_rotation_completed

var previous_angle: float = 0.0
var total_rotation: float = 0.0
var keyboard_angle: float = 0.0

@onready var transitioner: Transitioner = %Transitioner

func _input(event):
	# Track keyboard arrow keys for rotation
	var keyboard_input = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		keyboard_input.x = 1
	elif Input.is_action_pressed("ui_left"):
		keyboard_input.x = -1
	if Input.is_action_pressed("ui_down"):
		keyboard_input.y = 1
	elif Input.is_action_pressed("ui_up"):
		keyboard_input.y = -1
	
	if keyboard_input.length() > 0:
		var target_angle = keyboard_input.angle()
		var angle_diff = angle_difference(keyboard_angle, target_angle)
		total_rotation += angle_diff
		keyboard_angle = target_angle
		
		if abs(total_rotation) >= TAU:
			transitioner.current_step.step()
			total_rotation = 0.0
