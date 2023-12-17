class_name InputComponent
extends Node

@export var rotation_damping: float = 0.00005

@export var character: Character
@export var camera: Camera3D

@export var input_actions: Dictionary = {
	"sprint" : InputSystem.InputStruct.new(
		_on_sprint_press,
		_on_sprint_release,
		null
	)
}

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_child(InputSystem.new(input_actions))

func _process(_delta):
	if character:
		if Input.is_action_just_pressed("ui_accept") and character.is_on_floor():
			character.jump()
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		if direction:
			character.walk(direction)
		
		var mouse_direction = Input.get_last_mouse_velocity()
		var y_rotation = Vector3(0, -mouse_direction.x * rotation_damping, 0)
		var x_rotation = Vector3(-mouse_direction.y * rotation_damping, 0, 0)
		if camera:
			camera.rotation += x_rotation + y_rotation

func _on_sprint_press():
	character.SPEED += character.SPRINT_BOOST

func _on_sprint_release():
	character.SPEED -= character.SPRINT_BOOST

func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseButton and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		if event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED	