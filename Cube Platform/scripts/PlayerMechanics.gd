extends Node

class_name FollowPlayer

func _ready():
	pass


static func player_direction(
	position: Vector2 = Vector2.ZERO, 
	player_position: Vector2 = Vector2.ZERO,
	distance: float = 0
):
	if distance:
		if position.distance_to(player_position) > distance:
			return position.direction_to(player_position)
		else: return Vector2.ZERO
	
	return position.direction_to(player_position)
	
	#if the distance is need, then we will calculate the coordinates needed to return the position,
	#otherwise we just need to return a zero value, cause we dont need to move
