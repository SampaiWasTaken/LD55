extends CharacterBody2D

@export var speed = 6
 
var target = position

func _ready():
	randomize()
	$"../MoveTimer".start()

func _physics_process(delta):
	velocity = position.direction_to(target)*speed
	
	var playerPos = $"../player".position
	
	if global_position.distance_to(playerPos) < 200:
		var dv = (playerPos - position).normalized() * speed
		var steer = -(dv - velocity) 
		velocity = steer
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		target = Vector2(195 + randi()%986, 210 + randi()%610)


func hurt():
	TransitionLayer.change_scene("res://Scenes/main_scene.tscn")
	pass


func _on_move_timer_timeout():
	target = Vector2(195 + randi()%986, 210 + randi()%610)


func _on_area_2d_body_entered(body):
	if body.is_in_group("MiniPlayer"):
		hurt()
