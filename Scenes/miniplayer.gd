extends CharacterBody2D

@export var speed = 200
var canAct = true
var attack = preload("res://Scenes/player_bullet.tscn")
var health = 100

func getInput():
	var input_direction = Input.get_vector("walkLeft", "walkRight", "walkUp", "walkDown")
	velocity = input_direction * speed

func _process(delta):
	if(Input.is_action_pressed("action") and canAct):
		canAct = false
		var bullet = attack.instantiate()
		add_child(bullet)
		bullet.direction = Vector2(0, -1)
		bullet.rotation = Vector2(0, -1).angle()
		$".."/UI/CooldownBar.value = 0
		$".."/MoveCooldown.start()
	$".."/UI/CooldownBar.value += 100*delta

func _physics_process(_delta):
	getInput()
	move_and_slide()

	
func _on_move_cooldown_timeout():
	canAct = true
	
func hurt():
	health -= 10
	print("Ouch")
