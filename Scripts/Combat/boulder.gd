extends RigidBody2D


func _ready():
	connect("body_entered",  _on_body_entered)
	contact_monitor = true
	set_max_contacts_reported(1)
	

func _on_body_entered(body):
	if body.is_in_group("MiniPlayer"):
		body.hurt()
		queue_free()
