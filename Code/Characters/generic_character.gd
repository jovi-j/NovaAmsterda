extends CharacterBody2D
class_name GenericCharacter

@export var speed = 400
var dead = false


func hit():
	pass
	


func _on_espada_body_entered(body):
	if body.has_method("hit"):
		body.hit()
