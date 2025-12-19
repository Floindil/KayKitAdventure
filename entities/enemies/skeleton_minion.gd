extends CharacterBody3D
class_name Skeleton

@export var speed = 10
@export var acceleration = 4.0
@export var jump_speed = 8.0
@export var rotation_speed = 12.0
@export var mouse_sensivity = 0.01

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

@onready var model = $Rig
@onready var anim_tree = $AnimationTree
@onready var anim_state = $AnimationTree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	velocity.y += -gravity * delta
	
	move_and_slide()
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_speed
		jumping = true
		anim_tree.set("parameters/conditions/jumping", true)
		anim_tree.set("parameters/conditions/grounded", false)
	if is_on_floor() and not last_floor:
		jumping = false
		anim_tree.set("parameters/conditions/jumping", false)
		anim_tree.set("parameters/conditions/grounded", true)
	if not is_on_floor() and not jumping:
		anim_state.travel("Jump_Idle")
		anim_tree.set("parameters/conditions/grounded", false)
	last_floor = is_on_floor()
		
	
func _unhandled_input(event: InputEvent) -> void:
	pass
