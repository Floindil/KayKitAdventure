extends State

func enter(_entity: Entity):
	_entity.can_move = false
	_entity.vulnerable = false

func run(_delta: float, _entity: Entity):
	if not _entity.is_on_floor():
		_entity.velocity.y -= StaticValues.gravity * _delta
	else:
		if _entity.velocity.y < 0.0:
			_entity.velocity.y = 0.0
		change_state(StaticNames.state_landing)

func exit(_entity: Entity):
	pass
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
