extends MeshInstance3D

@export var proof_name := "证物名"
@export var proof_description := "Freshly boiled water still gives off steam when the lid is lifted."
@export var proof_id := "unique_id"

func _ready():
	add_to_group("proof")
