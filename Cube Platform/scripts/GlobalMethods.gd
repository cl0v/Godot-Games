extends Node

class_name GlobalMethods


#using Vector2().direction_to() maybe could simplify this entire fucntion
static func normalized_direction_to_target(pos, target_pos):
	var direction = Vector2(0,0)
	
	if target_pos.x < pos.x:
		direction.x = -1
	elif target_pos.x > pos.x:
		direction.x = 1
	else: direction.x = 0
	if target_pos.y < pos.y:
		direction.y = -1
	elif target_pos.y > pos.y:
		direction.y = 1
	else: direction.y = 0
	
	return direction.normalized()

static func normalized_direction_to_target_simplified(pos, target_pos):
	return pos.direction_to(target_pos)

func distance_to_target(pos, target_pos):
	return pos.distance_to(target_pos)
