class_name InputSystem
extends Node

class InputStruct:
	var on_press
	var on_release
	var on_capture

	func _init(press, release, capture):
		on_press = press
		on_release = release
		on_capture = capture

var _dic: Dictionary

func _init(dic):
	_dic = dic

func _process(_delta):
	for action in _dic:
		var struct = _dic[action]
		if struct.on_press and Input.is_action_just_pressed(action):
			struct.on_press.call()
		if struct.on_release and Input.is_action_just_released(action):
			struct.on_release.call()
		if struct.on_capture and Input.is_action_pressed(action):
				struct.on_capture.call()
