extends RayCast3D

var current_object

func _physics_process(_delta: float) -> void:
	var thing = get_collider()
	if thing:
		if thing.is_in_group('proof'):
			thing.show_text()
			current_object = thing
	else:
		if current_object:
			current_object.hide_text()
			current_object = null



#extends RayCast3D
#
#var current_label: Label3D = null
#
#func _ready():
	#enabled = true
#
	## 开局隐藏所有 name label
	#var labels = get_tree().get_nodes_in_group("hover_label")
	#for l in labels:
		#if l is Label3D:
			#l.visible = false
#
#func _process(_delta):
	#update_hover()
#
#func update_hover():
	#var hit_label = get_hover_label()
#
	#if hit_label != current_label:
		#if current_label:
			#current_label.visible = false
#
		#current_label = hit_label
		#if current_label:
			#current_label.visible = true
#
#func get_hover_label() -> Label3D:
	#if not is_colliding():
		#return null
#
	#var node = get_collider()
#
#
	#while node and not (node is Node3D):
		#node = node.get_parent()
#
	#if not node:
		#return null
#
	## 2️⃣ 再往上跳过 Area3D，找到具体的 knife / cuttingboard
	#while node and node is Area3D:
		#node = node.get_parent()
#
	#if not node:
		#return null
#
	#return _find_name_label_recursive(node)
#
#func _find_name_label_recursive(node: Node) -> Label3D:
	#if node is Label3D and node.name == "name":
		#return node
#
	#for child in node.get_children():
		#var found = _find_name_label_recursive(child)
		#if found:
			#return found
#
	#return null


#可显示knife label的版本
#extends RayCast3D
#
#var current_label: Label3D = null
#
#func _ready():
	#enabled = true
#
	## 开局强制隐藏所有 hover_label
	#for node in get_tree().get_nodes_in_group("hover_label"):
		#if node is Label3D:
			#node.visible = false
#
#func _process(_delta):
	#update_hover()
#
#func update_hover():
	#var hit_label = get_hover_label()
#
	#if hit_label != current_label:
		#if current_label:
			#current_label.visible = false
#
		#current_label = hit_label
		#if current_label:
			#current_label.visible = true
#
#func get_hover_label() -> Label3D:
	#if not is_colliding():
		#return null
#
	#var collider = get_collider()
#
	#if collider:
		#var label = _find_hover_label_recursive(collider)
		#if label:
			#return label
#
	#return null
#
#func _find_hover_label_recursive(node: Node) -> Label3D:
	#if node is Label3D and node.is_in_group("hover_label"):
		#return node
#
	#for child in node.get_children():
		#var found = _find_hover_label_recursive(child)
		#if found:
			#return found
#
	#return null
#-----------------------------------------------------------

##检测有没有碰撞到（可以删）
	#if is_colliding():
		#print("Ray hit:", get_collider().name)
	#update_hover()


#extends RayCast3D
#
#var last_proof = null;
#
#func _process(_delta):
	#var _current = get_look_at_proof()
#
	##if current != null:
		##if current != last_proof:
		### 在这里将物体的名字显示在ui上，然后将物体记录成last_proof
			##current.show_name();
			##last_proof = current;
	##else:
		##last_proof.hide_name();
		#
		#
		##if last_proof:
		##last_proof.hide_name()
		#
		#
##pass	;
#
#func get_look_at_proof():
	#if is_colliding():
		#var obj = get_collider();
		 #
		#var proof = obj
		##while proof and not proof.is_in_group("proof"):
			##proof = proof.get_parent()
#
		#if proof != null:
			#return proof
	#return null
#
#
#
#
##func get_look_at_proof():
	##if is_colliding():
		##var obj = get_collider()
		##if obj and obj.is_in_group("proof"):
			##return obj
	##return null
