extends miniEnemy

func _ready():
	obj_bullet = preload("res://Scenes/CombatScenes/plant_bullet.tscn")
	$ShootTimer.start()
	$SpreadTimer.start()
	$WhipTimer.start()


func _on_spread_timer_timeout():
	#print("spread")
	var dir = global_position.direction_to(player.global_position)
	shootSpread(dir.angle(), 50 + randi()%100)


func _on_whip_timer_timeout():
	print("whip")
	$AnimationPlayer.play("whipAttack")
	pass # Replace with function body.


func _on_whip_hitbox_body_entered(body):
	if body.is_in_group("MiniPlayer"):
		print("hit by vine")
		body.hurt(20)
		$AnimationPlayer.stop()
