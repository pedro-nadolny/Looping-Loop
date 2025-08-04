extends Node

class_name WakeManager

@onready var _upper_eyelid = %UpperEyelid
@onready var _bottom_eyelid = %BottomEyelid
@onready var _eyelid_animation_player = %EyelidAnimationPlayer
@onready var _toothbrushing_animation_player = %ToothbrushingAnimationPlayer
@onready var _player: PlayerMovement = %Player
@onready var _wake: TransitionStep = %Wake
@onready var _toothbrushing_manager: Toothbrushing = %Toothbrushing

@onready var player_initial_position = %Player.position

var _walking = false
var _toothbrushing = false
var _already_toothbrushed = false
var _first_step = true

func _on_wake_stepping():
	if _first_step:
		_first_step = false
		var tween = create_tween()
		tween.parallel().tween_property(%Joystick, "modulate:a", 0, 0.25)
		tween.parallel().tween_property(%Arrow, "modulate:a", 0, 0.25)
	
	if _walking:
		_player.step()
	elif _toothbrushing:
		_toothbrushing_manager.step()

func _on_eyelid_animation_player_animation_finished(anim_name):
	var tween = create_tween()
	tween.parallel().tween_property(%Joystick, "modulate:a", 1, 0.25)
	tween.parallel().tween_property(%Arrow, "modulate:a", 1, 0.25)
	_wake.start_stepping()
	_walking = true
	_toothbrushing = false
	
func finish_toothbrushing():
	_toothbrushing_animation_player.play_backwards("toothbrush")

func _on_area_2d_area_entered_sink(area):	
	if not area.get_parent().name == "Player" or _already_toothbrushed:
		return
	
	_walking = false
	_toothbrushing = true
	_already_toothbrushed = true
	_toothbrushing_animation_player.active = true
	_toothbrushing_animation_player.play("toothbrush")
	
func _on_toothbrushing_animation_player_animation_finished(anim_name):
	if not _toothbrushing:
		_walking = true

func _on_toothbrushing_finished_toothbrushing():
	_toothbrushing = false
	_toothbrushing_animation_player.play_backwards("toothbrush")
	_player.max_target_position = 3000

func _on_finish_wake_area_area_entered(area):
	%Transitioner.transition_to_next()
	_first_step = true
	prints("Transitioner", name)

func _on_wake_visibility_changed():
	if not get_parent().visible:
		return
	
	%Arrow.modulate.a = 0
	%Joystick.modulate.a = 0
	_player.position = player_initial_position
	_walking = false
	_toothbrushing = false
	_already_toothbrushed = false
	_player.reset()
	_toothbrushing_animation_player.active = false
	
	_eyelid_animation_player.play("open_eyes")
