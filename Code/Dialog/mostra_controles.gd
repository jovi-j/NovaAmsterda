extends Control

@export var fase1 : PackedScene

func _input(_event):
	if Input.is_action_just_pressed("primary"):
		$AnimationPlayer.play_backwards("show")
		
		

	


func _on_animation_player_animation_finished(_anim_name):
	if $AnimationPlayer.current_animation_position == 0.0:
		get_tree().change_scene_to_packed(fase1)
