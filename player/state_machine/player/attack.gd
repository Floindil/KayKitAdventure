extends State

var _delay = 40
var _count = 0

func enter(_player: Player):
	super.enter(_player)
	print(_player.moveset.name, " ", StaticNames.state_casting)
	if _player.moveset.name == StaticNames.state_casting:
		_player.spellcast = true
	stamina_cost = _player.moveset.combo_costs[0] * (-1)
	resource_bars.stamina_bar.update(stamina_cost)
	_player.anim_tree.set("parameters/attack_light/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	_player.can_move = false
	_player.vulnerable = true
	_count = 0
	print(_player.spellcast, " ", !_player.spellcast)

func run(_delta: float, _player: Player):
	if _count > _delay:
		_player.velocity = Vector3(0 ,0, 0)
	_count += 1

func exit(_player: Player):
	if _player.spellcast:
		var spell = _player.get_current_spell()
		spell.run(_player, spell)
		_player.spellcast = false
	_player.can_move = true
	_player.vulnerable = false
