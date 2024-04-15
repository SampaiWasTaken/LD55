class_name Interactable extends Node2D

@export var global_dialog_counter = "none"
@export var interact_type = "none"
@export var interaction_value = "none"
@export var dialog_file: Array[String]
@export var ChangeToScene: String

var NumberOfInteractions:int = 0

var nextScene

func  _ready(): 
	$DialogBox.dialog_file = dialog_file

func showDialog():
	$DialogBox.global_dialog_counter = global_dialog_counter
	$DialogBox.startDialog()
	
func showDialogSceneChange():
	$DialogBox.global_dialog_counter = global_dialog_counter
	$DialogBox.startDialog()
	$DialogBox.nextScene = ChangeToScene

func showDialogSceneChangeWithAnotherDialogLaterAfterChange():
	$DialogBox.global_dialog_counter = global_dialog_counter
	$DialogBox.textAfterSceneChange = true
	$DialogBox.startDialog()
	$DialogBox.nextScene = ChangeToScene

	
