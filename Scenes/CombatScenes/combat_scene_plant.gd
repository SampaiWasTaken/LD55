extends combatScene

func _init():
	pass

func _ready():
	$UI/ObjectiveLabel.text = "HARVEST"
	$Path2D/PathFollow2D.progress_ratio = 0.5
func _process(_delta):
	$UI/HPBar.value = Player.health
	$UI/CooldownBar/PlantHp.value = $Path2D/PathFollow2D/miniEnemy.hp


func _on_mini_enemy_whipping():
	$MoveTimer.paused = true
	pass # Replace with function body.


func _on_mini_enemy_whipping_stopped():
	print("stopped")
	$MoveTimer.paused = false
	pass # Replace with function body.
