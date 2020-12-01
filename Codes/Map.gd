extends Node2D

var Joueur = preload("res://Scenes/Joueur.tscn")
var SansArmes = preload("res://Scenes/SansArmes.tscn")
var PasChaud = preload("res://Scenes/MecPasCho.tscn")
var Mec_cho = preload("res://Scenes/Mec_Cho.tscn")
var Police = preload("res://Scenes/Police.tscn")
var armee_soldat = preload("res://Scenes/Armee_soldat.tscn")
var armee_tank = preload("res://Scenes/Armee_cehicule.tscn")
var TourelleAuto = preload("res://Scenes/TourelleAuto.tscn")
var LanceRoquette = preload("res://Scenes/Lance-Roquette.tscn")
var J
var T
var vague = 4

var SpawnLst = []
var Ennemies = []
var NbEnnemies = 0
var TdP = 0
var Mistemps = false
var Shop = false
var ShopTourelle = false

func get_Vague():
	return vague
	
func get_Start_Point():
	return $SpawnJoueur.global_position
	
func get_compteur():
	var retour
	if(TdP > 0):
		retour = "Il vous reste " + str(TdP/60) + " avant la pochaine vague"
	else :
		retour = "Ennemis restant : " + str(NbEnnemies)
	return retour

func give_player_money(amount):
	J.argent += amount

func get_magasin():
	return $Magasin

func ennemie_died():
	NbEnnemies -= 1

func get_affichage_walmart():
	return "Walmart : " + str($Magasin/ZoneMagasin.PdV) + "/" + str($Magasin/ZoneMagasin.PdVMax)

func game_over():
	$Sound/Music_de_la_loose.play()
	$TileMap.visible = false
	J.visible = false
	J.get_Camera().current = false
	$Menu_de_la_loose.visible = true
	$Menu_de_la_loose/Label2.text = "Vous avez survecu " + str(vague) + " vagues !"

func _ready():
	J = Joueur.instance()
	add_child(J)
	J.start($SpawnJoueur.global_position)
	SpawnLst.append($SpawnEnnemiesS)
	SpawnLst.append($SpawnEnnemiesN)
	SpawnLst.append($SpawnEnnemiesE)
	SpawnLst.append($SpawnEnnemiesW)

func Spawn_Ennemies(x):
	$Sound/Combat_Music.play()
	$Sound/Chill_Music.playing = false
	randomize()
	match x :
		1:
			NbEnnemies += 20
			Ennemies = []
			for i in range(NbEnnemies):
				Ennemies.append(SansArmes.instance())
				add_child(Ennemies[i])
				Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
				yield(get_tree().create_timer(1.0), "timeout")
		2:
			NbEnnemies += 25
			Ennemies = []
			var nbPasCho = 0
			var nbSansArmes = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 10) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(SansArmes.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
						nbSansArmes += 1
				else :
					if (nbSansArmes <= 15) :
						Ennemies.append(SansArmes.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					yield(get_tree().create_timer(1.0), "timeout")
		3:
				NbEnnemies += 35
				Ennemies = []
				var nbPasCho = 0
				var nbSansArmes = 0
				for i in range(NbEnnemies):
					if ((randi()%100)/2) == 0  :
						if (nbPasCho <= 17) :
							Ennemies.append(PasChaud.instance())
							add_child(Ennemies[i])
							Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
							nbPasCho += 1
						else :
							Ennemies.append(SansArmes.instance())
							add_child(Ennemies[i])
							Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
							nbSansArmes += 1
					else :
						if (nbSansArmes <= 18) :
							Ennemies.append(SansArmes.instance())
							add_child(Ennemies[i])
							Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
						else :
							Ennemies.append(PasChaud.instance())
							add_child(Ennemies[i])
							Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
							nbPasCho += 1
					yield(get_tree().create_timer(1.0), "timeout")
		4:
			NbEnnemies += 45
			Ennemies = []
			var nbPasCho = 0
			var nbSansArmes = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 30) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(SansArmes.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
						nbSansArmes += 1
				else :
					if (nbSansArmes <= 15) :
						Ennemies.append(SansArmes.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
				yield(get_tree().create_timer(1.0), "timeout")				
		5:
			NbEnnemies += 50
			Ennemies = []
			var nbPasCho = 0
			var nbMecCho = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 40) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
						nbMecCho += 1
				else :
					if (nbMecCho <= 10) :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
				yield(get_tree().create_timer(1.0), "timeout")
		6:
			NbEnnemies += 75
			Ennemies = []
			var nbPasCho = 0
			var nbMecCho = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 60) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
						nbMecCho += 1
				else :
					if (nbMecCho <= 15) :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
				yield(get_tree().create_timer(1.0), "timeout")
		7:
			NbEnnemies += 100
			Ennemies = []
			var nbPasCho = 0
			var nbMecCho = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 60) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
						nbMecCho += 1
				else :
					if (nbMecCho <= 40) :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
				yield(get_tree().create_timer(1.0), "timeout")
		8:
			NbEnnemies += 150
			Ennemies = []
			var nbPasCho = 0
			var nbMecCho = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 50) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
						nbMecCho += 1
				else :
					if (nbMecCho <= 100) :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
				yield(get_tree().create_timer(1.0), "timeout")
		9:
			NbEnnemies += 175
			Ennemies = []
			var nbPasCho = 0
			var nbMecCho = 0
			for i in range(NbEnnemies):
				if ((randi()%100)/2) == 0  :
					if (nbPasCho <= 30) :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
					else :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
						nbMecCho += 1
				else :
					if (nbMecCho <= 125) :
						Ennemies.append(Mec_cho.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
					else :
						Ennemies.append(PasChaud.instance())
						add_child(Ennemies[i])
						Ennemies[i].start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
						nbPasCho += 1
				yield(get_tree().create_timer(1.0), "timeout")

func _process(delta):
	var use = Input.is_action_pressed("Utiliser_J1")
	if(TdP == 0):
		vague += 1
		Spawn_Ennemies(vague)
	if(NbEnnemies <= 0 and TdP <= 0):
		Mistemps = true
	if(Mistemps):
		$Magasin/ZoneMagasin.PdV = $Magasin/ZoneMagasin.PdVMax
		TdP = 1800
		$Sound/Combat_Music.playing = false
		$Sound/Chill_Music.play()
		Mistemps = false
	if(TdP > 0 and use and Shop and !$Menu_Shop.is_visible_in_tree()):
		$Menu_Shop.visible = true
		$Menu_Shop/Camera2D.current = true
		J.get_Camera().current = false
		J.get_Camera().visible = false
		J.in_Magasin()
	if($Menu_Shop.is_visible_in_tree() and Input.is_key_pressed(KEY_ESCAPE)):
		$Menu_Shop.visible = false
		$Menu_Shop/Camera2D.current = false
		J.get_Camera().current = true
		J.get_Camera().visible = true
		J.in_Magasin()

	if($Menu_Shop.is_visible_in_tree()):
		$Menu_Shop/Titre6.text = "Vous avez " + str(J.argent) + " $"

	if(J.PdV == J.PdVMax):
		$Menu_Shop/Titre5/VieMax.disabled = true
	else:
		$Menu_Shop/Titre5/VieMax.disabled = false
	if(J.kevlar >= 50):
		$"Menu_Shop/Titre3/Kevlar 4".disabled = true
		if(J.kevlar >= 100):
			$"Menu_Shop/Titre3/Kevlar 3".disabled = true
			if(J.kevlar >= 150):
				$"Menu_Shop/Titre3/Kevlar 2".disabled = true
				if(J.kevlar >= 200):
					$"Menu_Shop/Titre3/Kevlar 1".disabled = true
				else:
					$"Menu_Shop/Titre3/Kevlar 1".disabled = false
			else:
				$"Menu_Shop/Titre3/Kevlar 2".disabled = false
		else :
			$"Menu_Shop/Titre3/Kevlar 3".disabled = false
	else :
		$"Menu_Shop/Titre3/Kevlar 4".disabled = false
	if(TdP > 0 and use and ShopTourelle and !$Menu_Tourelles.is_visible_in_tree()):
		$Menu_Tourelles.visible = true
		$Menu_Tourelles/Camera2D2.current = true
		J.get_Camera().current = false
		J.get_Camera().visible = false
		J.in_Magasin()
	if($Menu_Tourelles.is_visible_in_tree() and Input.is_key_pressed(KEY_ESCAPE)):
		$Menu_Tourelles.visible = false
		$Menu_Tourelles/Camera2D2.current = false
		J.get_Camera().current = true
		J.get_Camera().visible = true
		J.in_Magasin()
	TdP -= 1

func _on_ZoneMagasin_body_entered(body):
	if(body.has_method("isPlayerBased")):
		Shop = true
	elif (body.has_method("isBullet")) :
		$Magasin/ZoneMagasin.take_hit(body.damage)

func _on_ZoneMagasin_body_exited(body):
	if(body.has_method("isPlayerBased")):
		Shop = false

func _on_Mun_pressed():
	if(J.argent >= 500):
		$Sound/Kashing.play()
		J.argent -= 500
		J.nbBullet += 50
	else:
		$Sound/Nope.play()

func _on_Mun2_pressed():
	if(J.argent >= 900):
		$Sound/Kashing.play()
		J.argent -= 900
		J.nbBullet += 100
	else:
		$Sound/Nope.play()

func _on_Mun3_pressed():
	if(J.argent >= 4000):
		$Sound/Kashing.play()
		J.argent -= 4000
		J.nbBullet += 500
	else:
		$Sound/Nope.play()

func _on_Kevlar_1_pressed():
	if(J.argent >= 500 and J.kevlar < 200):
		$Sound/Kashing.play()
		J.argent -= 500
		if(J.kevlar + 50 > 200):
			J.kevlar = 200
		else:
			J.kevlar += 50
	else:
		$Sound/Nope.play()

func _on_Kevlar_2_pressed():
	if(J.argent >= 1000 and J.kevlar < 200):
		$Sound/Kashing.play()
		J.argent -= 1000
		if(J.kevlar + 100 > 200):
			J.kevlar = 200
		else:
			J.kevlar += 100
	else:
		$Sound/Nope.play()

func _on_Kevlar_3_pressed():
	if(J.argent >= 1500 and J.kevlar < 200):
		$Sound/Kashing.play()
		J.argent -= 1500
		if(J.kevlar + 150 > 200):
			J.kevlar = 200
		else:
			J.kevlar += 150
	else:
		$Sound/Nope.play()

func _on_Kevlar_4_pressed():
	if(J.argent >= 2000 and J.kevlar < 200):
		$Sound/Kashing.play()
		J.argent -= 2000
		if(J.kevlar + 200 > 200):
			J.kevlar = 200
		else:
			J.kevlar += 200
	else:
		$Sound/Nope.play()

func _on_VieMax_pressed():
	if(J.argent >= 500):
		$Sound/Kashing.play()
		J.argent -= 500
		J.PdV = J.PdVMax
	else:
		$Sound/Nope.play()

func _on_DegatsUp_pressed():
	if(J.argent >= 500 and J.bullet_dmg <= 100):
		$Sound/Kashing.play()
		J.argent -= 500
		J.bullet_dmg += 5
		if(J.bullet_dmg == 100):
			$Menu_Shop/Titre4/DegatsUp.disabled = true
	else:
		$Sound/Nope.play()

func _on_CadenceDeTirUp_pressed():
	if(J.argent >= 500 and J.CdT >= 8):
		$Sound/Kashing.play()
		J.argent -= 500
		J.CdT -= 2
		if(J.CdT == 8):
			$Menu_Shop/Titre4/CadenceDeTirUp.disabled = true
	else:
		$Sound/Nope.play()


func _on_SanteUp_pressed():
	if(J.argent >= 500 and J.PdVMax <= 200):
		$Sound/Kashing.play()
		J.argent -= 500
		J.PdVMax += 25
		if(J.PdVMax == 200):
			$Menu_Shop/Titre4/SanteUp.disabled = true
	else:
		  $Sound/Nope.play()


func _on_BuyTourelles_pressed():
	if (J.argent >= 550 and ShopTourelle) :
		$Sound/Kashing.play()
		J.argent -= 550
		T = TourelleAuto.instance()
		add_child(T)
		T.start(J.areas[0].global_position, 100, 20, 16)
	elif (J.argent < 550) :
		$Menu_Tourelles/TourelleAuto/BuyTourelles.disabled=true
		$Sound/Nope.play()


func _on_BuyRoquettes_pressed():
	if (J.argent >= 1000 and ShopTourelle) :
		$Sound/Kashing.play()
		J.argent -= 1000
		T = LanceRoquette.instance()
		add_child(T)
		T.start(J.areas[0].global_position, 200, 100, 5*60)
	elif (J.argent < 1000) :
		$Menu_Tourelles/TourelleAuto/BuyTourelles.disabled=true
		$Sound/Nope.play()


func _on_ZoneMagasinTourelles_body_entered(body):
	if(body.has_method("isPlayerBased")) :
		ShopTourelle = true
	

func _on_ZoneMagasinTourelles_body_exited(body):
	if(body.has_method("isPlayerBased")) :
		ShopTourelle = false
