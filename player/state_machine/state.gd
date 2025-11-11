extends Node
class_name State

func enter(_player: Player):
	pass

func run(_delta: float, _player: Player):
	pass

func exit(_player: Player):
	pass
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
