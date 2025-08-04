extends Node

class_name Toothbrushing

@onready var toothbrushing_audio: AudioStreamPlayer = %ToothbrushingAudio
@onready var player: PlayerMovement = %Player

var _toothbrushing_counter := 0

signal finished_toothbrushing

func step():
	if _toothbrushing_counter == 4:
		finished_toothbrushing.emit()
		_toothbrushing_counter = 0
		return
		
	toothbrushing_audio.play()
	_toothbrushing_counter += 1
