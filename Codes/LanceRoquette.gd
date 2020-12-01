extends KinematicBody2D

var PdV
var CdT 
var cooldown = 0
var bullet_dmg 
var bullet = preload("res://Scenes/Roquette.tscn")
var cible = null
var ligne_bullet
var rota
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture.set_flags(0)
	pass

func isPlayerBased():
	pass
	
	
func start(pos, pdv, dmg, cdt):
	position = pos
	PdV = pdv
	bullet_dmg = dmg
	CdT = cdt

func _physics_process(delta):
	cooldown -= 1
	if (cible != null) :
			$Sprite.look_at(cible.position)
			$Sprite.rotation_degrees += 80
			
		
	if cible != null and cooldown <= 0:
		ligne_bullet = cible.global_position - $Sprite/Aim.global_position
		rota = ligne_bullet.angle()
		cooldown = CdT
		var b = bullet.instance()
		b.start($Sprite/Aim.global_position,rota ,bullet_dmg, cible)
		get_parent().add_child(b)
	
	
	for i in range($TourelleAim.get_overlapping_bodies().size()) :
		if $TourelleAim.get_overlapping_bodies()[i].has_method("isEnnemy") :
			cible = $TourelleAim.get_overlapping_bodies()[i]
			
func take_hit(damage) :
		PdV -= damage
		 

func _on_TourelleAim_body_entered(body):
	if body.has_method("isEnnemy") :
		cible = body

func _on_TourelleAim_body_exited(body):
	if (body == cible) :
		cible =  null
