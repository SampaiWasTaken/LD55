extends CharacterBody2D

@export var speed = 200

var stored_interactions_areas = []

func getInput():
	
	#movement
	var input_direction = Input.get_vector("walkLeft", "walkRight", "walkUp", "walkDown")
	velocity = input_direction * speed
	
	#interaction
	if Input.is_action_just_pressed("interact"):
		interact()

func _physics_process(_delta):
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
	if stored_interactions_areas:
		var newest_interaction = stored_interactions_areas[0].get_parent()
		match newest_interaction.interact_type:
			"print_text" : print(newest_interaction.interaction_value)
			"only_Dialog" : Globals.currently_interacting = true; newest_interaction.showDialog();
		#print(stored_interactions_areas[0].interact_label)
