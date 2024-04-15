extends CanvasLayer

@export var dialog_file:Array[String]

var dialog = [[]]#stores the dialog after reading the file
var dialog_counter: int = -1 #stores current dialog index
var Current_Dialog_Array_Counter = 0
var dialog_active: bool = false

var placeholderPort = preload("res://Assets/Portraits/PlaceholderPortrait.png")

var nextScene: String

var textAfterSceneChange: bool = false


func _ready():
	$DialogBoxBackground.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func startDialog():
	if dialog_active:
		return
	Globals.currently_interacting = true
	dialog_active = true
	$DialogBoxBackground.visible = true
	dialog_counter = -1
	dialog = load_all_dialog(dialog_file)
	next_dialog_text()
	
func load_all_dialog(paths:Array[String]):
	var allDialogs = []
	for path in paths:
		allDialogs.append(load_dialogue(path))
	return allDialogs
	
	
	
func load_dialogue(path:String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		return JSON.parse_string(file.get_as_text())
	else:
		print("ahahah you stupid f***, your dialog file doesnt exist")

func _input(event):
	if dialog_active and event.is_action_pressed("interact"):
			next_dialog_text()

func next_dialog_text():
	var local_dialog = dialog[Current_Dialog_Array_Counter]
	dialog_counter += 1
	if dialog_counter >= len(local_dialog):
		$DialogBoxBackground.visible = false
		$DialogBoxBackground/PlayerItems.visible = false
		$DialogBoxBackground/NpcItems.visible = false
		$DialogBoxBackground/OtherItems.visible = false
		if len(dialog) > Current_Dialog_Array_Counter:
			Current_Dialog_Array_Counter +=1
		$Timer.start()
		return
	
	#load portrait if possible, else "?" portrait will be displayed
	var fileName = local_dialog[dialog_counter]["portrait"]
	var potrait = null
	
	var name = local_dialog[dialog_counter]["name"]
	
	if not (name == "" or name == "none"):
		if not (fileName == "" or fileName == "none"):
			potrait = load("res://Assets/Portraits/"+local_dialog[dialog_counter]["portrait"]+".png")
			if potrait == null:
				potrait = placeholderPort
		else: potrait = placeholderPort
	
	if name == "Player" or name == "You":
		$DialogBoxBackground/NpcItems.visible = false
		$DialogBoxBackground/OtherItems.visible = false
		$DialogBoxBackground/PlayerItems.visible = true
		$DialogBoxBackground/PlayerItems/Portrait.texture = potrait
		$DialogBoxBackground/PlayerItems/Name.text = name
		$DialogBoxBackground/PlayerItems/Text.text = local_dialog[dialog_counter]["text"]
	elif not (name == "" or name == "none"):
		$DialogBoxBackground/PlayerItems.visible = false
		$DialogBoxBackground/OtherItems.visible = false
		$DialogBoxBackground/NpcItems.visible = true
		$DialogBoxBackground/NpcItems/Portrait.texture = potrait
		$DialogBoxBackground/NpcItems/Name.text = name
		$DialogBoxBackground/NpcItems/Text.text = local_dialog[dialog_counter]["text"]
	else:
		$DialogBoxBackground/PlayerItems.visible = false
		$DialogBoxBackground/NpcItems.visible = false
		$DialogBoxBackground/OtherItems.visible = true
		$DialogBoxBackground/OtherItems/Text.text = local_dialog[dialog_counter]["text"]
	
		


func _on_timer_timeout():
	dialog_active = false
	Globals.currently_interacting = false
	#print("kill me")
	#print(nextScene)
	#print(nextScene.resource_path)
	#if nextScene.get_path() == "res://Scenes/main_scene.tscn":
	#	print("AAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHH WTF")
	#	TransitionLayer.change_scene_to_main(nextScene)
	#	return
	print(nextScene)
	if nextScene:
		if textAfterSceneChange:
			textAfterSceneChange = false
			TransitionLayer.change_scene_with_dialog_after_change(nextScene, "res://DialogText/Overworld/ChurchDialog.json")
			return
		else:
			TransitionLayer.change_scene(nextScene)
		#get_tree().change_scene_to_packed(nextScene)
	pass # Replace with function body.
