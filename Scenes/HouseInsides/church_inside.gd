extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
		#1 nix
	#2 nur höhle
	#3 nur pflanze 
	#4 alles
	
	if "plant" in Globals.player_items and "jewelry" in Globals.player_items:
		#beides fertig
		$nice/Priest/TemplateNPC4.position = $nice/Priest/PriestNpsPos.position
	elif "plant" in Globals.player_items:
		$nice/Priest/TemplateNPC3.position = $nice/Priest/PriestNpsPos.position
	elif "jewelry" in Globals.player_items:
		$nice/Priest/TemplateNPC2.position = $nice/Priest/PriestNpsPos.position
	else:
		$nice/Priest/TemplateNPC.position = $nice/Priest/PriestNpsPos.position
	pass # Replace with function body.
