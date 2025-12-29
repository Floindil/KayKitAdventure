extends State

func enter(_player: CharacterBody3D):
	super.enter(_player)
	_player.anim_tree.set("parameters/exhausted/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	_player.velocity = Vector3(0 ,0, 0)
	_player.can_move = false
	_player.vulnerable = true
	resource_bars.stamina_bar.current_value = 1

func run(_delta: float, _player: CharacterBody3D):
	super.run(_delta, _player)

func exit(_player: CharacterBody3D):
	_player.can_move = true
	_player.vulnerable = false
