extends "res://Code/Stages/TileMap.gd"


var pegou_chave = false

func _ready():
	$Music.play(GlobalMusic.musicProgress)  

func _on_chave_body_entered(body):
	$Chave/Sprite2D.visible = false
	$Player.set_objetivo_text("Saia do forte sem ser visto.")
	$Area2D/Seta.visible = false
	pegou_chave = true


func _on_saida_body_entered(body):
	if pegou_chave:
		get_tree().change_scene_to_file("res://Scenes/Dialog/cutscene_3.tscn")
		
func restart_level():
	GlobalMusic.musicProgress = $Music.get_playback_position()
	get_tree().reload_current_scene()
	
