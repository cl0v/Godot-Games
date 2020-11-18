extends Position2D

onready var item = preload("res://scenes/Item.tscn")

func create_item():
	var instance = item.instance()
	instance.global_position = global_position
	get_parent().add_child(instance)

func _on_Timer_timeout():
	create_item()
