extends Item
class_name EquipmentItem

@export_enum(
	StaticNames.moveset_fist,
	StaticNames.moveset_straight_sword,
	StaticNames.moveset_great_sword
	)
var moveset: String
@export_enum(
	StaticNames.slot_helmet,
	StaticNames.slot_cape,
	StaticNames.slot_armor,
	StaticNames.slot_greaves,
	StaticNames.slot_boots,
	StaticNames.slot_mainhand,
	StaticNames.slot_offhand
	)
var primary_slot: String
@export_enum(
	StaticNames.slot_helmet,
	StaticNames.slot_cape,
	StaticNames.slot_armor,
	StaticNames.slot_greaves,
	StaticNames.slot_boots,
	StaticNames.slot_mainhand,
	StaticNames.slot_offhand
	)
var secondary_slot: String
