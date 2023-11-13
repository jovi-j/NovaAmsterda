extends Node2D


@onready var n_of_enemies : int = 2

@export var nextScene : PackedScene

func check_objective():
	if n_of_enemies == 0:
		get_tree().change_scene_to_packed(nextScene)

func att_killcount():
	n_of_enemies -=1
	check_objective()


func _on_enemy_spawn_enemy_spawned(enemy):
	enemy.connect("is_dead", att_killcount)
