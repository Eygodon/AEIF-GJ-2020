extends ColorRect

func _on_AnimationPlayer_animation_finished(Fade_in):
	get_tree().change_scene("res://Scenes/Map.tscn")
