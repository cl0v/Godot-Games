extends KinematicBody2D

#TODO: Make the animations syncronize every time and every situations
enum AnimationState {
#	IDLE,
	MOVE,
	ATTACK,
	ROLL,
}

var motion = Vector2.ZERO
var animation_state = AnimationState.MOVE
onready var animation_playback = $AnimationTree.get("parameters/playback")

func _ready():
	$AnimationTree.active = true

func _process(delta):
	match animation_state:
		AnimationState.MOVE:
			move_state()
		AnimationState.ATTACK:
			attack_state()
		AnimationState.ROLL:
			roll_state()

func attack_state():
	animation_playback.travel("attack")

func roll_state():
	animation_playback.travel("roll")

func move_state():
	if motion != Vector2.ZERO:
		$AnimationTree.set("parameters/run/blend_position", motion)
		$AnimationTree.set("parameters/idle/blend_position", motion)
		$AnimationTree.set("parameters/attack/blend_position", motion)
		$AnimationTree.set("parameters/roll/blend_position", motion)
		animation_playback.travel("run")
	else:
		animation_playback.travel("idle")
