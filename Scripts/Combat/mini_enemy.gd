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


	
func hurt(damage):
	hp -= damage
	if hp <= 0:
		pass
	print("Ouch")
	
