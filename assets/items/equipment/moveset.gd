class_name Moveset
extends Resource

@export var name: String
@export var can_block: bool = true
@export var combo_count: int:
	set(value):
		combo_count = value
		_resize_combo_array()

@export var combo_costs: Array[int]:
	set(value):
		# Nur erlauben, wenn die Länge gleich bleibt
		if value.size() == combo_count:
			combo_costs = value
		else:
			# Länge wurde manipuliert -> korrigieren
			_resize_combo_array()

func _resize_combo_array():
	# Wenn das Array zu kurz ist, neue Einträge hinzufügen
	while combo_costs.size() < combo_count:
		combo_costs.append(0)

	# Wenn das Array zu lang ist, überschüssige Einträge entfernen
	while combo_costs.size() > combo_count:
		combo_costs.pop_back()
