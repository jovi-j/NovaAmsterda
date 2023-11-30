extends GenericCharacter
class_name Player
signal making_noise(position)
signal is_dead
signal announcer_finished

@onready var arcabuz : Gun = $Arcabuz
@onready var reloadTimer : Timer = $Arcabuz/ReloadTimer
@onready var camera : Camera2DPlus = $Camera2DPlus
@onready var reloadBar : ProgressBar = %ReloadBar
@onready var bulletLabel : Label = $HUD/MarginContainer/HBox/LadoEsquerdo/Bullets
@onready var sprite : Sprite2D = $Sprite
@export var objetivoText : String


func set_objetivo_text(text):
	$HUD/MarginContainer/HBox/LadoDIreito/ObjText.text = text

func _ready():
	reloadBar.max_value = reloadTimer.wait_time
	reloadBar.value = 0.0
	reloadBar.self_modulate = Color(Color.WHITE, 0.0)
	set_objetivo_text(objetivoText)
	$HUD/AnimationPlayer.play("objetivo_pisca")
	
	
func hit():
	emit_signal("is_dead")
	set_collision_layer_value(1, false)
	$HUD/CenterContainer.visible = true
	sprite.texture = load("res://Assets/Sprites/Characters/Player/player_death.png")
	sprite.z_index = 0
	dead = true
	
func _physics_process(_delta):
	if not dead:
		if reloadBar.self_modulate == Color(Color.WHITE, 1.0):
			reloadBar.value = reloadTimer.wait_time - reloadTimer.time_left
		velocity = Input.get_vector("left", "right", "up", "down") * speed
		look_at(get_global_mouse_position())
		move_and_slide()
	
	
func _input(_event):
	if not dead:
		if Input.is_action_just_pressed("primary"):
			if arcabuz.can_shoot():
				arcabuz.shoot(4000, rotation_degrees)
				arcabuz.bullets -= 1
				bulletLabel.text = str(arcabuz.bullets)
				arcabuz.reloaded = false
				camera.add_shake(10)
				camera.flash(Color(Color("d53c6a"), 0.7), 0.1)
				reloadBar.value = 0.0
				$AudioStreamPlayer.play()
				emit_signal("making_noise", global_position)
		if Input.is_action_just_pressed("secondary") and not $AnimationPlayer.is_playing():
			$Espada.use()
		if Input.is_action_just_pressed("look"):
			$LookPoint.position = Vector2(800,0)
		if Input.is_action_just_released("look"):
			$LookPoint.position = Vector2(400,0)
		if Input.is_action_just_pressed("interact"):
			pass
		if Input.is_action_just_pressed("reload"):
			if not arcabuz.reloaded:
				reloadBar.self_modulate = Color(Color.WHITE, 1.0)
				arcabuz.start_timer()
		if Input.is_action_just_released("reload"):
			if not arcabuz.reloaded:
				arcabuz.stop_timer()
	else:
		if Input.is_action_just_pressed("reload"):
			restart_level()


func restart_level():
	get_parent().restart_level()

func objective_annoucer():
	$HUD/AnimationPlayer.play("objetivo_completo")
	
func _on_arcabuz_gun_ready():
	reloadBar.self_modulate = Color(Color.WHITE, 0.0)
	reloadBar.value = 0.0

func disorient():
	camera.add_shake(160)
	camera.flash(Color(Color("d53c6a"), 1), 1)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "objetivo_completo":
		emit_signal("announcer_finished")
