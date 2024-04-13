extends Path2D

var inc=0
var speed=0.4
func _ready():
	randomize()
	$"../MoveTimer".start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inc+=delta*speed
	$PathFollow2D.progress_ratio = inc
