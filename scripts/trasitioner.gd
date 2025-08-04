extends Node

class_name Transitioner

var current_child_index: int = 0
var current_step: TransitionStep

@onready var color_manager: ColorManager = %ColorManager

func _ready():
	_prepare_children()
	
func _prepare_children():
	if get_child_count() > 0:
		for i in range(get_child_count()):
			var child: TransitionStep = get_child(i)
			child.update_color()
			child.visible = i == current_child_index			
			if i == current_child_index:
				current_step = child

func transition_to_next():
	var children = get_children()
	
	if children.size() <= 1:
		return  # No transition needed
	
	var current_child = children[current_child_index]
	var next_index = (current_child_index + 1) % children.size()
	var next_child = children[next_index]
	current_step = next_child
	
	# Make next child visible and start fade
	next_child.visible = true
	next_child.start_stepping()
	current_child.visible = false
	
	current_child_index = next_index
	
	if current_child_index == 0:
		color_manager.new_base_color()
		_prepare_children()
