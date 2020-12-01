extends KinematicBody2D
var speed = 300
var vel = Vector2()
var damage
var target

func start(pos,dir,dmg,tar):
	rotation = dir
	position = pos
	damage = dmg
	$Roquette.rotation_degrees += 180
	target = tar.global_position

func _ready():
	pass
	
func isEnnemy() :
	pass
	
func EXPLODE():
	$Roquette.visible = false
	$Explosion.visible = true
	var touches = $ExplosionZone.get_overlapping_bodies()
	for i in range(touches.size()):
		if(touches[i].has_method("hit")):
			touches[i].hit(damage)
		elif (touches[i].has_method("take_hit")):
			touches[i].take_hit(damage)
	speed = 0
	damage = 0
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
	
func _process(delta):
	var collision = move_and_collide(Vector2(speed, 0).rotated(rotation) * delta)
	if target.is_equal_approx(position) :
		EXPLODE()
	elif collision:
		EXPLODE()
