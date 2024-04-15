extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#1 nix
	#2 nur höhle
	#3 nur pflanze 
	#4 alles
	
	if "cat" in Globals.player_items and "cave" in Globals.player_items:
		#beides fertig
		$DadNPC.position = $DadNpcPos.position
	elif "cat" in Globals.player_items:
		$DadNPC.position = $DadNpcPos.position
	elif "cave" in Globals.player_items:
		$DadNPC.position = $DadNpcPos.position
	else:
		$DadNPC.position = $DadNpcPos.position
		
	pass # Replace with function body.

