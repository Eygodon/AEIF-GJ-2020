extends Node2D

var Joueur = preload("res://Scenes/Joueur.tscn")
var SansArmes = preload("res://Scenes/SansArmes.tscn")
var PasChaud = preload("res://Scenes/MecPasCho.tscn")
var Mec_cho = preload("res://Scenes/Mec_Cho.tscn")
var Police = preload("res://Scenes/Police.tscn")
var armee_soldat = preload("res://Scenes/Armee_soldat.tscn")
var armee_tank = preload("res://Scenes/Armee_cehicule.tscn")
var J
var Sans
var PaCho
var Cho
var poulet
var conde
var tank
var vague = 1
var SpawnLst : Array = []

func get_Vague():
	return "infinity"

func get_compteur():
	return "Test mode"

func give_player_money(amount):
	J.argent += amount

func get_magasin():
	return $Magasin

func ennemie_died():
	pass

func _ready():
	randomize()
	J = Joueur.instance()
	Sans = SansArmes.instance()
	PaCho = PasChaud.instance()
	Cho = Mec_cho.instance()
	poulet = Police.instance()
	conde = armee_soldat.instance()
	tank = armee_tank.instance()
	SpawnLst.append($SpawnEnnemis1)
	SpawnLst.append($SpawnEnnemis2)
	SpawnLst.append($SpawnEnnemis3)
	SpawnLst.append($SpawnEnnemis4)
	add_child(J)
	add_child(Sans)
	add_child(PaCho)
	add_child(Cho)
	add_child(poulet)
	add_child(conde)
	add_child(tank)
	J.start($SpawnJoueur.global_position)
	Sans.start(SpawnLst[randi()%4].global_position,20,50,5,0,50,false)
	PaCho.start(SpawnLst[randi()%4].global_position,30,50,10,0,75,false)
	Cho.start(SpawnLst[randi()%4].global_position,50,50,15,120,150,false)
	poulet.start(SpawnLst[randi()%4].global_position,100,50,15,105,300,false)
	conde.start(SpawnLst[randi()%4].global_position,200,50,20,90,600,false)
	tank.start(SpawnLst[randi()%4].global_position,500,50,20,90,1200,true)

func _process(delta):
	pass
