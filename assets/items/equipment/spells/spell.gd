extends EquipmentItem
class_name Spell

@export_enum(
	StaticNames.casting_default,
	StaticNames.casting_long,
	StaticNames.casting_raise,
	StaticNames.casting_shoot
) var cast_moveset: String
@export var cast_amount: int
var spell_slot: int
@export var spell_script: Script
@export_enum(
	StaticNames.consumable_value_type_int,
	StaticNames.consumable_value_type_percentage_max,
	StaticNames.consumable_value_type_percentage_current
)
var value_type: String
@export_enum(
	StaticNames.bars_health
)
var value_bar_name: String
@export var value: int

func run(user: CharacterBody3D, spell: Spell) -> void:
	spell_script.run(user, spell)
