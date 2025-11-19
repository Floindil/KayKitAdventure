class_name ResourceBarController
extends Node

@onready var stamina_bar: ValueBar = $Stamina
@onready var health_bar: ValueBar = $Health

func update_bar(bar: String, value: int) -> void:
	if bar == StaticNames.bars_health:
		health_bar.update(value)
	elif bar == StaticNames.bars_stamina:
		stamina_bar.update(value)
