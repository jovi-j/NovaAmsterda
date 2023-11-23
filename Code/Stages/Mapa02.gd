extends "res://Code/Stages/TileMap.gd"


var pegou_chave = false



func _on_chave_body_entered(body):
	$Chave/Sprite2D.visible = false
	$Player.set_objetivo_text("Saia do forte sem ser visto.")
	pegou_chave = true


func _on_saida_body_entered(body):
	if pegou_chave:
		get_tree().reload_current_scene()
