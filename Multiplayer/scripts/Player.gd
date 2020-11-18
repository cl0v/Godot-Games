extends KinematicBody2D

const MAX_SPEED = 10
const MAX_HP = 100

enum MoveDirection {UP, DOWN, LEFT, RIGHT, NONE}

slave var slave_position = Vector2.ZERO
slave var slave_movement = MoveDirection.NONE

var health_points = MAX_HP
#
#func _ready():
#	_update_health_bar()
#

func _init(name, start_position, is_slave):
	global_position = start_position 

func _physics_process(delta):
	var direction = MoveDirection.NONE
	if is_network_master():
		if Input.is_action_pressed("ui_left"):
			direction = MoveDirection.LEFT
		elif Input.is_action_pressed("ui_right"):
			direction = MoveDirection.RIGHT
		elif Input.is_action_pressed("ui_up"):
			direction = MoveDirection.UP
		elif Input.is_action_pressed("ui_down"):
			direction = MoveDirection.DOWN
		
		rset_unreliable("slave_position", position)
		rset("slave_moviment", direction)
		_move(direction)
	
	else:
		_move(slave_movement)
		position = slave_position
	
	if get_tree().is_network_server():
		Network.update_position(int(name), position)


func _move(direction):
	match direction:
		MoveDirection.NONE:
			return
		MoveDirection.UP:
			move_and_slide(Vector2(0, -MAX_SPEED))
		MoveDirection.DOWN:
			move_and_slide(Vector2(0, MAX_SPEED))
		MoveDirection.RIGHT:
			move_and_slide(Vector2(MAX_SPEED, 0))
		MoveDirection.LEFT:
			move_and_slide(Vector2(-MAX_SPEED, 0))

#
#func _update_health_bar():
#	pass
