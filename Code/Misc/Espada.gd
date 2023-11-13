extends Area2D



func use():
	get_parent().get_node("AnimationPlayer").play("EspadaSwing")
