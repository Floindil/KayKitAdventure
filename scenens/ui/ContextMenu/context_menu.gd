@tool
extends MarginContainer
class_name ContextMenu

@export var options_data: Array[ContextOptionData] = []
@export var available_options: Array[int] = []

@onready var container: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer
var current_selection_index: int = 0
var current_selection: int = 0

func _ready() -> void:
	_build_context_options()

func _build_context_options() -> void:
	if not container:
		return
	
	for child in container.get_children():
		child.queue_free()
	
	for data in options_data:
		if not data.scene:
			continue
		
		var option: SelectableOption = data.scene.instantiate()
		option.text = data.text
		container.add_child(option)
		set_option_visibility(true, option)

func toggle_highlight_visibility() -> void:
	var option: SelectableOption = container.get_child(current_selection)
	if option:
		var highlight: Control = option.highlight
		highlight.visible = !highlight.visible

func increment_selection(value: int) -> void:
	toggle_highlight_visibility()
	current_selection_index += value
	var max_i = len(available_options)-1
	if current_selection_index > max_i:
		current_selection_index = 0
	elif current_selection_index < 0:
		current_selection_index = max_i
	set_current_selection()
	toggle_highlight_visibility()

func trigger() -> void:
	var option: SelectableOption = container.get_child(current_selection)
	if option:
		option.trigger()
	visible = false

func set_option_visibility(_visible: bool, option: SelectableOption) -> void:
	var options : Array[SelectableOption] = get_selectable_options()
	if option in options:
		option.visible = _visible
		var i = options.find(option)
		if _visible:
			if i not in available_options:
				available_options.append(i)
				options.sort()
		else:
			if i in available_options:
				var ia = available_options.find(i)
				available_options.pop_at(ia)
	set_current_selection()

func set_current_selection() -> void:
	current_selection = available_options[current_selection_index]

func get_selectable_options() -> Array[SelectableOption]:
	var options: Array[SelectableOption] = []
	for child in container.get_children():
		if is_instance_of(child, SelectableOption):
			options.append(child)
	return options
