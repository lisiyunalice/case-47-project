extends Node3D  # 根节点

@export var LIGHT_ENERGY := 5.0
@export var LIGHT_RANGE := 4.0
@export var LIGHT_COLOR := Color(1, 0.85, 0.6) # 暖色
@export var LIGHT_HEIGHT_OFFSET := 0.2  # 光源离灯泡顶部的高度

func _ready():
	for lamp in get_tree().get_nodes_in_group("Lamparas"):
		var light = OmniLight3D.new()
		light.energy = LIGHT_ENERGY
		light.range = LIGHT_RANGE
		light.light_color = LIGHT_COLOR

		# 将光源放在灯泡位置
		light.translation = Vector3(0, LIGHT_HEIGHT_OFFSET, 0)
		lamp.add_child(light)
