extends KinematicBody2D
var speed = 1000
var vel = Vector2()
var damage
var searched_function = "hit"

func start(pos,dir,dmg,isEnnemy):
	rotation = dir
	position = pos
	damage = dmg
	vel = Vector2(speed, 0).rotated(rotation)
	if !isEnnemy:
		$Sprite.self_modulate = Color(1,0,0)
		set_collision_mask_bit(0, true)
		set_collision_mask_bit(1, false)
		searched_function = "take_hit"

func _ready():
	pass
	
func isBullet() :
	pass
	
func _process(delta):
	var collision = move_and_collide(vel * delta)
	if collision:
		if collision.collider.has_method(searched_function):
			if(searched_function == "hit"):
				collision.collider.hit(damage)
			else:
				collision.collider.take_hit(damage)
		queue_free()
	

