extends Control

func _ready():
	$AnimationPlayer.play("Text")
	
	
func goto_next():
	get_tree().change_scene_to_file("res://Scenes/Dialog/cap_1_prologo.tscn")
