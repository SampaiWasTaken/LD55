extends Node2D

@export var Player: Node

func _process(delta):
	$UI/HPBar.value = Player.health



