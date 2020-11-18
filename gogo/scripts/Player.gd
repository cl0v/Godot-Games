extends KinematicBody2D

var dir = Vector2()
const MAX_SPEED = 300
const ACCEL = 5

onready var ammo = preload("res://scenes/Ammo.tscn")

func _physics_process(delta):
	process_input()
	
	move_and_slide(dir * MAX_SPEED)

func process_input():
	dir.x = Input.get_action_strength("ui_right") -  Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") -  Input.get_action_strength("ui_up")
	
	if Input.is_action_just_pressed("ui_select"):
		fire_bullet()

func fire_bullet():
	var bullet = ammo.instance()
	bullet.global_position = $Position2D.global_position
	bullet.rotate(deg2rad(90))
	get_tree().root.get_children()[0].add_child(bullet)
