extends CanvasLayer

@onready var title_label = $ProofWindow/LabelTitle
@onready var desc_label = $ProofWindow/LabelDescription
@onready var window = $ProofWindow

func show_proof(data):
	title_label.text = data.proof_name
	desc_label.text = data.proof_description
	window.visible = true
