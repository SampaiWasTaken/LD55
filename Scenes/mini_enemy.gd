extends CharacterBody2D

@export var shotspeed = 1.2
@onready var player = get_tree().get_first_node_in_group("MiniPlayer")
@onready var shootTimer = $ShootTimer

var bulletScene = preload("res://Scenes/enemy_bullet.tscn")

func _ready():
	shootTimer.start()

func _process(delta):
	pass

func shoot():
	var bullet = bulletScene.instantiate()
	bullet.scale = Vector2(0.5, 0.5)
	
	$"..".add_child(bullet)
	var dir = global_position.direction_to(player.global_position)
	bullet.direction = dir
	bullet.rotation = dir.angle()
	shootTimer.start()


func _on_shoot_timer_timeout():
	shoot()
	
func hurt():
	print("Ouch")
	
