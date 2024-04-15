extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	print("why dont u button")
	Globals.currently_interacting = false
	Globals.player_items = []
	Globals.overworld_player_pos = Vector2(419,480)

	Globals.DadCounter1 = 0
	Globals.PriestCounter1 = 0
	Globals.MomCounter1 = 0
	Globals.SmithCounter1 = 0
	
	TransitionLayer.change_scene_with_dialog_after_change("res://Scenes/HouseInsides/main_char_house_inside.tscn", "res://DialogText/PlayerHouse/RespawnAfterDeath.json")
	
	pass # Replace with function body.
