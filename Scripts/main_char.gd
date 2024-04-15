extends CharacterBody2D
@onready var animeSprite = $AnimatedSprite2D
@export var speed = 200


var stored_interactions_areas = []

func getInput():
	
	#movement
	var input_direction = Input.get_vector("walkLeft", "walkRight", "walkUp", "walkDown")
	if Input.is_action_pressed("walkRight"):
		animeSprite.play("walkRight")
	elif Input.is_action_pressed("walkLeft"):
		animeSprite.play("walkLeft")
	elif Input.is_action_pressed("walkUp"):
		animeSprite.play("walkUp")
	elif Input.is_action_pressed("walkDown"):
		animeSprite.play("walkDown")
	else:
		input_direction = Vector2.ZERO
		animeSprite.stop()
		animeSprite.frame = 0
	velocity = input_direction * speed
	
	#interaction
	if Input.is_action_just_pressed("interact"):
		interact()

func _process(_delta):
	if not Globals.currently_interacting:
		getInput()
		move_and_slide()
	
	


#shit for the interactions
func _on_interaction_area_area_entered(area):
	stored_interactions_areas.insert(0, area) #i do this, if multiple areas are in the same spot we store the interactions
	print("added interaction")
	pass # Replace with function body.


func _on_interaction_area_area_exited(area):
	stored_interactions_areas.erase(area)
	print("removed interaction")
	pass # Replace with function body.
	
func interact():
	if not Globals.currently_interacting and stored_interactions_areas:
		var newest_interaction = stored_interactions_areas[0].get_parent()
		match newest_interaction.interact_type:
			#prints the interaction_value
			"print_text" : print(newest_interaction.interaction_value)
			#Only Shows Dialog, Dialog needed
			"Only_Dialog" : 
				newest_interaction.showDialog()
			#Chages the after dialog
			"Dialog_With_Szene_Change" : 
					newest_interaction.showDialogSceneChange()
			"Dialog_With_Szene_Change_with_dialog_after_change" : 
					newest_interaction.showDialogSceneChangeWithAnotherDialogLaterAfterChange()
			"Dialog_With_Szene_Change_from_Overworld" : 
					Globals.overworld_player_pos = global_position
					newest_interaction.showDialogSceneChange()
			#Pickup Item with a Dialog
			"Item_With_Dialog" : 
				Globals.player_items.append(newest_interaction.interaction_value)
				newest_interaction.showDialog()
				print(Globals.player_items)
