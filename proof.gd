extends Area3D

@export var proof_name: String
@export var proof_description: String
@export var proof_id: String


func _ready():
	add_to_group("proof")

func show_name():
	$name.text = proof_name
	$desc.text = proof_description
	$name.show()
	$desc.show()
