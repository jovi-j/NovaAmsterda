extends Control

@onready var fotoPessoaTextureRect : TextureRect = $NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer/FotoPessoa
@onready var textoTela : RichTextLabel = $NinePatchRect/MarginContainer/HBoxContainer/MarginContainer/Texto
@onready var tituloPessoa : Label = $NinePatchRect/MarginContainer/HBoxContainer/VBoxContainer/NomePessoa
@export var nextScene : PackedScene

@export var fotos : Array

#fotos
enum {
	CAP=0,
	SL1=1,
	SL2=2
}


var can_go_to_next : bool = true

var dialogos = [
		Dialogo.new(CAP, "Rápido! Os holandeses estão atacando Natal, temos que defender o Forte. Avante!!! ", "Capitão Mor Gouveia"),
	 	Dialogo.new(SL1, "E os indígenas se aliaram a Keulen. Não sei se temos forças suficientes para enfrentá-los…", "Soldado"),
		Dialogo.new(CAP, "Se assim for, então esta é a hora de lutar e morrer em nome do seu rei, soldado. TODOS A POSTOS!!!", "Capitão Mor Gouveia") 
	]

var curr_dialogo = 0


func _ready():
	$AnimationPlayer.play("intro")
	
func _input(_event):
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("primary"):
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.advance(10)
		else:
			curr_dialogo += 1
			playDialogos()
		

func playDialogos():
	if curr_dialogo >= dialogos.size():
		get_tree().change_scene_to_packed(nextScene)
		return
	playText(dialogos[curr_dialogo].foto, dialogos[curr_dialogo].texto, dialogos[curr_dialogo].titulo)

	
func playText(fotoPessoa : int, texto: String, titulo : String):
	textoTela.text = texto
	fotoPessoaTextureRect.texture = fotos[fotoPessoa]
	tituloPessoa.text = titulo
	$AnimationPlayer.play("new_animation")
