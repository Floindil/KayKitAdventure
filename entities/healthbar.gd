extends Node3D
class_name Healthbar

@onready var parent = Utilities.get_entity_root(get_parent())
@onready var health_node: ValueBar = parent.get_node("ResourceBars/Health")
@onready var health_bar: TextureProgressBar = $SubViewport/Healthbar/progress
@onready var camera: Camera3D = get_tree().current_scene.get_node("Player/SpringArm/Camera")

func _ready() -> void:
	#for node in parent.get_children():
		#print(node.name)
	health_node.connect("bar_value_changed", update_health_bar)

func _process(_delta: float) -> void:
	if camera:
		self.global_rotation = camera.global_rotation

func update_health_bar() -> void:
	health_bar.value = get_bar_len(health_node, health_bar)

func get_node_percent(node: ValueBar) -> float:
	return float(node.current_value) / float(node.max_value)
	
func get_bar_len(node: ValueBar, progress_bar: TextureProgressBar) -> int:
	var bar_multiplier: float = get_node_percent(node)
	return int(progress_bar.max_value * bar_multiplier)
