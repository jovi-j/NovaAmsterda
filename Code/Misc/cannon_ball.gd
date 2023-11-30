extends Area2D
class_name CannonBall

var bodies_in_kill_area : Array
var bodies_in_shake_area : Array

func _ready():
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.pause()
	$CPUParticles2D.emitting = false
	$AnimationPlayer.play("Explosion")

func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_body_entered(body):
	if body.has_method('hit'):
		bodies_in_kill_area.append(body)
		

func _on_body_exited(body):
	if body in bodies_in_kill_area:
		bodies_in_kill_area.erase(body)
		
func explode():
	for b in bodies_in_shake_area:
		b.disorient()
	for b in bodies_in_kill_area:
		b.hit()


func _on_shake_area_body_entered(body):
	if body.has_method('disorient'):
		bodies_in_shake_area.append(body)
		

func _on_shake_area_body_exited(body):
	if body in bodies_in_shake_area:
		bodies_in_shake_area.erase(body)
		

