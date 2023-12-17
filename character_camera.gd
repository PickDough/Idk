extends Camera3D

@export var rotation_speed: float = 2
@export var degree_delta: float = 60
@export var character: Character
	
func _process(_delta):
	rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
	
	if character:
		if not character.walking.is_connected(faster_align_character):
			character.walking.connect(faster_align_character)
		var angle_to = Quaternion.from_euler(Vector3(0, character.rotation.y, 0)).normalized().angle_to(
			Quaternion.from_euler(Vector3(0, rotation.y, 0)).normalized()
		)

		if angle_to > deg_to_rad(degree_delta):
			align_character(rotation_speed)
	

func faster_align_character():
	align_character(2 * rotation_speed)

func align_character(speed: float):
	character.rotation.y = Quaternion.from_euler(character.rotation).slerp(
		Quaternion.from_euler(rotation), 
		speed * get_process_delta_time()
	).get_euler().y