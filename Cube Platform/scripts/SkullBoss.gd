extends KinematicBody2D

const ACCELERATION = 50
const MAX_SPEED = 600

var motion = Vector2()
var direction = Vector2()

onready var player = Main.get_player()


func _physics_process(delta):
	motion = FollowPlayer.player_direction(global_position, player.global_position)
	if motion.x > 0:
		$Skull/Sprite.flip_h = true
	else:
		$Skull/Sprite.flip_h = false
	motion = move_and_slide(motion * MAX_SPEED)

