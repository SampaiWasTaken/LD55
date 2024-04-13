extends CharacterBody2D

@export var speed = 200

func getInput():
	var input_direction = Input.get_vector("walkLeft", "walkRight", "walkUp", "walkDown")
	velocity = input_direction * speed

func _physics_process(_delta):
	getInput()
	move_and_slide()
