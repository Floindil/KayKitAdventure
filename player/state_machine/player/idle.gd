extends State

func enter(_player: Player):
	_player.can_move = true
	_player.vulnerable = false

func run(_delta: float, _player: Player):
	if _player.velocity.length() > 0:
		self.change_state(StaticNames.state_walk)
		
func exit(_player: Player):
	pass
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
