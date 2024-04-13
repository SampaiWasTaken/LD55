extends CharacterBody2D

@export var speed = 300
var canAct = true
var obj_bullet = preload("res://Scenes/CombatScenes/player_bullet.tscn")
var health = 100

func getInput():
	var input_direction = Input.get_vector("walkLeft", "walkRight", "walkUp", "walkDown")
	velocity = input_direction * speed

func _process(delta):
	if(Input.is_action_pressed("mainAttack") and canAct):
		canAct = false
		shoot(get_local_mouse_position().angle(), 600)
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
	print("Player Hit")
	if health <= 0:
		gameOver()
	
func shoot(direction: float, speed: float):
	var bullet = obj_bullet.instantiate()
	bullet.scale = Vector2(0.5, 0.5)
	bullet.position = $Marker2D.global_position
	bullet.rotation = direction
	bullet.velocity = Vector2(speed, 0).rotated(direction)
	$"../..".add_child(bullet)
	$".."/MoveCooldown.start()

func gameOver():
	pass
