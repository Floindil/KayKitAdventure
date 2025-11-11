extends Node
class_name Equipment

var slots: Dictionary = {}

func _init():
	slots = StaticNames.slots.duplicate(true)

func equip(item: Item, secondary_slot: int = 0) -> void:
	var slot: String = item.primary_slot
	if secondary_slot:
		slot = item.secondary_slot
	unequip(slot)
	slots[slot] = item
	
func unequip(slot: String) -> void:
	slots[slot] = null
	
func get_item(slot: String) -> Item:
	return slots[slot]
