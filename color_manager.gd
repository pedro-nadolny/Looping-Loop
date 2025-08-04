extends Node

class_name ColorManager

@onready var transitioner: Transitioner = %Transitioner

var _current_base_hue := 0.0

var _max_brightness_high = 0.9
var _max_brightness_low = 0.7
var _min_brightness_high = 0.3
var _min_brightness_low = 0.1

var brigtnessScale = [
	_max_brightness_high - (_max_brightness_high - _max_brightness_low)/4 * 0,
	_max_brightness_high - (_max_brightness_high - _max_brightness_low)/4 * 1,
	_max_brightness_high - (_max_brightness_high - _max_brightness_low)/4 * 2,
	_max_brightness_high - (_max_brightness_high - _max_brightness_low)/4 * 3,

	_min_brightness_low + (_min_brightness_high - _min_brightness_low)/4 * 3,
	_min_brightness_low + (_min_brightness_high - _min_brightness_low)/4 * 2,
	_min_brightness_low + (_min_brightness_high - _min_brightness_low)/4 * 1,
	_min_brightness_low + (_min_brightness_high - _min_brightness_low)/4 * 0,
]

func _ready():
	print(brigtnessScale)

func new_base_color():
	_current_base_hue += 0.2
	if _current_base_hue > 1:
		_current_base_hue -= 1

func get_foreground(i: int) -> Color:
	return Color.from_hsv(_current_base_hue, 0.7, brigtnessScale[i % brigtnessScale.size()])
	
func get_background(i: int) -> Color:
	return Color.from_hsv(_current_base_hue, 0.7, brigtnessScale[brigtnessScale.size() - 1 - (i % brigtnessScale.size())])
	
func get_accent(i: int) -> Color:
	var complimentary_hue = _current_base_hue + 0.5
	if complimentary_hue >= 1:
		complimentary_hue -= 1
	return Color.from_hsv(complimentary_hue, 0.7, brigtnessScale[i % brigtnessScale.size()/2])
