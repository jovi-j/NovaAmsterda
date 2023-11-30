extends Node


var points : Array[Marker2D] 
var cannon_ball : PackedScene = preload("res://Scenes/Misc/cannon_ball.tscn")
@onready var timer : Timer = $Timer

func _ready():
	randomize()
	for p in get_children():
		if p.is_class('Marker2D'):
			points.append(p)
	

func _on_timer_timeout():
	var point = points.pick_random()
	var another_point = points.pick_random()
	var cannonball_instance : CannonBall = cannon_ball.instantiate()
	cannonball_instance.global_position = point.global_position
	add_child(cannonball_instance)
	if randi_range(0,5) == 1:
		var another_cannonball_instance : CannonBall = cannon_ball.instantiate()
		another_cannonball_instance.global_position = another_point.global_position
		add_child(another_cannonball_instance)
	
