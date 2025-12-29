extends Node
class_name State

var charge_stamina: bool = false
var stamina_cost: int
var resource_bars: ResourceBarController

func enter(_player: CharacterBody3D):
	resource_bars = _player.get_node("ResourceBars")

func run(_delta: float, _player: CharacterBody3D):
	if charge_stamina:
		_charge_stamina()

func exit(_player: CharacterBody3D):
	pass
	
func change_state(new_state: String) -> void:
	var state_machine: StateMachine = get_parent()
	state_machine.change_state(new_state)
	
func _charge_stamina() -> void:
	if not resource_bars.stamina_bar.is_full():
		resource_bars.update_bar(StaticNames.bars_stamina, StaticValues.stamina_recovery_speed)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if get_parent().current_state.name == "Attack":
		change_state(StaticNames.state_idle)

	#region Leave Exhauste State
	elif anim_name == "Sit_Floor_Down":
		charge_stamina = true
	elif anim_name == "Sit_Floor_StandUp":
		print("animation finished")
		get_parent().exhausted = false
		change_state(StaticNames.state_idle)
	#endregion
