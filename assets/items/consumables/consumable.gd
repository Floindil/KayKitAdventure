class_name ConsumableItem
extends Item

@export var consumable_script: Script
@export var value: int
@export_enum(
	StaticNames.consumable_value_type_int,
	StaticNames.consumable_value_type_percentage_max,
	StaticNames.consumable_value_type_percentage_current
)
var value_type: String
@export_enum(
	StaticNames.consumable_health_bar
)
var value_bar_name: String

func run(user: CharacterBody3D, item: ConsumableItem) -> void:
	consumable_script.run(user, item)
