extends State

var _delay = 40
var _count = 0
var hitbox: Hitbox
var wind_up: float

func enter(_entity: Entity):
	super.enter(_entity)
	
	var moveset: Moveset = _entity.moveset
	if moveset.name == StaticNames.state_casting:
		_entity.spellcast = true

	stamina_cost = moveset.combo_costs[0] * (-1)
	wind_up = moveset.wind_ups[0]
	resource_bars.stamina_bar.update(stamina_cost)

	_entity.anim_tree.set("parameters/attack_light/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

	_entity.can_move = false
	_entity.vulnerable = true
	_count = 0

	hitbox = _entity.current_hitbox

func run(_delta: float, _entity: CharacterBody3D):
	if _count > _delay:
		_entity.velocity = Vector3(0 ,0, 0)
	_count += 1
	
	if hitbox:
		if wind_up > 0:
			wind_up -= _delta
		elif !hitbox.active:
			hitbox.activate()

func exit(_entity: CharacterBody3D):
	if _entity.spellcast:
		var spell = _entity.get_current_spell()
		spell.run(_entity, spell)
		_entity.spellcast = false
	_entity.can_move = true
	_entity.vulnerable = false
	
	if hitbox:
		hitbox.deactivate()
