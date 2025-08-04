extends Node

class_name WeekManager

var _animations: Array[String] = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
var _index = 0
@export var _pages: Array[Node2D]

func _on_week_stepping():
	if _index < _animations.size():
		%WeekAnimationPlayer.play(_animations[_index])
		_index += 1
		%WeekAnimationPlayer.active = true
		%TearPlayer.play()

func _on_week_animation_player_animation_finished(anim_name):
	if anim_name == "sun":
		%Transitioner.transition_to_next()
		_index = 0
		prints("Transitioner", name)

func _on_week_started_stepping():
	for page in _pages:
		page.position = Vector2(1920.0/2, 1080/2)
		page.rotation = 0
