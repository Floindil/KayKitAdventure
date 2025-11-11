extends Node
class_name StaticNames

# Slots
const slot_helmet = "Helmet"
const slot_armor = "Armor"
const slot_cape = "Cape"
const slot_greaves = "Greaves"
const slot_boots = "Boots"
const slot_mainhand = "MainHand"
const slot_offhand = "OffHand"
const slot_back = "Back/Offset" # Unofficial Slot 
const slots = {
	slot_helmet: null,
	slot_armor: null,
	slot_cape: null,
	slot_greaves: null,
	slot_boots: null,
	slot_mainhand: null,
	slot_offhand: null
	}

# Item Types
const type_weapon = "Weapon"
const type_armor = "Armor"
const type_consumables = "Consumable"
const type_key = "Key"
const types = [
	type_weapon,
	type_armor,
	type_consumables,
	type_key
	]
const types_equipment = [
	type_weapon,
	type_armor
]

# Movesets
const moveset_fist = "Fist"
const moveset_straight_sword = "StraightSword"
const moveset_great_sword = "GreatSword"
const movesets = [
	moveset_fist,
	moveset_straight_sword,
	moveset_great_sword
	]

# States
const state_idle = "Idle"
const state_walk = "Walk"
const state_sprint = "Sprint"
const state_sneak = "Sneak"
const state_jump = "Jump"
const state_falling = "Falling"
const state_landing = "Landing"
const state_attack = "Attack"
	
# Control Mappings
const map_menu = "Menu"
const map_in_game = "InGame"
