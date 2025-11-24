extends Node
class_name StaticValues

const stamina_cooldown: float = 2.0
const stamina_jump_cost: int = 100
const stamina_recovery_speed: int = 1
const walk_speed: int = 5
const sprint_speed: int = 8
const sneak_speed: int = 2

const gravity := ProjectSettings.get_setting("physics/3d/default_gravity") as float
