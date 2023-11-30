extends GenericCharacter

signal making_noise
signal is_dead

@onready var nav : NavigationAgent2D = $NavigationAgent2D
@onready var espada : Area2D = $Espada
@onready var hearingArea : Area2D = $HearingArea
@onready var visionArea : Area2D = $VisionArea
@onready var preAttackArea : Area2D = $PreAttackArea
@onready var animPlayer : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite
@onready var target : CharacterBody2D

@onready var reactionTimer : Timer = $ReactionTimer

@export var reachPoint : Marker2D

func remove_colisions():
	animPlayer.call_deferred('stop')
	reactionTimer.stop()
	espada.monitoring = false
	hearingArea.monitoring = false
	visionArea.monitoring = false
	preAttackArea.monitoring = false
	call_deferred('set_collision_layer_value', 2, false)
	call_deferred('set_collision_layer_value', 3, false)
	call_deferred('set_collision_mask_value', 1,false)
	call_deferred('set_collision_mask_value', 7,false)
	$NavTimer.stop()

func hit():
	dead = true
	emit_signal("is_dead")
	sprite.texture = load("res://Assets/Sprites/Characters/NPC/Enemy/enemy_death.png")
	sprite.z_index = 0
	remove_colisions()


func _ready():
	randomize()
	reactionTimer.wait_time = randf_range(0.19,0.29)
	if reachPoint != null:
		make_path(reachPoint.global_position)
		
func _physics_process(_delta):
	if not dead:
		if nav.is_navigation_finished():
			return
		if not reactionTimer.is_stopped():
			return
		var enemy_pos: Vector2 = global_position
		var next_path_pos = nav.get_next_path_position()
		look_at(next_path_pos)
		var new_vel = next_path_pos - enemy_pos
		new_vel = new_vel.normalized()
		new_vel = new_vel * speed
		velocity = new_vel
		move_and_slide()

func make_path(target_location):
	nav.target_position = target_location

func _on_reaction_timer_timeout():
	$AnimationPlayer.play("EspadaSwing")

func _on_pre_attack_area_body_entered(_body):
	$ReactionTimer.start()


func _on_nav_timer_timeout():
	if target != null:
		make_path(target.global_position)
