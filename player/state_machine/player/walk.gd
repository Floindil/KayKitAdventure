extends State

var previous_mods = [false, false]

var walk_speed := 5
var sprint_speed := 8
var sneak_speed := 2

func enter(_player: Player):
	_player.can_move = true
	_player.vulnerable = false
	_player.speed = walk_speed
	_player.sprint = false
	_player.sneak = false

func run(_delta: float, _player: Player):
	
	previous_mods = [_player.sprint, _player.sneak]
	
	if _player.velocity.length() <= 0:
		self.change_state(StaticNames.state_idle)

	if not _player.in_menu:
		if not _player.sneak:
			_player.sprint = Input.is_action_pressed(StaticNames.state_sprint)
		if not _player.sprint:
			_player.sneak = Input.is_action_pressed(StaticNames.state_sneak)
	
	var current_mods = [_player.sprint, _player.sneak]

	process_mods(_player, previous_mods, current_mods)

func exit(_player: Player):
	pass
	
func process_mods(player, _previous_mods, _current_mods) -> void:
	if _previous_mods != _current_mods:
		if player.sprint:
			player.speed = sprint_speed
		elif player.sneak:
			player.speed = sneak_speed
		else:
			player.speed = walk_speed

func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
