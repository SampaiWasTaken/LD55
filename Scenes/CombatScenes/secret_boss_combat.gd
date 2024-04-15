extends combatScene

var obj_boulder = preload("res://Scenes/CombatScenes/secret_boss_boulder.tscn")
var obj_gas = preload("res://Scenes/CombatScenes/secret_boss_bad_gas.tscn")

func _init():
	pass

func _ready():
	$Path2D/PathFollow2D.progress_ratio = 0.5
	$BoulderTimer.start()
	$GasTimer.start()
	#$LevelTimer.start()
	
func _process(_delta):
	$UI/HPBar.value = Player.health
	$UI/BossHp.value = $Path2D/PathFollow2D/miniEnemy.hp

func _on_mini_enemy_whipping():
	$MoveTimer.paused = true
	pass # Replace with function body.

func _on_mini_enemy_whipping_stopped():
	print("stopped")
	$MoveTimer.paused = false
	pass # Replace with function body.	
	
func _on_boulder_timer_timeout():
	var boulder = obj_boulder.instantiate()
	var loc = $BoulderPath/BoulderSpawner
	loc.progress_ratio = randf()
	var dir = loc.rotation + PI/2
	boulder.position = loc.position
	dir += randf_range(-PI/4, PI/4)
	boulder.rotation = dir 
	var vel = Vector2(randf_range(150, 250), 0)
	boulder.linear_velocity = vel.rotated(dir)
	add_child(boulder)
	$BoulderEffect.play()

func _on_gas_timer_timeout():
	var dir = global_position.direction_to($player.global_position)
	shoot(150)
	$GasPath/PathFollow2D.progress_ratio = randf()
	
func shoot(speed: float):
	print("gas")
	var gas = obj_gas.instantiate()
	var loc = $GasPath/PathFollow2D/GasSpawn.global_position
	gas.position = loc
	gas.scale = Vector2(0.1, 0.1)
	gas.velocity = Vector2(speed, 0)
	$GasEffect.play()
	$"..".add_child(gas)
	$GasTimer.start(randi_range(2,4))
