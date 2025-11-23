extends Resource
class_name Item

@export_enum(
	StaticNames.type_weapon,
	StaticNames.type_armor,
	StaticNames.type_consumables,
	StaticNames.type_key,
	StaticNames.type_spell
	)
var type: String
@export var name: String
@export var asset_path: String
@export var icon: AtlasTexture
@export var amount: int = 1
