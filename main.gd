extends Node3D

@export var total_time := 600 # 10 minutes

@onready var timer_ui: Control = $CanvasLayer/TimerUI
@onready var countdown_label: Label = $CanvasLayer/TimerUI/CountdownLabel
@onready var death_ui: Control = $CanvasLayer/DeathUI
@onready var dialogue_ui = $CanvasLayer/DialogueUI

var time_left := 0.0
var counting := false

func _ready():
	# 一开始全部隐藏
	timer_ui.visible = false
	death_ui.visible = false

	# 监听 tutorial 对话结束
	dialogue_ui.dialogue_finished.connect(_on_tutorial_finished)

func _process(delta):
	if not counting:
		return

	time_left -= delta
	if time_left <= 0:
		time_left = 0
		counting = false
		on_time_up()

	update_countdown_label()

func _on_tutorial_finished():
	start_countdown()

func start_countdown():
	time_left = total_time
	timer_ui.visible = true
	counting = true
	update_countdown_label()

func update_countdown_label():
	var minutes := int(time_left) / 60
	var seconds := int(time_left) % 60
	countdown_label.text = "%02d:%02d" % [minutes, seconds]

func on_time_up():
	death_ui.visible = true
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://main_menu.tscn")

#
#extends Node3D
#
#@export var total_time := 600  # 10 minutes in seconds
#@onready var death_label: Label = $CanvasLayer/DeathUI
#
#func _ready():
 #$DeathUI.visible = false
 #await get_tree().create_timer(total_time).timeout
 #on_time_up()
  #
#func on_time_up():
 #$DeathUI.visible = true
 #await get_tree().create_timer(5.0).timeout
 #get_tree().quit()
 ##print("You eventually killed him and left the house of madness. Police officers have been waiting for you. How can you explain the whole story to them?")
