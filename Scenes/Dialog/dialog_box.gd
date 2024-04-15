extends CanvasLayer

@export var dialog_file:String

var dialog = []#stores the dialog after reading the file
var dialog_counter: int = -1 #stores current dialog index
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
	dialog = load_dialogue()
	next_dialog_text()
	
func load_dialogue():
	
	if FileAccess.file_exists(dialog_file):
		var file = FileAccess.open(dialog_file, FileAccess.READ)
		return JSON.parse_string(file.get_as_text())
	else:
		print("ahahah you stupid f***, your dialog file doesnt exist")

func _input(event):
	if dialog_active and event.is_action_pressed("interact"):
			next_dialog_text()

func next_dialog_text():
	dialog_counter += 1
	if dialog_counter >= len(dialog):
		$DialogBoxBackground.visible = false
		$DialogBoxBackground/PlayerItems.visible = false
		$DialogBoxBackground/NpcItems.visible = false
		$DialogBoxBackground/OtherItems.visible = false
		$Timer.start()
		return
	
	#load portrait if possible, else "?" portrait will be displayed
	var fileName = dialog[dialog_counter]["portrait"]
	var potrait = null
	
	var name = dialog[dialog_counter]["name"]
	
	if not (name == "" or name == "none"):
		if not (fileName == "" or fileName == "none"):
			potrait = load("res://Assets/Portraits/"+dialog[dialog_counter]["portrait"]+".png")
			if potrait == null:
				potrait = placeholderPort
		else: potrait = placeholderPort
	
	if name == "Player" or name == "You":
		$DialogBoxBackground/NpcItems.visible = false
		$DialogBoxBackground/OtherItems.visible = false
		$DialogBoxBackground/PlayerItems.visible = true
		$DialogBoxBackground/PlayerItems/Portrait.texture = potrait
		$DialogBoxBackground/PlayerItems/Name.text = name
		$DialogBoxBackground/PlayerItems/Text.text = dialog[dialog_counter]["text"]
	elif not (name == "" or name == "none"):
		$DialogBoxBackground/PlayerItems.visible = false
		$DialogBoxBackground/OtherItems.visible = false
		$DialogBoxBackground/NpcItems.visible = true
		$DialogBoxBackground/NpcItems/Portrait.texture = potrait
		$DialogBoxBackground/NpcItems/Name.text = name
		$DialogBoxBackground/NpcItems/Text.text = dialog[dialog_counter]["text"]
	else:
		$DialogBoxBackground/PlayerItems.visible = false
		$DialogBoxBackground/NpcItems.visible = false
		$DialogBoxBackground/OtherItems.visible = true
		$DialogBoxBackground/OtherItems/Text.text = dialog[dialog_counter]["text"]
	
		


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
