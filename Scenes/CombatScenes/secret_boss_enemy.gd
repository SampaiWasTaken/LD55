extends miniEnemy

signal whipping
signal whippingStopped
func _init():
	maxhp = 1000

func _ready():
	obj_bullet = preload("res://Scenes/CombatScenes/secret_boss_bullet.tscn")
	$ShootTimer.start()
	$SpreadTimer.start()
	$WhipTimer.start()
	
func shoot(direction: float, speed: float):
	#print("shot")
	$ShootSound.play()
	var bullet = obj_bullet.instantiate()
	bullet.scale = Vector2(1.5, 1.5)
	bullet.position = $Marker2D.global_position
	bullet.rotation = direction
	bullet.velocity = Vector2(speed, 0).rotated(direction)
	$"../../..".add_child(bullet)
	$ShootTimer.start(randf_range(0.3, 0.5))

func shootSpread(direction: float, speed: float):
	$ShootSound.play()
	var bullets = []
	bullets.resize(5)
	#bullets.fill(obj_bullet.instantiate())
	for i in 5:
		bullets[i] = obj_bullet.instantiate()
		bullets[i].scale = Vector2(1.5, 1.5)
		bullets[i].position = $Marker2D.global_position 
		bullets[i].rotation = 2*PI/8 + i*PI/8
		$"../../..".add_child(bullets[i])
		bullets[i].velocity = Vector2(speed, 0).rotated(bullets[i].rotation)
		
func _on_shoot_timer_timeout():
	#print("shot")
	var dir = global_position.direction_to(player.global_position)
	shoot(dir.angle(), 50 + randi()%100)

func _on_spread_timer_timeout():
	#print("spread")
	var dir = global_position.direction_to(player.global_position)
	shootSpread(dir.angle(), 50 + randi()%100)


func _on_whip_timer_timeout():
	$VineSound.play()
	print("whip")
	$AnimationPlayer.play("whipAttack")
	whipping.emit()
	$WhippingTimer.start()
	pass # Replace with function body.


func _on_whip_hitbox_body_entered(body):
	if body.is_in_group("MiniPlayer"):
		print("hit by vine")
		body.hurt(20)
		$AnimationPlayer.stop()
		$WhipAttack.visible = false
		
func hurt(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		TransitionLayer.change_scene_with_dialog_after_change("res://Scenes/main_scene.tscn", "res://DialogText/Overworld/plantEnemy.json")
	print("Ouch")


func _on_animation_player_animation_finished(anim_name):
	return true


func _on_whipping_timer_timeout():
	whippingStopped.emit()
	pass # Replace with function body.
