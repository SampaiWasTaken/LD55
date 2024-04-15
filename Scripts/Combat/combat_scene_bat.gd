extends combatScene

var obj_boulder = preload("res://Scenes/CombatScenes/boulder.tscn")
var obj_gas = preload("res://Scenes/CombatScenes/bad_gas.tscn")

func _ready():
	$BoulderTimer.start()
	$GasTimer.start()
	$UI/ObjectiveLabel.text = "Survive"
	
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


func _on_gas_timer_timeout():
	var dir = global_position.direction_to($player.global_position)
	shoot(150)
	$Path2D/PathFollow2D.progress_ratio = randf()
	
func shoot(speed: float):
	print("gas")
	var gas = obj_gas.instantiate()
	var loc = $Path2D/PathFollow2D/GasSpawn.global_position
	gas.position = loc
	gas.scale = Vector2(0.1, 0.1)
	gas.velocity = Vector2(speed, 0)
	
	$"..".add_child(gas)
	$GasTimer.start(randi_range(2,7))
