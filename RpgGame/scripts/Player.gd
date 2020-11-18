extends KinematicBody2D


enum AnimationState {
#	IDLE,
	MOVE,
	ATTACK,
	ROLL,
}


const MAX_SPEED = 90.0
var input_vector =  Vector2.ZERO
var animation_state = AnimationState.MOVE
var roll_vector = Vector2.DOWN
onready var animation_playback = $AnimationTree.get("parameters/playback")



func _ready():
	$AnimationTree.active = true
	animation_playback.start("idle")

func _physics_process(_delta):
	match animation_state:
		AnimationState.MOVE:
			move_state()
		AnimationState.ATTACK:
			attack_state()
		AnimationState.ROLL:
			roll_state()
	send_data_to_network(position, input_vector, animation_state)

func send_data_to_network(pos, inpt, anim):
	for p in PlayerNetwork.players:
		if p == get_tree().get_network_unique_id():
			var data = [pos, inpt, anim]
			PlayerNetwork.rpc("receive_data_from_player", data)

func move_state():
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		$AnimationTree.set("parameters/run/blend_position", input_vector)
		$AnimationTree.set("parameters/idle/blend_position", input_vector)
		$AnimationTree.set("parameters/attack/blend_position", input_vector)
		$AnimationTree.set("parameters/roll/blend_position", input_vector)
		animation_playback.travel("run")
	else:
		animation_playback.travel("idle")
	
	move_and_slide(input_vector * MAX_SPEED)
	
	if Input.is_action_just_pressed("ui_roll"):
		animation_state = AnimationState.ROLL
	if Input.is_action_just_pressed("ui_attack"):
		animation_state = AnimationState.ATTACK

func attack_state():
	animation_playback.travel("attack")
	
func roll_state():
	animation_playback.travel("roll")
	move_and_slide(roll_vector * MAX_SPEED)

func _on_attack_animation_finished():
	animation_state = AnimationState.MOVE

func _on_roll_animation_finished():
	animation_state = AnimationState.MOVE
