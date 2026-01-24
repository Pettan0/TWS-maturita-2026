extends CharacterBody3D

@onready var camera: Camera3D = $Head/Camera3D
@onready var pause_menu: Control = $Head/Camera3D/PauseMenu
@onready var walk: AudioStreamPlayer3D = $Walk
@onready var sprint: AudioStreamPlayer3D = $Sprint
@onready var jump_1: AudioStreamPlayer = $Jump1
@onready var animations: AnimationPlayer = $Head/animations
@onready var fov_animation: AnimationPlayer = $Head/FovAnimation




var pause = false


const SPEED = 4.0
const JUMP_VELOCITY = 3.0

func _ready():
	fov_animation.speed_scale = 3
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animations.play("Headbob")

func _pauseMenu():
	if pause:
		pause_menu.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		pause_menu.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pause = !pause


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		_pauseMenu()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * 0.002)
			camera.rotate_x(-event.relative.y * 0.002)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if !pause:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_1.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if !pause:
		if direction:
			if Input.is_action_pressed("sprint"):
				if camera.fov == 75:
					fov_animation.play("FovOut")
				if animations.speed_scale != 3.0:
					animations.speed_scale = 3.0
				velocity.x = direction.x * 1.5 * SPEED
				velocity.z = direction.z * 1.5 * SPEED
				if is_on_floor() and !sprint.playing:
					sprint.pitch_scale = randf_range(.8, 1.2)
					sprint.play()
			else: 
				if camera.fov == 85: 
					fov_animation.play("FovIn")
				if animations.speed_scale != 2.0:
					animations.speed_scale = 2.0
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
				if is_on_floor() and !walk.playing:
					walk.pitch_scale = randf_range(.8, 1.2)
					walk.play()
			
		else:
			if camera.fov == 85: 
				fov_animation.play("FovIn")
			if animations.speed_scale != 0.0:
				animations.speed_scale = 0.0
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)


	move_and_slide()
