extends CharacterBody2D

@export var speed = 600
 
var target = position

func _ready():
	randomize()
	$"../MoveTimer".start()

func _physics_process(delta):
	velocity = position.direction_to(target)*speed
	if velocity.x < 0:
		$AnimatedSprite2D.play("walkLeft")
	else:
		$AnimatedSprite2D.play("walkRight")
	
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
	TransitionLayer.change_scene_with_dialog_after_change("res://Scenes/main_scene.tscn", "res://DialogText/Overworld/tutorialEnemy.json")
	pass


func _on_move_timer_timeout():
	target = Vector2(195 + randi()%986, 210 + randi()%610)


func _on_area_2d_body_entered(body):
	if body.is_in_group("MiniPlayer"):
		hurt()
