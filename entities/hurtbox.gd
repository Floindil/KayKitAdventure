extends Area3D
class_name Hurtbox

@onready var parent: Entity = Utilities.get_entity_root(self)

func take_damage(value: int):
	parent.health_node.update(-value)
