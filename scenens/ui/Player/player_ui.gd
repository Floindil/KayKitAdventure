extends Control

@onready var health_node: ValueBar = get_node("../Player/ResourceBars/Health")
@onready var health_bar: TextureProgressBar = $bar_container/Healthbar/progress
@onready var stamina_node: ValueBar = get_node("../Player/ResourceBars/Stamina")
@onready var stamina_bar: TextureProgressBar = $bar_container/Staminabar/progress

func _ready() -> void:
	health_node.connect("bar_value_changed", update_health_bar)
	stamina_node.connect("bar_value_changed", update_stamina_bar)

func update_health_bar() -> void:
	health_bar.value = get_bar_len(health_node, health_bar)
	
func update_stamina_bar() -> void:
	stamina_bar.value = get_bar_len(stamina_node, stamina_bar)

func get_node_percent(node: ValueBar) -> float:
	return float(node.current_value) / float(node.max_value)
	
func get_bar_len(node: ValueBar, progress_bar: TextureProgressBar) -> int:
	var bar_multiplier: float = get_node_percent(node)
	return int(progress_bar.max_value * bar_multiplier)
