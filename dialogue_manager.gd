extends Control

signal dialogue_finished

@onready var name_label: Label = $Panel/NameLabel
@onready var dialogue_label: Label = $Panel/DialogueLabel
@onready var portrait_npc: TextureRect = $PortraitNPC

var lines: Array = []
var index: int = 0
var player: CharacterBody3D = null
var active := false

func _ready():
	visible = false

func start(dialogue_lines: Array, player_ref: CharacterBody3D) -> void:
	lines = dialogue_lines
	index = 0
	player = player_ref
	active = true
	visible = true

	if player:
		player.set_dialogue_mode(true)

	show_line()

func _input(event):
	if not active:
		return

	if event.is_action_pressed("ui_focus_next"):
		next_line()

func show_line() -> void:
	if index >= lines.size():
		end_dialogue()
		return

	var line = lines[index]
	var speaker = line["speaker"]
	var text = line["text"]

	dialogue_label.text = text

	if speaker == "Kamura":
		name_label.text = "Kamura"
		portrait_npc.visible = true
	else:
		name_label.text = "You"
		portrait_npc.visible = false

func next_line() -> void:
	index += 1
	show_line()

func end_dialogue() -> void:
	active = false
	visible = false
	hide()
	emit_signal("dialogue_finished")

	if player:
		player.set_dialogue_mode(false)

	player = null
	
