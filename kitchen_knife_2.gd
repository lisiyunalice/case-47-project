extends MeshInstance3D

@export var proof_name := "Knife"
@export var proof_description := "A meticulously sharpened kitchen knife."
@export var proof_id := "unique_id"

func _ready():
	add_to_group("proof")
