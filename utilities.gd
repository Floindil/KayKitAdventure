extends Node
class_name Utilities

static func get_local_scene_root(p_node : Node) -> Node:

	while(p_node is not CharacterBody3D):
		p_node = p_node.get_parent()
		
	return p_node as Node
