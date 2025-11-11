extends Node
class_name StateMachine

var current_state: Node = null

func _ready() -> void:
	change_state(StaticNames.state_idle)

func _process(_delta):
	if current_state:
		current_state.run(_delta, get_parent())
	else:
		change_state(StaticNames.state_idle)

func change_state(new_state: String):
	var state = get_node("./%s" % new_state)
	if current_state:
		current_state.exit(get_parent())
	current_state = state
	current_state.enter(get_parent())
