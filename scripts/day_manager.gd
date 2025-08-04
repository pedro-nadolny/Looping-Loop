extends Node

class_name DayManager

@onready var _daypass: AnimationPlayer = %DayPass
@onready var _car: PlayerMovement = %Car

func _on_day_stepping():
	_car.step()

func _on_day_visibility_changed():
	if not get_parent().visible:
		return
		
	%Day.start_stepping()
	%EndScene.monitoring = true
	
func _on_flip_car_area_entered(area):
	_car._player_speed = -_car._player_speed
	_car.scale.x = -_car.scale.x
	_daypass.play("daypass")

func _on_end_scene_area_entered(area):
	if not get_parent().visible:
		return
		
	%Transitioner.transition_to_next()
	prints("Transitioner", name)
	_daypass.play("RESET")
	_car.reset()
