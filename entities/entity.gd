extends CharacterBody3D
class_name Entity

# State vars
var speed = 5
var can_move: bool= true
var sprint: bool = false
var sneak: bool = false
var vulnerable: bool = false
var two_handed: bool = false

# Moveset vars
var moveset: Moveset
var spellcast: bool = false
var cast_moveset: String
var current_hitbox: Hitbox

@onready var model = $Rig
@onready var anim_tree = $AnimationTree
@onready var statemachine: StateMachine = $StateMachine
@onready var health_node: ValueBar = $ResourceBars/Health

func set_hitbox(hitbox: Hitbox):
	current_hitbox = hitbox
