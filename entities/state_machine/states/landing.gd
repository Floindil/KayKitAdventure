extends Node

var _delay := 15
var _count := 0

func enter(_player: CharacterBody3D):
	_player.can_move = false
	_player.vulnerable = true
	_count = 0

func run(_delta: float, _player: CharacterBody3D):
	var anim_state = _player.anim_tree.get("parameters/movement/playback")
	var current_anim = anim_state.get_current_node()
	if _count > _delay:
		_player.velocity = Vector3(0, 0, 0)
	if current_anim != StaticNames.state_landing:
		change_state(StaticNames.state_idle)
	_count += 1

func exit(_player: CharacterBody3D):
	_player.can_move = true
	_player.vulnerable = false
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
