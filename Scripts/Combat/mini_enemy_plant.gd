extends miniEnemy

func _ready():
	obj_bullet = preload("res://Scenes/CombatScenes/plant_bullet.tscn")
	$ShootTimer.start()
	$SpreadTimer.start()


func _on_spread_timer_timeout():
	print("spread")
	var dir = global_position.direction_to(player.global_position)
	shootSpread(dir.angle(), 50 + randi()%100)
