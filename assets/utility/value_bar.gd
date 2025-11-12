class_name ValueBar
extends Node

@export var max_value: int
var current_value: int

func _ready() -> void:
	current_value = max_value
	
func update(value: int) -> void:
	current_value += value
	if current_value > max_value:
		current_value = max_value
