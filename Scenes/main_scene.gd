extends Node2D

func _ready():
	$MainChar.position = Globals.overworld_player_pos
	var mat1 = load("res://Scenes/shader test/2dShadowShaderMat.tres")
	var mat2 = load("res://Scenes/shader test/2dShadowShaderMat2.tres")
	var trees = $Trees.get_children()
	
	if "lantern" in Globals.player_items:
		$InteractableSquare.queue_free()
	if "cat" in Globals.player_items:
		$CatNPC.queue_free()
	if "plant" in Globals.player_items:
		$PlantNPC.queue_free()
	for tree in trees:
		if tree.scale.y < 0:
			tree.material = mat1
		else:
			tree.material = mat2



func _on_area_2d_body_entered(body):
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($DirectionalLight2D, "energy", 0.7, 2)
	if "lantern" in Globals.player_items:
		$MainChar/PointLight2D.show()
		tween.tween_property($MainChar/PointLight2D, "energy", 1, 2)
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($DirectionalLight2D, "energy", 0, 2)
	tween.tween_property($MainChar/PointLight2D, "energy", 0, 2)
	await tween.finished
	$MainChar/PointLight2D.hide()
	pass # Replace with function body.
