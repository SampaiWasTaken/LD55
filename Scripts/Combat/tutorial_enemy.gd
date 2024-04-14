extends CharacterBody2D

@export var speed = 600
 
var target = position

func _ready():
	randomize()
	$"../MoveTimer".start()

func _physics_process(delta):
	velocity = position.direction_to(target)*speed
	
	var playerPos = $"../player".position
	
	if global_position.distance_to(playerPos) < 100:
		target = playerPos - position
		velocity = position.direction_to(target)*speed
		move_and_slide()
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		target = Vector2(195 + randi()%986, 210 + randi()%610)

func hurt():
	pass


func _on_move_timer_timeout():
	target = Vector2(195 + randi()%986, 210 + randi()%610)
