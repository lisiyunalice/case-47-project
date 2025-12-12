extends CharacterBody3D

# --------------------
# Player Movement Settings
# --------------------
@export var SPEED := 20.0           # 地面最大速度
@export var ACCEL := 100.0         # 地面加速度
@export var IN_AIR_SPEED := 25.0    # 空中最大速度
@export var IN_AIR_ACCEL := 400.0   # 空中加速度
@export var JUMP_VELOCITY := 18.0   # 跳跃初速度

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
	# 这里检测按键（你可以改成鼠标左键之类）
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if raycast.is_colliding():
			var obj = raycast.get_collider()

			# 必须是 proof 组里的节点才处理
			if obj != null and obj.is_in_group("proof"):
				show_proof_window(obj)

# --------------------
func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation_target_player += -event.relative.x * MOUSE_SENS
		rotation_target_camera += -event.relative.y * MOUSE_SENS
		if CLAMP_HEAD_ROTATION:
			rotation_target_camera = clamp(rotation_target_camera, deg_to_rad(CLAMP_HEAD_ROTATION_MIN), deg_to_rad(CLAMP_HEAD_ROTATION_MAX))


	# ======================
	# 左键 → 打开证物说明
	# ======================
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_target:
			show_proof_window(current_target)

	# ======================
	# 证物窗口打开时 → 滚轮选择按钮
	# ======================
	if proof_window.visible:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				selected_button = 0
				update_button_visual()
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				selected_button = 1
				update_button_visual()

		# ======================
		# 右键 → 确认选项
		# ======================
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if selected_button == 0:
				record_current_proof()
				proof_window.hide()


# ========== 弹窗显示 ==========
func show_proof_window(obj):
	#proof_window.show()
	#label_title.text = obj.proof_name
	#label_desc.text = obj.proof_description
	##proof_window.metadata = obj    # 存当前打开的证物
	#selected_button = 0
	#update_button_visual()
	pass

# ========== 按钮视觉 ==========
func update_button_visual():
	button_record.modulate = Color.YELLOW if selected_button == 0 else Color.WHITE
	button_skip.modulate   = Color.YELLOW if selected_button == 1 else Color.WHITE


# ========== 记录证物 ==========
func record_current_proof():
	var obj = proof_window.metadata
	if obj == null:
		return
	
	var id = obj.proof_id
	
	# 不重复
	if id in collected_proofs:
		return

	# 超过3个 → FIFO 移除最前
	if collected_proofs.size() >= 3:
		collected_proofs.pop_front()

	collected_proofs.append(id)
	update_proof_slots()

# ========== 更新证物栏显示 ==========
func update_proof_slots():
	for i in range(3):
		var slot = proof_slots.get_child(i)
		if i < collected_proofs.size():
			var id = collected_proofs[i]
			if id in proof_icon_dict:
				slot.texture = proof_icon_dict[id]
			else:
				slot.texture = null
		else:
			slot.texture = null
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
			
			
			
	#raycast


# ========== 证物栏相关 ==========
var collected_proofs: Array = []    # 存放 proof_id
var proof_icon_dict = {}            # 你以后再加图标

@onready var raycast = $Camera3D/RayCast3D                         # 注意：在 CharacterBody3D 下
@onready var crosshair = $"../CanvasLayer/crosshair"         # CanvasLayer 是 CharacterBody3D 的兄弟节点
@onready var proof_window = $"../CanvasLayer/ProofWindow"
@onready var label_title = $"../CanvasLayer/ProofWindow/LabelTitle"
@onready var label_desc = $"../CanvasLayer/ProofWindow/LabelDescription"
@onready var button_record = $"../CanvasLayer/ProofWindow/Buttons/Buttonrecord"
@onready var button_skip = $"../CanvasLayer/ProofWindow/Buttons/Buttonskip"
@onready var proof_slots = $"../CanvasLayer/proofslots"      # HBoxContainer
@onready var label_name = $"../CanvasLayer/LabelProofName"

var current_target = null
var selected_button := 0   # 0 = 记录, 1 = 不记录

# ========== 每帧检测 ==========
func _process(_delta):
	current_target = get_look_at_proof()
	update_crosshair(current_target)
	update_proof_label(current_target)

# ========== 射线检测函数（安全检查） ==========
func get_look_at_proof():
	if raycast == null:
		return null
	if not raycast.is_enabled():
		return null
	if raycast.is_colliding():
		var obj = raycast.get_collider()
		if obj and obj.is_in_group("proof"):
			return obj
		return null
		

# ========== 准心高亮 ==========
func update_crosshair(target):
	if target:
		crosshair.modulate = Color(1, 1, 0.6)
	else:
		crosshair.modulate = Color.WHITE

# ========== 浮动标签 ==========
func update_proof_label(target):
	var label_name = $"../CanvasLayer/LabelProofName" if has_node("../CanvasLayer/LabelProofName") else null
	if label_name == null:
		return
	if target:
		var screen_pos = $Camera3D.unproject_position(target.global_transform.origin)
		label_name.text = target.proof_name if target.has_method("get") or target.has_variable("proof_name") else "证物"
		label_name.position = screen_pos + Vector2(0, -40)
		label_name.show()
	else:
		label_name.hide()
