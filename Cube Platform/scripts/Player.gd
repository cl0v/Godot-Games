class_name PlayerClass
extends KinematicBody2D


enum AnimationState {
	IDLE,
	RUNNING,
	JUMPING
}

const Animation = {
	idle = "idle",
	running = "running"
}
const GRAVITY = 50
const ACCELERATION = 50
const MAX_SPEED = 600
const FLOOR_VECT = Vector2(0,-1)
const JUMP_HEIGTH = 800


var friction = true
var motion = Vector2()
var animation_state = AnimationState.IDLE

func _ready():
	Main.set_player(self)


func _physics_process(delta):
	motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		animation_state = AnimationState.RUNNING
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		
	elif Input.is_action_pressed("ui_left"):
		animation_state = AnimationState.RUNNING
		$Sprite.flip_h = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
	else:
		friction = true
		animation_state = AnimationState.IDLE
	if is_on_floor():
		if Input.is_action_pressed("ui_up") :
			$AudioStreamPlayer2D.play()
			motion.y = -JUMP_HEIGTH
		if friction == true:
			friction = false
			motion.x = lerp(motion.x, 0, 0.3)
	else:
		motion.x = lerp(motion.x, 0, 0.05)
	change_animation(animation_state)
	motion = move_and_slide(motion, FLOOR_VECT)


func change_animation(state):
	match state:
		AnimationState.IDLE:
			$Sprite.animation = Animation.idle
		AnimationState.RUNNING:
			$Sprite.animation = Animation.running

func _on_item_collected(type, value):
	print(type)
