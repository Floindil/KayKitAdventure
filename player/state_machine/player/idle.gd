extends State

func enter(_player: Player):
	super.enter(_player)
	charge_stamina = true
	_player.can_move = true
	_player.vulnerable = false

func run(_delta: float, _player: Player):
	super.run(_delta, _player)
	if _player.velocity.length() > 0:
		self.change_state(StaticNames.state_walk)
		
func exit(_player: Player):
	pass
