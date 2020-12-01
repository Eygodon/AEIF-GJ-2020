extends KinematicBody2D

var PdVMax = 100
var PdV = 100
var kevlar = 0
var CdT = 16
var cooldown = 0
var nbBullet = 150
var bullet_dmg = 10
var argent = 40000000
var vel = Vector2()
var ACCEL = 50
var max_speed = 200
var mouse_pos 
var bullet = preload("res://Scenes/Bullet.tscn")
var shop = false

var shopTourelles = false
var areas = []

var footsteps = 0
var ded = false
var dedTime = 0

func _ready():
	$Sprite.texture.set_flags(0)

func get_Camera():
	return $Camera2D 

func in_Magasin():
	shop = !shop

func isPlayerBased():
	pass

func start(pos):
	PdV = PdVMax
	position = pos
	$CollisionShape2D.visible = true
	$Sprite.visible = true

func _physics_process(delta):
	hud()
	if !ded :
		areas = $Area2D.get_overlapping_areas()
		cooldown -= 1
		footsteps -= 1
		mouse_pos = get_global_mouse_position() # renvoie un vector2
		mouvement_loop()
		vel = move_and_slide(vel)
		$Sprite.look_at(mouse_pos)
		$Sprite.rotation_degrees += 80
	else :
		dedTime -= 1
		if(dedTime == 0):
			ded = false
			start(get_parent().get_Start_Point())
	
func hud():
	$Camera2D/HUD/Munitions.text = "Munitions : " + str(nbBullet)
	$Camera2D/HUD/Vie.text = "Vie : " + str(PdV) + "/" + str(PdVMax)
	$Camera2D/HUD/Protection.text = "Armure : " + str(kevlar)
	$Camera2D/HUD/Argent.text = "Argent : " + str(argent) + " $"
	$Camera2D/HUD/Argent.rect_position.x = 256 - $Camera2D/HUD/Argent.rect_size.x
	$Camera2D/HUD/Vagues.text = "Vague : " + str(get_parent().get_Vague())
	$Camera2D/HUD/Vagues.rect_position.x = 256 - $Camera2D/HUD/Argent.rect_size.x
	$Camera2D/HUD/Compteur.text = get_parent().get_compteur()
	$Camera2D/HUD/VieWal.text = get_parent().get_affichage_walmart()
	if(ded):
		$Camera2D/HUD/Ded.text = "Vous etes mort ! vous aller reapparaitre dans " + str(dedTime/60) + " !"
		$Camera2D/HUD/Ded.visible = true
	else:
		$Camera2D/HUD/Ded.visible = false

func mouvement_loop():
	var ligne_bullet = mouse_pos - $Sprite/Aim.global_position
	var rota = ligne_bullet.angle()
	
	var right = Input.is_action_pressed("Droite_J1")
	var left = Input.is_action_pressed("Gauche_J1")
	var up = Input.is_action_pressed("Haut_J1")
	var down = Input.is_action_pressed("Bas_J1")
	var shoot = Input.is_mouse_button_pressed(1)
	
	var dirx = int(right) - int(left)
	var diry = int(down) - int(up)
	var dir = 1
	
	if dirx == -1 : # GAUCHE 
		vel.x = max(vel.x - ACCEL, -max_speed)
		dir = -1
	elif dirx == 1 : # DROITE
		vel.x = min(vel.x + ACCEL, max_speed)
		dir = 1
	else : # Idle
		vel.x = lerp(vel.x, 0, 1)
		
	if diry == -1 : # GAUCHE
		vel.y = max(vel.y - ACCEL, -max_speed)
	elif diry == 1 : # DROITE
		vel.y = min(vel.y + ACCEL, max_speed)
	else : # Idle
		vel.y = lerp(vel.y, 0, 1)
	
	if((dirx != 0 or diry != 0) and footsteps <= 0):
		$Sound/FootSteps.play()
		footsteps = 15
	
	if shoot and cooldown <= 0 and nbBullet > 0 and !shop:
		$Sound/Gun.play()
		cooldown = CdT
		nbBullet -= 1
		var b = bullet.instance()
		b.start($Sprite/Aim.global_position,rota,bullet_dmg,true)
		get_parent().add_child(b)
		
func take_hit(damage) :
	$Sound/Get_Hit.play()
	if(kevlar > 0):
		if(kevlar - damage < 0):
			damage -= kevlar
			kevlar = 0
			PdV -= damage
		else :
			kevlar -= damage
	else:
		PdV -= damage
	if(PdV <= 0):
		$CollisionShape2D.visible = false
		$Sprite.visible = false
		ded = true
		dedTime = 5*60
