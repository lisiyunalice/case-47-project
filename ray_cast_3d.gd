extends RayCast3D

func get_look_at_proof():
	if $Camera3D/RayCast3D.is_colliding():
		var obj = $Camera3D/RayCast3D.get_collider()
		if obj.is_in_group("proof"):
			obj.showname()
			return obj
	return null
