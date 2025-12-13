extends RayCast3D

func get_look_at_proof():
	if is_colliding():
		var obj = get_collider()
		if obj and obj.is_in_group("proof"):
			obj.show_name()
			return obj
	return null
