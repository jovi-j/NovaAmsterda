extends Node

class_name Dialogo

var foto : int
var texto : String
var titulo : String


func _init(_foto : int, _texto : String, _titulo : String):
	foto = _foto
	texto = _texto
	titulo = _titulo
	

func getTexto() -> String:
	return texto
	
func getFoto() -> int:
	return foto
