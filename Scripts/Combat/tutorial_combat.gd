extends combatScene

func _ready():
	$player.canAct = false
	$UI/CooldownBar.visible = false
	$UI/ObjectiveLabel.text = "Catch"
	#$Walls/StaticBody2D5.disable()
