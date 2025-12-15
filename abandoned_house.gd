extends Node3D  # 根节点

@export var LIGHT_ENERGY := 5.0
@export var LIGHT_RANGE := 4.0
@export var LIGHT_COLOR := Color(1, 0.85, 0.6) # 暖色
@export var LIGHT_HEIGHT_OFFSET := 0.2  # 光源离灯泡顶部的高度

@export var total_time := 600  # 10 minutes in seconds

var time_left : int

func _ready():
	for lamp in get_tree().get_nodes_in_group("Lamparas"):
		var light = OmniLight3D.new()
		light.energy = LIGHT_ENERGY
		light.range = LIGHT_RANGE
		light.light_color = LIGHT_COLOR

		# 将光源放在灯泡位置
		light.translation = Vector3(0, LIGHT_HEIGHT_OFFSET, 0)
		lamp.add_child(light)

	time_left = total_time
	start_timer()
		
func start_timer():
		var timer = Timer.new()
		timer.wait_time = 1.0
		timer.one_shot = false
		timer.autostart = true
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		
func _on_timer_timeout():
		if time_left > 0:
			time_left -= 1
		else:
			print("Time's up!")
			#get_tree().paused = true  # optional
			print("You killed him and left the house of madness. Police officers have been waiting for you. How can you explain the whole story to them?")
