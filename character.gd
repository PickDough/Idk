class_name Character
extends CharacterBody3D

@export var SPEED = 5.0
@export var SPRINT_BOOST = 5.0
@export var JUMP_VELOCITY = 4.5

signal walking

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	velocity.z = move_toward(velocity.z, 0, SPEED * delta)
	move_and_slide()

func walk(direction: Vector3)->void:
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	walking.emit()

func jump()->void:
	velocity.y = JUMP_VELOCITY

func look(direction: Vector3):
	rotation += direction
