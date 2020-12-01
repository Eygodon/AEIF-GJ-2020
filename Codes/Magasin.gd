extends Area2D

var PdV = 5000
var PdVMax = 5000

func isPlayerBased():
	pass

func take_hit(damage):
	PdV -= damage
	if(PdV <= 0):
		get_parent().game_over()

func _ready():
	pass 
