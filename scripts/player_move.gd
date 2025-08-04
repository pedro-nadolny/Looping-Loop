extends Sprite2D

class_name PlayerMovement

@export var _step_duration := 0.3
@export var _player_speed := 500.0
@export var max_target_position = 1366.0
@export var step_sound: AudioStreamPlayer
@onready var _initial_position := position.x
@onready var _target_position := position.x
@onready var _initial_max_target_position = max_target_position
@onready var _initial_scale = scale
@onready var _initial_rot = rotation
@onready var _initial_speed = _player_speed

var _step_timer := 999999.9

func _process(delta):
	position.x = lerpf(position.x, min(max_target_position, _target_position), 0.97)
	
	if _step_timer >= _step_duration:
		return
	
	_target_position += _player_speed * delta
	_step_timer += delta
	
func step():
	if _step_timer < _step_duration:
		return
	
	step_sound.play()
	_step_timer = 0.0
	
func reset():
	_target_position = _initial_position
	position.x = _initial_position
	max_target_position = _initial_max_target_position
	scale = _initial_scale
	rotation = _initial_rot
	_player_speed = _initial_speed
