extends CharacterBody3D

# --------------------
# Player Movement Settings
# --------------------
@export var SPEED := 20.0           # 地面最大速度
@export var ACCEL := 100.0         # 地面加速度
@export var IN_AIR_SPEED := 25.0    # 空中最大速度
@export var IN_AIR_ACCEL := 400.0   # 空中加速度
@export var JUMP_VELOCITY := 12.0   # 跳跃初速度

# --------------------
# Gravity Settings
# --------------------
@export var GRAVITY := 400.0

# --------------------
# Input Actions
# --------------------
@export var KEY_BIND_UP := "ui_up"       # W
@export var KEY_BIND_DOWN := "ui_down"   # S
@export var KEY_BIND_LEFT := "ui_left"   # A
@export var KEY_BIND_RIGHT := "ui_right" # D
@export var KEY_BIND_JUMP := "ui_accept" # 空格

# --------------------
# Mouse Settings
# --------------------
@export var MOUSE_SENS := 0.005
@export var MOUSE_ACCEL := true
@export var MOUSE_ACCEL_FACTOR := 50
@export var CLAMP_HEAD_ROTATION := true
@export var CLAMP_HEAD_ROTATION_MIN := -90.0
@export var CLAMP_HEAD_ROTATION_MAX := 90.0

# --------------------
# Internal variables
# --------------------
var rotation_target_player := 0.0
var rotation_target_camera := 0.0

# --------------------
func _ready():
	# 鼠标捕获
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# --------------------
func _physics_process(delta):
	move_player(delta)
	rotate_player(delta)

# --------------------
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation_target_player += -event.relative.x * MOUSE_SENS
		rotation_target_camera += -event.relative.y * MOUSE_SENS
		if CLAMP_HEAD_ROTATION:
			rotation_target_camera = clamp(rotation_target_camera, deg_to_rad(CLAMP_HEAD_ROTATION_MIN), deg_to_rad(CLAMP_HEAD_ROTATION_MAX))

# --------------------
func move_player(delta):
	var current_speed = SPEED if is_on_floor() else IN_AIR_SPEED
	var current_accel = ACCEL if is_on_floor() else IN_AIR_ACCEL

	# Apply gravity
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta

	# Jump
	if is_on_floor() and Input.is_action_just_pressed(KEY_BIND_JUMP):
		velocity.y = JUMP_VELOCITY

	# Input direction
	var input_dir = Input.get_vector(KEY_BIND_LEFT, KEY_BIND_RIGHT, KEY_BIND_UP, KEY_BIND_DOWN)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Smooth acceleration
	var target_velocity = direction * current_speed
	velocity.x = move_toward(velocity.x, target_velocity.x, current_accel * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, current_accel * delta)

	move_and_slide()

# --------------------
func rotate_player(delta):
	# Player rotates around Y
	if MOUSE_ACCEL:
		quaternion = quaternion.slerp(Quaternion(Vector3.UP, rotation_target_player), MOUSE_ACCEL_FACTOR * delta)
	else:
		quaternion = Quaternion(Vector3.UP, rotation_target_player)

	# Camera rotates X (pitch)
	var camera = get_node_or_null("Camera3D")
	if camera:
		if MOUSE_ACCEL:
			camera.quaternion = camera.quaternion.slerp(Quaternion(Vector3.RIGHT, rotation_target_camera), MOUSE_ACCEL_FACTOR * delta)
		else:
			camera.quaternion = Quaternion(Vector3.RIGHT, rotation_target_camera)
