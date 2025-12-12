extends Node3D

@export var proof_name := "证物名"
@export var proof_description := "It smells spoiled."
@export var proof_id := "unique_id"

func _ready():
	add_to_group("proof")
