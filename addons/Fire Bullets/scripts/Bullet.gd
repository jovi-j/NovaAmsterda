extends Area2D
class_name Bullet
## A node used for [Gun]
##
## This node is used for [Gun], acts like a bullet with configurable speed and angle( for gun )

@export_category("Bullet")

## The time in seconds where this bullet is deleted
@export var delete_after : int = 30

## speed of the bullet in pixels per second
var speed : float

## angle of the bullet when fired
var angle : float

## used to track time for [delete_after], best not to change it to avoid errors
var time = 0

func _physics_process(delta):
	rotation_degrees = angle
	position += (Vector2.from_angle(rotation) * speed) * delta
	time += delta
	if time >= delete_after:
		queue_free()

func _on_body_entered(body):
	# Pegou num inimigo
	if body.has_method("hit"):
		body.hit()
	# Parando a bala
	speed = 0
	delete_after = time + 1
		
		
		
