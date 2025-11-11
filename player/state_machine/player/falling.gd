extends State

var gravity := ProjectSettings.get_setting("physics/3d/default_gravity") as float

func enter(_player: Player):
	_player.can_move = false
	_player.vulnerable = false

func run(_delta: float, _player: Player):
	if not _player.is_on_floor():
		_player.velocity.y -= gravity * _delta
	else:
		if _player.velocity.y < 0.0:
			_player.velocity.y = 0.0
		change_state(StaticNames.state_landing)

func exit(_player: Player):
	pass
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
