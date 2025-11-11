extends Resource
class_name Item

@export_enum(
	StaticNames.type_weapon,
	StaticNames.type_armor,
	StaticNames.type_consumables,
	StaticNames.type_key
	)
var type: String
@export var name: String
@export var asset_path: String
@export var icon: AtlasTexture
@export_enum(
	StaticNames.moveset_fist,
	StaticNames.moveset_straight_sword,
	StaticNames.moveset_great_sword
	)
var moveset: String
@export var amount: int = 1
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
