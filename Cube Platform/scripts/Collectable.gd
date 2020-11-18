extends RigidBody2D

signal collected(type, value)
signal dropped(pos)

func _ready():
	contact_monitor = true
	contacts_reported = 1
	connect("dropped", get_parent().get_node("Pet"), "_on_item_dropped")
	

func _on_RigidBody2D_body_entered(body):
	if(body.name == "Player"):
		connect("collected", body, "_on_item_collected")
		emit_signal("collected", "PowerUp", 1)
		queue_free()
	if(body.name == "Floor"):
		emit_signal("dropped", global_position)
	if(body.name == "Pet"):
		connect("collected", body, "_on_item_collected")
		emit_signal("collected", "PowerUp", 1)
		queue_free()
