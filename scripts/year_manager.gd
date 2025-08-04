extends Node

var _animations: Array[String] = ["year1", "year2", "year3", "year4"]
var _index = 0

var _block = false

func _on_year_stepping():
	if not _index == _animations.size() and not _block:
		%YearAnimation.play(_animations[_index])
		_index += 1

func _on_year_animation_animation_finished(anim_name):
	_block = false
	if anim_name == "year4":
		%Transitioner.transition_to_next()
		prints("Transitioner", name)
		_index = 0

func _on_year_animation_animation_started(anim_name):
	_block = true
