extends KinematicBody2D

const MAX_SPEED = 200
const FRICTION = 200
var input_vector = Vector2.ZERO
var motion = Vector2.ZERO

onready var texture = preload("res://cube.png")

func _ready():
	var sprite = create_sprite()
	position = get_viewport().size/2
	add_child(sprite)
	add_child(create_camera())
	add_child(create_collision_shape(sprite))
	


func create_sprite():
	var sprite = Sprite.new()
	sprite.texture = self.texture
	sprite.modulate = Color.silver
	return sprite

func create_collision_shape(sprite):
	var collision_shape = CollisionShape2D.new()
	var rec_shape = RectangleShape2D.new()
	collision_shape.shape = rec_shape
	rec_shape.extents = sprite.scale * sprite.texture.get_size() / 2
	return collision_shape

func create_camera():
	var camera = Camera2D.new()
	camera.current = true
	return camera

func _process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector != Vector2.ZERO:
		motion = motion.move_toward(input_vector * MAX_SPEED, FRICTION * delta)
	else:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta * 2)
	motion = move_and_slide(motion)
		
