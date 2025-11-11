extends State

var _delay = 40
var _count = 0

func enter(_player: Player):
	_player.anim_tree.set("parameters/movement/current", "Idle_1h")
	_player.anim_tree.set("parameters/attack_light/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	_player.can_move = false
	_player.vulnerable = true
	_count = 0

func run(_delta: float, _player: Player):
	if _count > _delay:
		_player.velocity = Vector3(0 ,0, 0)
	_count += 1

func exit(_player: Player):
	_player.can_move = true
	_player.vulnerable = false
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)

func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	change_state(StaticNames.state_idle)
