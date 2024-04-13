extends Area2D
@export var speed = 20

var direction = Vector2.ZERO

func _physics_process(delta):
	position += direction*speed

func _on_body_entered(body:Node2D):
	if body.is_in_group("Enemy"):
		body.hurt()
		queue_free()
	elif(body.is_in_group("Walls")):
		queue_free()
		pass
