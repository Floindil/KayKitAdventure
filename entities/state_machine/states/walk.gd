extends State

var previous_mods = [false, false]

var walk_speed := StaticValues.walk_speed
var sprint_speed := StaticValues.sprint_speed
var sneak_speed := StaticValues.sneak_speed

func enter(_entity: Entity):
	super.enter(_entity)
	charge_stamina = true
	_entity.can_move = true
	_entity.vulnerable = false
	_entity.speed = walk_speed
	_entity.sprint = false
	_entity.sneak = false

func run(_delta: float, _entity: Entity):
	super.run(_delta, _entity)
	
	previous_mods = [_entity.sprint, _entity.sneak]
	
	if _entity.velocity.length() <= 0:
		self.change_state(StaticNames.state_idle)

	if not _entity.in_menu:
		if not _entity.sneak:
			_entity.sprint = Input.is_action_pressed(StaticNames.state_sprint)
		if not _entity.sprint:
			_entity.sneak = Input.is_action_pressed(StaticNames.state_sneak)
			
	if _entity.sprint:
		resource_bars.update_bar(StaticNames.bars_stamina, -1)
	
	var current_mods = [_entity.sprint, _entity.sneak]

	process_mods(_entity, previous_mods, current_mods)

func exit(_entity: Entity):
	var movement_playback: AnimationNodeStateMachinePlayback = _entity.anim_tree.get("parameters/movement/playback")
	movement_playback.travel(&"Start")

func process_mods(_entity: Entity, _previous_mods, _current_mods) -> void:
	if _previous_mods != _current_mods:
		if _entity.sprint:
			_entity.speed = sprint_speed
			charge_stamina = false
		elif _entity.sneak:
			_entity.speed = sneak_speed
		else:
			_entity.speed = walk_speed
			charge_stamina = true

func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
