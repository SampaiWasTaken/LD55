extends RigidBody2D
var ttl = 5

func _ready():
	connect("body_entered",  _on_body_entered)
	contact_monitor = true
	set_max_contacts_reported(1)

func _process(delta):
	ttl -= delta
	if ttl <= 0:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("MiniPlayer"):
		body.hurt()
		queue_free()
