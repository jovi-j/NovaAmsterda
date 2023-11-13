extends "res://Code/Characters/NPC/npc.gd"
class_name Ally

func _on_vision_area_body_entered(body):
	if body.is_in_group("enemies") and target == null:
		target = body
		$NavTimer.start()
	

func _on_vision_area_body_exited(body):
	if body.is_in_group("enemies") and target != null:
		target = null
		$NavTimer.stop()
