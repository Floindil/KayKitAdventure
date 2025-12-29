extends Entity
class_name Skeleton

@export var skeleton_body: PackedScene
@export var skeleton_hat: PackedScene
@export var skeleton_cape: PackedScene

var aggresive: bool = false
var target: CharacterBody3D = null

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

var count: int = 0

func _ready() -> void:
	var skeleton: Skeleton3D = get_node("Rig/Skeleton3D")
	var skeleton_hat_slot: BoneAttachment3D = get_node("Rig/Skeleton3D/Headwear")
	var skeleton_cape_slot: BoneAttachment3D = get_node("Rig/Skeleton3D/Cape")
	if skeleton_body:
		var body_instance = skeleton_body.instantiate()
		skeleton.add_child(body_instance)
	if skeleton_hat:
		var hat_instance = skeleton_hat.instantiate()
		skeleton_hat_slot.add_child(hat_instance)
	if skeleton_cape:
		var cape_instance = skeleton_cape.instantiate()
		skeleton_cape_slot.add_child(cape_instance)

func _physics_process(delta: float) -> void:
	velocity.y += -StaticValues.gravity * delta
	if !is_on_floor() and statemachine.current_state.name != StaticNames.state_falling:
		self.statemachine.change_state(StaticNames.state_falling)
	move_and_slide()
	
	count += 1
	
	#if count >= 200:
		#health_node.update(-10)
		#count = 0
		#print("Remaining Health: ", health_node.current_value)

	
func _unhandled_input(_event: InputEvent) -> void:
	pass
