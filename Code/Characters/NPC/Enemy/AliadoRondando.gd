extends Enemy


@export var reachPoints : Array[Marker2D]
var curr_point = 0

@onready var nextPointTimer : Timer = $NextPointTimer

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
	nextPointTimer.stop()

func hit():
	dead = true
	emit_signal("is_dead")
	remove_colisions()


func _ready():
	randomize()
	reactionTimer.wait_time = 0.01
	make_path(reachPoints[curr_point].global_position)
	
		
func _physics_process(_delta):
	if not dead:
		if nav.is_navigation_finished():
			if target == null and nextPointTimer.is_stopped():
				nextPointTimer.start()
			else:
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
		
func inc_curr_point():
	if curr_point+1 >= reachPoints.size():
		curr_point = 0
	else:
		curr_point += 1

func make_path(target_location):
	nav.target_position = target_location

func _on_reaction_timer_timeout():
	$AnimationPlayer.play("EspadaSwing")

func _on_pre_attack_area_body_entered(_body):
	$ReactionTimer.start()

func _on_nav_timer_timeout():
	if target != null and is_target_visible(target):
		make_path(target.global_position)
		target.hit()
		
func _on_next_point_timer_timeout():
	if target == null:
		inc_curr_point()
		make_path(reachPoints[curr_point].global_position)
		
func _on_vision_area_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("alies") and target == null:
		target = body
		$NavTimer.start()
		
func is_target_visible(target: Node2D):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result != null and result.collider.is_in_group("player"):
		return true
	return false

