extends StaticBody3D

@export var title: String
@export var description : String

func _ready() -> void:
	$Title.text = title
	$Title.hide()
	$Description.text = description
	$Description.hide()
	
	
func show_text():
	$Title.show()
	$Description.show()
	
func hide_text():
	$Title.hide()
	$Description.hide()
