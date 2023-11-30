extends Area2D



func use():
	get_parent().get_node("AnimationPlayer").play("EspadaSwing")
	get_parent().get_node("EspadaSom").play()
