extends Node2D

func _init():
	Globals.currently_interacting = true
	pass
	
func _ready():
	Globals.currently_interacting = true
	$AnimationPlayer.play("wowthatsepic")
	#$nice/TemplateNPC.queue_free()


func _on_animation_player_animation_finished(anim_name):
	if "Sword" in Globals.player_items and "Book1" in Globals.player_items and "Book2" in Globals.player_items:
		TransitionLayer.change_scene("res://Scenes/CombatScenes/secret_boss_combat.tscn")
	else:
		TransitionLayer.change_scene("placeholderendscene")
