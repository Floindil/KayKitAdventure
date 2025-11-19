extends Node
class_name StateMachine

var current_state: Node = null
var exhausted: bool = false
@onready var stamina_bar: ValueBar = self.get_node("../ResourceBars/Stamina")

func _ready() -> void:
	change_state(StaticNames.state_idle)

func _process(_delta):
	var player: CharacterBody3D = get_parent()
	if stamina_bar.current_value <= 0 and not exhausted and player.can_move:
		exhausted = true
		change_state(StaticNames.state_exhausted)

	if current_state:
		current_state.run(_delta, player)
	else:
		change_state(StaticNames.state_idle)

func change_state(new_state: String):
	var state = get_node("./%s" % new_state)
	if current_state:
		current_state.exit(get_parent())
	current_state = state
	current_state.enter(get_parent())
