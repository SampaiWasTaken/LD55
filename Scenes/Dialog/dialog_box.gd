extends CanvasLayer

@export_global_file("*.json") var dialog_file

var dialog = []#stores the dialog after reading the file
var dialog_counter: int = -1 #stores current dialog index
var dialog_active: bool = false

var nextScene: PackedScene


func _ready():
	$NinePatchRect.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func startDialog():
	if dialog_active:
		return
	dialog_active = true
	$NinePatchRect.visible = true
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
		$NinePatchRect.visible = false
		$Timer.start()
		return
	$NinePatchRect/Name.text = dialog[dialog_counter]["name"]
	$NinePatchRect/Text.text = dialog[dialog_counter]["text"]


func _on_timer_timeout():
	dialog_active = false
	Globals.currently_interacting = false
	if nextScene:
		get_tree().change_scene_to_packed(nextScene)
	pass # Replace with function body.
