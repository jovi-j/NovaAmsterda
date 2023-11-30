extends Control



func _on_iniciar_jogo_pressed():
	get_tree().change_scene_to_file("res://Scenes/Dialog/cap_1_prologo.tscn")

func _on_sair_pressed():
	get_tree().quit()
