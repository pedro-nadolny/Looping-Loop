extends Sprite2D

var acc_delta = 0.0
func _process(delta):
	acc_delta += delta

	if acc_delta > 1:
		rotation += PI/2
		acc_delta -= 1
