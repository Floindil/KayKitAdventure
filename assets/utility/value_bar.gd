class_name ValueBar
extends Node

@export var max_value: int
var current_value: int

signal bar_value_changed

func _ready() -> void:
	current_value = max_value
	
func update(value: int) -> void:
	current_value += value
	if current_value > max_value:
		current_value = max_value
	elif current_value < 0:
		current_value = 0
	emit_signal("bar_value_changed")

func is_full() -> bool:
	if current_value == max_value:
		return true
	else:
		return false
