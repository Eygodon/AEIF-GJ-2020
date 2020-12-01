extends Control

func _ready():
	pass 

func _on_Button_pressed():
	$Sound/Ok.play()
	$FadeIn/AnimationPlayer.play("Fade_in")
