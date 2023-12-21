extends Node2D


@export var n_of_enemies = 2

@export var nextScene : PackedScene


func _ready():
	$Music.play(GlobalMusic.musicProgress)
	$StartAndEnd/AnimationPlayer.play("start")
	
func check_objective():
	if n_of_enemies == 0:
		goto_next_scene()

func att_killcount():
	n_of_enemies -=1
	check_objective()
	
func goto_next_scene():
	$StartAndEnd/AnimationPlayer.play("end")

func _on_enemy_spawn_enemy_spawned(enemy):
	enemy.connect("is_dead", att_killcount)
	
func restart_level():
	GlobalMusic.musicProgress = $Music.get_playback_position()
	get_tree().reload_current_scene()



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "end":
		get_tree().change_scene_to_packed(nextScene)
