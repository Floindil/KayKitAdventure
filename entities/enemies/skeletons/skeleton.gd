extends CharacterBody3D
class_name Skeleton

@export var skeleton_body: PackedScene
@export var skeleton_hat: PackedScene


var aggresive: bool = false
var target: CharacterBody3D = null
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jumping = false
var last_floor = true
var attacks = [
	"1H_Melee_Attack_Slice_Horizontal",
	"1H_Melee_Attack_Slice_Diagonal",
	"1H_Melee_Attack_Chop",
	"1H_Melee_Attack_Stab"
]
var actions = [
	"backoff",
	"advance",
	"attack",
	"strifeleft",
	"striferight",
	"block"
]
var dodge_rate = 0.1

# State vars
var speed = 5
var can_move: bool= true
var sprint: bool = false
var sneak: bool = false
var vulnerable: bool = false
var two_handed: bool = false

@onready var model = $Rig
@onready var anim_tree = $AnimationTree
@onready var statemachine: StateMachine = $StateMachine
@onready var health_node: ValueBar = $ResourceBars/Health

var count: int = 0

func _ready() -> void:
	var skeleton: Skeleton3D = get_node("Rig/Skeleton3D")
	if skeleton_body:
		var instance = skeleton_body.instantiate()
		skeleton.add_child(instance)

func _physics_process(delta: float) -> void:
	velocity.y += -gravity * delta
	if !is_on_floor() and statemachine.current_state.name != StaticNames.state_falling:
		self.statemachine.change_state(StaticNames.state_falling)
	move_and_slide()
	
	count += 1
	
	if count >= 200:
		health_node.update(-10)
		count = 0
		print("Remaining Health: ", health_node.current_value)

	
func _unhandled_input(_event: InputEvent) -> void:
	pass
