extends combatScene

var obj_boulder = preload("res://Scenes/CombatScenes/boulder.tscn")

func _ready():
	$BoulderTimer.start()
	
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
