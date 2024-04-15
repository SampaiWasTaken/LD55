extends Node2D

func _ready():
	$MainChar.position = Globals.overworld_player_pos
	var mat1 = load("res://Scenes/shader test/2dShadowShaderMat.tres")
	var mat2 = load("res://Scenes/shader test/2dShadowShaderMat2.tres")
	var trees = $Trees.get_children()
	for tree in trees:
		if tree.scale.y < 0:
			tree.material = mat1
		else:
			tree.material = mat2

