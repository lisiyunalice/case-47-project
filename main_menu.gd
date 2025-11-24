extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_button_pressed() -> void:
	$SettingsPopup.popup_centered()

func _on_exit_pressed():
	get_tree().quit()
