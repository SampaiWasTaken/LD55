extends Node2D

@export var Player: Node

func _process(_delta):
	$UI/HPBar.value = Player.health



