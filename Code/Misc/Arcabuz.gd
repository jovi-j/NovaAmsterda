extends Gun

signal gun_ready
var reloaded = true
@export var bullets = 5

func can_shoot():
	return reloaded and bullets > 0
	
	
func start_timer():
	if $ReloadTimer.paused:
		$ReloadTimer.paused = false
	else:
		$ReloadTimer.start()
	
func stop_timer():
	$ReloadTimer.paused = true
	
	
func _on_reload_timer_timeout():
	emit_signal("gun_ready")
	reloaded = true
	
