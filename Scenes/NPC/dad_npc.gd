extends Node2D

@export var interact_type = "none"
@export_global_file("*.json") var dialog_file

func _ready():
	
	$InteractableSquare.interact_type = interact_type
	$InteractableSquare.dialog_file = dialog_file
	pass # Replace with function body.

