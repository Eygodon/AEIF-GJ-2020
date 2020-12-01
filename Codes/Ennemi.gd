extends KinematicBody2D

var PdV = 0
var vel = Vector2()
var Speed = 0
var dmg = 0
var cible 
var CdT
var cooldown = -1
var bounty
var bullet
var isT

func _ready():
	$Sprite.texture.set_flags(0)

func start(pos,pdv,speed,dmgs,Cdt,bn,isTank):
	position = pos
	PdV = pdv
	Speed = speed
	dmg = dmgs
	bounty = bn
	CdT = Cdt
	cible = get_parent().get_magasin()
	isT = isTank
	if(isTank):
		bullet = preload("res://Scenes/Roquette.tscn")
	else:
		bullet = preload("res://Scenes/Bullet.tscn")

func _physics_process(delta):
	vel = Vector2.ZERO
	vel = position.direction_to(cible.global_position) * Speed
	if cooldown <= 0 and CdT != 0:
		$Sound/Gun.play()
		var ligne_bullet = cible.global_position - $Sprite/Aim.global_position
		var rota = ligne_bullet.angle()
		cooldown = CdT
		var b = bullet.instance()
		if(isT):
			b.start($Sprite/Aim.global_position,rota,dmg,cible)
		else:
			b.start($Sprite/Aim.global_position,rota,dmg,false)
		get_parent().add_child(b)
	vel = move_and_slide(vel)
	$Sprite.look_at(cible.position)
	$Sprite.rotation_degrees += 90
	cooldown -= 1

func _on_DetectRadius_body_entered(body):
	if body.has_method("isPlayerBased") :
		cible = body

func _on_DetectRadius_body_exited(body):
	if(body == cible):
		cible = get_parent().get_magasin()

func isEnnemy():
	pass

func hit(dmgs):
	PdV -= dmgs
	if PdV <= 0 :
		queue_free()
		get_parent().give_player_money(bounty)
		get_parent().ennemie_died()

func _on_HitboxDmg_area_entered(area):
	if area.has_method("take_hit") :
		area.take_hit(dmg)


func _on_HitboxDmg_body_entered(body):
	if body.has_method("take_hit") :
		body.take_hit(dmg)
