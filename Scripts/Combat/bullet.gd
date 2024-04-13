class_name Bullet

extends Area2D

var velocity: Vector2 = Vector2()
@export var oppositionString = ""
@export var duration = 5
var direction = Vector2.ZERO

func _ready():
	connect("body_entered",  _on_body_entered)

func _process(delta):
	position += velocity * delta
	duration -= delta
	if duration <= 0:
		queue_free()

func _on_body_entered(body:Node2D):
	if body.is_in_group(oppositionString):
		body.hurt()
		queue_free()
	elif(body.is_in_group("Walls")):
		queue_free()
		pass
