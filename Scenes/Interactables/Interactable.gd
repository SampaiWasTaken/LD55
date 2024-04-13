class_name Interactable extends StaticBody2D

@export var interact_label = "none"
@export var interact_type = "none"
@export var interaction_value = "none"
@export_global_file("*.json") var dialog_file
@export var ChangeToScene: PackedScene

var nextScene

func  _ready(): 
	$DialogBox.dialog_file = dialog_file

func showDialog():
	$DialogBox.startDialog()
	
func showDialogSceneChange():
	$DialogBox.startDialog()
	$DialogBox.nextScene = ChangeToScene
	
