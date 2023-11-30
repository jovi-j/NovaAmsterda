extends Node2D


@export var n_of_enemies = 10

@export var nextScene : PackedScene


func _ready():
	$Music.play(GlobalMusic.musicProgress)
	
func check_objective():
	if n_of_enemies == 0:
		goto_next_scene()

func att_killcount():
	n_of_enemies -=1
	check_objective()
	
func goto_next_scene():
	get_tree().change_scene_to_packed(nextScene)

func _on_enemy_spawn_enemy_spawned(enemy):
	enemy.connect("is_dead", att_killcount)
	
func restart_level():
	GlobalMusic.musicProgress = $Music.get_playback_position()
	get_tree().reload_current_scene()

