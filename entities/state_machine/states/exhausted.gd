extends State

func enter(_entity: Entity):
	super.enter(_entity)
	_entity.anim_tree.set("parameters/exhausted/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	_entity.velocity = Vector3(0 ,0, 0)
	_entity.can_move = false
	_entity.vulnerable = true
	resource_bars.stamina_bar.current_value = 1

func run(_delta: float, _entity: Entity):
	super.run(_delta, _entity)

func exit(_entity: Entity):
	_entity.can_move = true
	_entity.vulnerable = false
