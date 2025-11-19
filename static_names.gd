extends Node
class_name StaticNames

#region Slots
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
#endregion

#region Item Types
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
#endregion

#region Consumable Items
const consumable_value_type_percentage_current = "PercentageCurrent"
const consumable_value_type_percentage_max = "PercentageMax"
const consumable_value_type_int = "Int"
#endregion

#region Resource Bars
const bars_health = "Health"
const bars_stamina = "Stamina"
#endregion

#region States
const state_idle = "Idle"
const state_walk = "Walk"
const state_sprint = "Sprint"
const state_sneak = "Sneak"
const state_jump = "Jump"
const state_falling = "Falling"
const state_landing = "Landing"
const state_attack = "Attack"
const state_exhausted = "Exhausted"
#endregion

#region Control Mappings
const map_menu = "Menu"
const map_in_game = "InGame"
#endregion
