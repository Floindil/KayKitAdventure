extends Control

@onready var health_node: ValueBar = get_node("../Player/Stats/Health")
@onready var health: TextureProgressBar = $Healthbar/progress

func _process(_delta: float) -> void:
	var bar_multiplier: float = get_node_percent()
	var progress_len: int = int(health.max_value * bar_multiplier)
	health.value = progress_len

func get_node_percent() -> float:
	return float(health_node.current_value) / float(health_node.max_value)
