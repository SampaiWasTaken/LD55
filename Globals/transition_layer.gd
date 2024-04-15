extends CanvasLayer
var textbox = preload("res://Scenes/Dialog/dialog_box.tscn")
func change_scene(target: String) -> void:
	$AnimationPlayer.play("Fade_to_Black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("reveal")

func change_scene_with_dialog_after_change(target: String, dialog_file: String) -> void:
	$AnimationPlayer.play("Fade_to_Black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	var test:Array[String] = [dialog_file]
	#test.append(dialog_file)
	$DialogBox.dialog_file = test
	$AnimationPlayer.play("reveal no unlock")
	$DialogBox.startDialog()
	
func unlock_movement():
	Globals.currently_interacting = false
