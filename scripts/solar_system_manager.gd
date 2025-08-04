extends Node

@onready var _video: VideoStreamPlayer = %Video
@onready var _color_manager: ColorManager = %ColorManager
@onready var _bigbang: AnimationPlayer = %BigBang
@onready var _space_music: AudioStreamPlayer = %SpaceMusic
@onready var _swoosh: AudioStreamPlayer = %Swoosh
@onready var _fade: Polygon2D = %Fade
var bg_color: Color
var fg_color: Color

func _on_solar_system_started_stepping():
	_video.play()
	_video.paused = true
	
	var index = get_parent().get_index()

	bg_color = _color_manager.get_background(index)
	fg_color = _color_manager.get_foreground(index)
	
	var shader: ShaderMaterial = _video.material
	shader.set_shader_parameter("dark_color", bg_color)
	shader.set_shader_parameter("light_color", fg_color)
	
	_fade.modulate = Color(Color.WHITE, 0.0)
	_fade.self_modulate = Color.WHITE
	_fade.color = Color(bg_color, 0)

func _on_solar_system_stepping():
	if not _video.paused:
		return
	
	_space_music.play()
	_video.paused = false
	
	_bigbang.play("bigbang1")
	
	await get_tree().create_timer(24).timeout
	
	var tween = create_tween()
	tween.tween_property(_space_music, "volume_linear", 0, 0.2)
	
	tween.tween_callback(func():
		_swoosh.play()
		_bigbang.play("bigbang2")
		
		var tween2 = get_tree().create_tween()
		tween2.tween_property(_fade, "modulate", Color.WHITE, 0.25)
	)

func _on_swoosh_finished():
	%Transitioner.transition_to_next()
	_video.play()
	_video.paused = true
	prints("Transitioner", name)
	_bigbang.play("RESET")
	_space_music.volume_linear = 1
	_space_music.seek(0)
	_space_music.stop()
