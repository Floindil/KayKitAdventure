extends State

func enter(_entity: Entity):
	super.enter(_entity)
	charge_stamina = true
	_entity.can_move = true
	_entity.vulnerable = false

func run(_delta: float, _entity: Entity):
	super.run(_delta, _entity)
	if _entity.velocity.length() > 0:
		self.change_state(StaticNames.state_walk)
		
func exit(_entity: Entity):
	pass
