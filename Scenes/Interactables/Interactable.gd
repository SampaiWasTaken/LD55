class_name Interactable extends Node2D

@export var interact_label = "none"
@export var interact_type = "none"
@export var interaction_value = "none"
@export var dialog_file: String
@export var ChangeToScene: String

var NumberOfInteractions:int = 0

var nextScene

func  _ready(): 
	$DialogBox.dialog_file = dialog_file

func showDialog():
	$DialogBox.startDialog()
	
func showDialogSceneChange():
	$DialogBox.startDialog()
	$DialogBox.nextScene = ChangeToScene

func showDialogSceneChangeWithAnotherDialogLaterAfterChange():
	$DialogBox.textAfterSceneChange = true
	$DialogBox.startDialog()
	$DialogBox.nextScene = ChangeToScene
	
