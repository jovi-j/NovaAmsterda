extends Line2D

@export var length: int = 50
var point = Vector2.ZERO


func _process(_delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	
	point = get_parent().global_position
	
	add_point(point)
	while get_point_count()>length:
		remove_point(0)


