extends Node3D

@onready var name_label: Label3D = $name

func _ready():
	name_label.visible = false

func on_hover_enter():
	name_label.visible = true

func on_hover_exit():
	name_label.visible = false
