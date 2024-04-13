class_name miniEnemy

extends CharacterBody2D


@onready var player = get_tree().get_first_node_in_group("MiniPlayer")
var obj_bullet = preload("res://Scenes/CombatScenes/enemy_bullet.tscn")

func _ready():
	$ShootTimer.start()

func _process(_delta):
	pass

func shoot(direction: float, speed: float):
	var bullet = obj_bullet.instantiate()
	bullet.scale = Vector2(0.5, 0.5)
	bullet.position = $Marker2D.global_position
	bullet.rotation = direction
	bullet.velocity = Vector2(speed, 0).rotated(direction)
	$"../../..".add_child(bullet)
	$ShootTimer.start(randf_range(0.7, 1.2))


func _on_shoot_timer_timeout():
	var dir = global_position.direction_to(player.global_position)
	shoot(dir.angle(), 50 + randi()%100)
	
func hurt():
	print("Ouch")
	
