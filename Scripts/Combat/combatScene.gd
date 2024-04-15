class_name combatScene
extends Node2D

@onready var Player = get_tree().get_first_node_in_group("MiniPlayer")

func _process(_delta):
	$UI/HPBar.value = Player.health
