@tool
extends MarginContainer
class_name ItemContext

@export var options: Array[ContextOptionData] = []

@onready var container: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer
var current_selection: int = 0

func _ready() -> void:
	_build_context_options()

func _build_context_options() -> void:
	if not container:
		return
	
	for child in container.get_children():
		child.queue_free()
	
	for data in options:
		if not data.scene:
			continue
		
		var option: SelectableOption = data.scene.instantiate()
		option.text = data.text
		container.add_child(option)

func toggle_highlight_visibility() -> void:
	var option: SelectableOption = container.get_child(current_selection)
	if option:
		var highlight: Control = option.highlight
		highlight.visible = !highlight.visible

func increment_selection(value: int) -> void:
	toggle_highlight_visibility()
	current_selection += value
	var max_i = len(container.get_children())-1
	if current_selection > max_i:
		current_selection = 0
	elif current_selection < 0:
		current_selection = max_i
	toggle_highlight_visibility()

func trigger() -> void:
	var option: SelectableOption = container.get_child(current_selection)
	if option:
		option.trigger()
	visible = false
