extends State

var _delay := 40
var _count := 0
var _airborne := false
var jump_speed := 10.0
var gravity := ProjectSettings.get_setting("physics/3d/default_gravity") as float

func enter(_entity: Entity):
	super.enter(_entity)
	stamina_cost = StaticValues.stamina_jump_cost * (-1)
	resource_bars.stamina_bar.update(stamina_cost)
	_entity.can_move = false
	_entity.vulnerable = true
	_airborne = false
	_count = 0

func run(_delta: float, _entity: Entity):
	var anim_state = _entity.anim_tree.get("parameters/movement/playback")
	var current_anim = anim_state.get_current_node()

	if not _airborne:
		if _count > _delay:
			_entity.velocity.y = self.jump_speed
			_airborne = true
	else:
		_entity.velocity.y -= self.gravity * _delta
		if current_anim != StaticNames.state_jump:
			change_state(StaticNames.state_falling)

	_count += 1

func exit(_entity: Entity):
	_airborne = false
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
