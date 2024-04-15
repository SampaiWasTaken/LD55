extends Node2D

func _init():
	pass
	
func _ready():
	Globals.currently_interacting = true
	$AnimationPlayer.play("wowthatsepic")
	#$nice/TemplateNPC.queue_free()
