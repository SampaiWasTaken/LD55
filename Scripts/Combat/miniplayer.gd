extends CharacterBody2D

@export var speed = 300
@onready var animeSprite = $AnimatedSprite2D
var canAct = true
var obj_bullet = preload("res://Scenes/CombatScenes/player_bullet.tscn")
var health = 100

func getInput():
	var input_direction = Input.get_vector("walkLeft", "walkRight", "walkUp", "walkDown")
	if Input.is_action_pressed("walkRight"):
		animeSprite.play("walkRight")
	elif Input.is_action_pressed("walkLeft"):
		animeSprite.play("walkLeft")
	elif Input.is_action_pressed("walkUp"):
		animeSprite.play("walkUp")
	elif Input.is_action_pressed("walkDown"):
		animeSprite.play("walkDown")
	else:
		input_direction = Vector2.ZERO
		animeSprite.stop()
		animeSprite.frame = 0
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
	
func hurt(damage):
	health -= damage
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
	TransitionLayer.change_scene_with_dialog_after_change("res://Scenes/main_scene.tscn", "res://DialogText/Overworld/catEncounter.json")
	pass
