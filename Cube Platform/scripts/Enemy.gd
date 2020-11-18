extends KinematicBody2D


const GRAVITY = 50
const ACCELERATION = 50
const MAX_SPEED = 300
const FLOOR_VECT = Vector2(0,-1)

var screen_size = Vector2()
var dir = Vector2()
func _ready():
	screen_size = get_viewport_rect().size
	pass

func _process(delta):
	if global_position.x <= screen_size.x:
		dir.x = 1
	elif global_position.x >= 0:
		dir.x = -1
	move_and_slide(dir*MAX_SPEED, FLOOR_VECT)

func _input(event):
	if Input.is_action_pressed("ui_select"):
		$AnimationPlayer.play("teleportation")

func on_teleportation_finished():
	print("finalizo")
	pass
