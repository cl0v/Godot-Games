extends KinematicBody2D

const MIN_DISTANCE = 100
const ACCELERATION = 10
const MAX_SPEED = 400

var player_global_position
var motion = Vector2()

enum TARGET {
	PLAYER,
	ITEM,
	ENEMY
}

var target = TARGET.PLAYER

var item_pos = Vector2()

onready var player = Main.get_player()

var direction = Vector2()

func _physics_process(delta):
	
	direction = FollowPlayer.player_direction(global_position,player.global_position, MIN_DISTANCE)
	if direction.x <= 0:
		$Sprite.flip_h = true
	elif direction.x >= 0:
		$Sprite.flip_h = false
	
	motion = move_and_slide(direction * MAX_SPEED)

func distance_to_player(pos, player_pos):
	var distance = pos.distance_to(player_pos)
	
#	if distance > MIN_DISTANCE:
#		return pet_motion(pos, player_pos)
	return Vector2.ZERO

#func set_target(target_val, pos, player_pos):
#	match target_val:
#		TARGET.ITEM:
#			return pet_motion(pos, item_pos)
#		TARGET.PLAYER:
#			return distance_to_player(pos, player_pos)
#

func _on_item_dropped(pos):
	target = TARGET.ITEM
	self.item_pos = pos

func _on_item_collected(type, value):
	target = TARGET.PLAYER
