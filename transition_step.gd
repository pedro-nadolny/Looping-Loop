extends Node2D

class_name TransitionStep

signal stepping

@export var background_colored: Array[CanvasItem]
@export var accent_colored: Array[CanvasItem]
@export var white_colored: Array[CanvasItem]

@onready var transitioner: Transitioner = %Transitioner
@onready var color_manager: ColorManager = %ColorManager

var _can_step = false

signal started_stepping

func update_color():
	var my_index = get_index()
	prints("update_color", name, my_index, color_manager.get_background(my_index), color_manager.get_foreground(my_index))
	
	for item in get_children():
		if item is not CanvasItem:
			continue
			
		if background_colored.has(item):
			item.modulate = color_manager.get_background(my_index)
		elif accent_colored.has(item):
			item.modulate = color_manager.get_accent(my_index)
		elif white_colored.has(item):
			item.modulate = Color.WHITE
		else:
			item.modulate = color_manager.get_foreground(my_index)
			
	for item in accent_colored:
		item.modulate = Color(color_manager.get_accent(my_index), item.self_modulate.a)

func step():
	if not visible or not _can_step:
		return
	
	prints("Step", name)
	stepping.emit()
		
func next_stage():
	transitioner.transition_to_next()
	prints("Transitioner", name)
	_can_step = false
		
func start_stepping():
	_can_step = true
	started_stepping.emit()
