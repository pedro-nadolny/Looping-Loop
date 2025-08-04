extends Node

class_name EvolutionManager

@export var items: Array[CanvasItem]

@onready var color_manager: ColorManager = %ColorManager
@onready var _current_items: Array[CanvasItem]

var _foreground_color: Color
var _accent_color: Color
var _prev_item: CanvasItem
var _block = false
var _index = 0	

func _on_evolution_started_stepping():
	var index = get_parent().get_index()
	_foreground_color = color_manager.get_foreground(index)
	_accent_color = color_manager.get_accent(index)
	
	_current_items = items
	
	for item in _current_items:
		item.modulate.a = 0

func _on_evolution_stepping():
	if _block:
		return
		
	if _current_items.size() == _index:
		%Transitioner.transition_to_next()
		prints("Transitioner", name)
		_index = 0
		_prev_item = null
		return
		
	var tween = create_tween()
	
	_block = true
	var item: CanvasItem = _current_items[_index]
	
	if _prev_item != null:
		tween.parallel().tween_property(_prev_item, "modulate", _foreground_color, 0.5)
		
	item.modulate = Color(_accent_color, 0)
	tween.parallel().tween_property(item, "modulate:a", 1.0, 0.5)
	
	var audio: AudioStreamPlayer = item.get_children()[0]
	audio.play()
	
	_prev_item = item
	await get_tree().create_timer(1).timeout
	_block = false
	_index += 1
