extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#1 nix
	#2 nur höhle
	#3 nur pflanze 
	#4 alles
	
	if "plant" in Globals.player_items and "jewelry" in Globals.player_items:
		#beides fertig
		$DadNPC4.position = $DadNpcPos.position
	elif "plant" in Globals.player_items:
		$DadNPC3.position = $DadNpcPos.position
	elif "jewelry" in Globals.player_items:
		$DadNPC2.position = $DadNpcPos.position
	else:
		$DadNPC.position = $DadNpcPos.position
		
	if "plant" in Globals.player_items and "jewelry" in Globals.player_items:
		#beides fertig
		$MomNPC4.position = $MomNpcPos.position
	elif "plant" in Globals.player_items:
		$MomNPC3.position = $MomNpcPos.position
	elif "jewelry" in Globals.player_items:
		$MomNPC2.position = $MomNpcPos.position
	else:
		$MomNPC.position = $MomNpcPos.position
		
	pass # Replace with function body.

