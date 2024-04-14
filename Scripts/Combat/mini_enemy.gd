class_name miniEnemy
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("MiniPlayer")
var obj_bullet
var maxhp = 100
@onready var hp = maxhp


func _ready():
	obj_bullet = preload("res://Scenes/CombatScenes/enemy_bullet.tscn")
	$ShootTimer.start()
	print($ShootTimer)

func _process(_delta):
	pass

func shoot(direction: float, speed: float):
	#print("shot")
	var bullet = obj_bullet.instantiate()
	bullet.scale = Vector2(0.5, 0.5)
	bullet.position = $Marker2D.global_position
	bullet.rotation = direction
	bullet.velocity = Vector2(speed, 0).rotated(direction)
	$"../../..".add_child(bullet)
	$ShootTimer.start(randf_range(0.7, 1.2))

func shootSpread(direction: float, speed: float):
	var bullets = []
	bullets.resize(5)
	#bullets.fill(obj_bullet.instantiate())
	for i in 5:
		bullets[i] = obj_bullet.instantiate()
		bullets[i].scale = Vector2(0.5, 0.5)
		bullets[i].position = $Marker2D.global_position 
		bullets[i].rotation = 2*PI/8 + i*PI/8
		$"../../..".add_child(bullets[i])
		bullets[i].velocity = Vector2(speed, 0).rotated(bullets[i].rotation)
		
func _on_shoot_timer_timeout():
	#print("shot")
	var dir = global_position.direction_to(player.global_position)
	shoot(dir.angle(), 50 + randi()%100)
	
func hurt(damage):
	hp -= damage
	if hp <= 0:
		TransitionLayer.change_scene("res://Scenes/main_scene.tscn")
	print("Ouch")
	
