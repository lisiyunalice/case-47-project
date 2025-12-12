extends MeshInstance3D

@export var proof_name := "证物名"
@export var proof_description := "There were also some half-cut pieces of red meat, clinging to yellowish-white fat."
@export var proof_id := "unique_id"

func _ready():
	add_to_group("proof")
