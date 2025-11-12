@tool
extends Node3D

@export var skeleton: Skeleton3D:
	set(value):
		skeleton = value
		if is_inside_tree():
			_update_skeletons()

@export var skin: Skin:
	set(value):
		skin = value
		if is_inside_tree():
			_update_skeletons()

func _ready():
	_update_skeletons()

func _update_skeletons():
	if skeleton == null:
		return
	
	for child in get_children():
		_apply_to_children_recursive(child)

func _apply_to_children_recursive(node: Node):
	if node is MeshInstance3D:
		# Godot 4 expects a NodePath, not the Skeleton3D object
		if skeleton != null:
			node.set("skeleton", skeleton.get_path())
		if skin != null:
			node.skin = skin
	for child in node.get_children():
		_apply_to_children_recursive(child)
