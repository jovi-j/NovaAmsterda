extends Node


signal enemy_spawned(enemy : Enemy)

@export var n_of_enemies : int = 2
@onready var reachPoints : Array
@onready var spawnPoints : Array
@onready var spawnTimer : Timer = $SpawnTimer
var enemy = preload("res://Scenes/Characters/NPC/Enemy/enemy.tscn")

func _ready():
	reachPoints = $ReachPoints.get_children()
	spawnPoints = $SpawnPoints.get_children()
	spawn_enemy()
	
	
func spawn_enemy():
	if n_of_enemies <= 0:
		return
	var inst_enemy = enemy.instantiate()
	var num = randi_range(0,spawnPoints.size()-1)
	inst_enemy.reachPoint = reachPoints[num]
	inst_enemy.global_position = spawnPoints[num].global_position
	$Enemies.add_child(inst_enemy)
	emit_signal("enemy_spawned", inst_enemy)
	spawnTimer.start()
	n_of_enemies -= 1


func _on_spawn_timer_timeout():
	spawn_enemy()
