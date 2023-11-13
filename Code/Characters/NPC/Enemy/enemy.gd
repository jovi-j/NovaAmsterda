extends "res://Code/Characters/NPC/npc.gd"
class_name Enemy

func hit():
	dead = true
	emit_signal("is_dead")
	$Sprite.texture = load("res://Assets/Sprites/Characters/NPC/Enemy/enemy_death.png")
	remove_colisions()

# areas
func _on_hearing_area_body_entered(body):
	if body.is_in_group("player"):
		body.connect("making_noise", make_path)
		
func _on_hearing_area_body_exited(body):
	if body.is_in_group("player"):
		body.disconnect("making_noise", make_path)

func _on_vision_area_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("alies") and target == null:
		target = body
		$NavTimer.start()

func _on_vision_area_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("alies") and target != null:
		target = null
		$NavTimer.stop()
		


