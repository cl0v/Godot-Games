extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mult = Vector2(200,0)
var veloInicial = 100
var dir = Vector2(100,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	dir += mult
	move_and_slide(dir)
	if(position.x >= 1080*100):
		position.x = 492
	
func _input(event):
	if event.is_action_pressed("ui_select"):
		print(position.x)
		print(dir)
