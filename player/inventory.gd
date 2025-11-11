extends Node
class_name Inventory

var items: Dictionary = {}

signal item_added

func _ready() -> void:
	var _item_types = StaticNames.types
	for type in _item_types:
		items.set(type, [])

func add_item(item: Item) -> void:
	var existing_item:  = get_item(item.type, item.name)
	if existing_item:
		existing_item.amount += 1
	else:
		item.amount = 1
		items[item.type].append(item)
	emit_signal("item_added", item)
		
func remove_item(item) -> void:
	var existing_item: Item = get_item(item.type, item.name)
	if existing_item:
		existing_item.amount -= 1
		if existing_item.amount <= 0:
			var items_type: Array = items[item.type]
			items_type.erase(item)
	
func get_item(type: String, item_name: String) -> Item:
	var type_array: Array = items.get(type)
	for item in type_array:
		if item.name == item_name:
			return item
	return null
	
func get_type_list(type: String) -> Array:
	return items.get(type, [])
