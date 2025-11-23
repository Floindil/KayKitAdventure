extends Node

static func run(user: CharacterBody3D, spell: Spell) -> void:
	var value_bar: ValueBar = user.get_node("ResourceBars/%s" % spell.value_bar_name) as ValueBar
	var value: int = spell.value
	var update_value: int = spell.value
	var type: String = spell.value_type
	if value and type and value_bar:
		if type == StaticNames.consumable_value_type_percentage_current:
			@warning_ignore("integer_division")
			update_value = int(value_bar.current_value * value / 100)
		elif type == StaticNames.consumable_value_type_percentage_max:
			@warning_ignore("integer_division")
			update_value = int(value_bar.max_value * value / 100)
		value_bar.update(update_value)
