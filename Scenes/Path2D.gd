extends Path2D

var inc=0
var speed=500
func _ready():
	randomize()
	$"../MoveTimer".start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inc+=delta*speed
	


func _on_timer_timeout():
	$PathFollow2D.progress_ratio = randf()
