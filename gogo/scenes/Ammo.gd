extends Area2D

const SPEED = 900

func _physics_process(delta):
	position.x += SPEED * delta
