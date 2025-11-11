@tool
extends VBoxContainer
class_name SelectableOption

@export var text: String
@onready var label: Label = $MarginContainer/PanelContainer/MarginContainer/text
@onready var highlight: NinePatchRect = $MarginContainer/Highlight
@onready var function: Callable

func _ready() -> void:
	if label:
		label.text = text

func toggle_highlight() -> void:
	highlight.visible = !highlight.visible
	
func set_function(new_function: Callable) -> void:
	function = new_function

func trigger() -> void:
	if function:
		function.call()
