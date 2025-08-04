extends Node

var _animations: Array[String] = ["moon1", "moon2", "moon3", "moon4"]
var _index = 0

var _block = false

func _on_month_stepping():
	if not _index == _animations.size() and not _block:
		%MoonAnimation.play(_animations[_index])
		_index += 1

func _on_moon_animation_animation_finished(anim_name):
	_block = false
	if anim_name == "moon4":
		%Transitioner.transition_to_next()
		prints("Transitioner", name)
		_index = 0

func _on_moon_animation_animation_started(anim_name):
	_block = true
