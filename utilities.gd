extends Node
class_name Utilities

static func get_entity_root(p_node : Node) -> Node:

	while(p_node is not Entity):
		p_node = p_node.get_parent()
		
	return p_node as Entity
