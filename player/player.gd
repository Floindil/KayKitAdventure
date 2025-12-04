extends CharacterBody3D
class_name Player

#region Variables
# State vars
var can_move := true
var speed := 5
var sprint: bool = false
var sneak: bool = false
var vulnerable := false

# Moveset vars
var moveset_fist: Moveset = load("res://assets/items/equipment/movesets/fist.tres")
var two_handed := false
var moveset: Moveset = moveset_fist
var spellcast: bool = false
var cast_moveset: String
var attunement_slots: int = 1
var attuned_spells: Array[Spell] = []
var current_spell: int = 0

# Gameplay vars
var dir: Vector3
var rotation_speed := 5.0
var mouse_sensitivity := 0.01
var in_menu: bool = false
var dialog_lock: bool = false
#endregion

#region Linked Nodes
@onready var inventory: Inventory = $Inventory
@onready var equipment: Equipment = $Equipment
@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var model: Node3D = $Rig
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/movement/playback")
@onready var statemachine: StateMachine = $StateMachine
#endregion

# Signals
signal toggle_menu

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_dialog_toggle(_dialog_lock: bool) -> void:
	self.dialog_lock = _dialog_lock

func _physics_process(delta: float) -> void:
	statemachine._process(delta)

	if self.can_move:
		_get_move_input()
		_rotate_model(delta)

	move_and_slide()

func _get_move_input() -> void:
	var vy := velocity.y
	velocity.y = 0.0

	var input_vec := Input.get_vector("left", "right", "forward", "backward")

	var cam_yaw := spring_arm.rotation.y
	self.dir = Vector3(input_vec.x, 0.0, input_vec.y).rotated(Vector3.UP, cam_yaw)
	
	velocity = self.dir * self.speed
	velocity.y = vy

func _rotate_model(delta: float) -> void:
	if Vector3(velocity.x, 0, velocity.z).length() > 0.1:
		var input_vec := Input.get_vector("left", "right", "forward", "backward")

		# Wenn Spieler vorwärts drückt → Modell in Kamera-Richtung drehen
		if input_vec.y > 0.1:
			var target_rot := spring_arm.rotation.y
			self.model.rotation.y = lerp_angle(model.rotation.y, target_rot, rotation_speed * delta)
		else:
			# Sonst zur Bewegungsrichtung drehen
			var move_dir := Vector3(velocity.x, 0, velocity.z).normalized()
			var target_rot := atan2(move_dir.x, move_dir.z)
			self.model.rotation.y = lerp_angle(model.rotation.y, target_rot, rotation_speed * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.spring_arm.rotation.x -= event.relative.y * mouse_sensitivity
		self.spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0)
		self.spring_arm.rotation.y -= event.relative.x * mouse_sensitivity
	
	if self.can_move and not in_menu:
		_movement_handler(event)
		_action_handler(event)
	
	# Menu Control
	if event.is_action_pressed("menu") and not self.dialog_lock:
		self.in_menu = !self.in_menu
		self.emit_signal("toggle_menu", self.in_menu)

func _movement_handler(event: InputEvent) -> void:
	var state = statemachine.current_state
	if state:
		state = state.name
	else:
		state = ""
		
	# Jump and Fall Control
	if event.is_action_pressed("Jump"):
		self.statemachine.change_state(StaticNames.state_jump)
	if !is_on_floor():
		self.statemachine.change_state(StaticNames.state_falling)

func _action_handler(event: InputEvent) -> void:
	# Player Actions
	if event.is_action_pressed("Attack"):
		self.statemachine.change_state(StaticNames.state_attack)
	if event.is_action_pressed("Dodge"):
		self.anim_tree.set("parameters/dodge/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	if event.is_action_pressed("two_hand"):
		self._toggle_2h()

	# Test Action
	if event.is_action_pressed("test"):
		self._test_action()

func _toggle_2h() -> void:
	self.two_handed = !self.two_handed
	var back_node: Node3D = get_node("Rig/Skeleton3D/%s" % StaticNames.slot_back)
	var off_hand_node: BoneAttachment3D = get_node("Rig/Skeleton3D/%s" % StaticNames.slot_offhand)
	if two_handed:
		if off_hand_node.get_child_count() > 0:
			var item: Node3D = off_hand_node.get_child(0)
			off_hand_node.remove_child(item)
			back_node.add_child(item)
	else:
		if back_node.get_child_count() > 0:
			var item: Node3D = back_node.get_child(0)
			back_node.remove_child(item)
			off_hand_node.add_child(item)

func _test_action() -> void:
	var sword: Item = load("res://assets/items/equipment/weapons/IronGreatSword.tres")
	self.inventory.add_item(sword)

	var shield: Item = load("res://assets/items/equipment/schields/round_shield.tres")
	self.inventory.add_item(shield)

	var gs: Item = load("res://assets/items/equipment/weapons/IronSword.tres")
	self.inventory.add_item(gs)
	
	var poison: ConsumableItem = load("res://assets/items/consumables/weak_poison.tres")
	poison.amount = 5
	self.inventory.add_item(poison)
	self.inventory.add_item(poison)
	
	var health_potion: ConsumableItem = load("res://assets/items/consumables/health_potion.tres")
	health_potion.amount = 5
	self.inventory.add_item(health_potion)
	self.inventory.add_item(health_potion)
	
	var staff: EquipmentItem = load("res://assets/items/equipment/weapons/staff.tres")
	self.inventory.add_item(staff)
	
	var heal: Spell = load("res://assets/items/equipment/spells/basic_heal.tres")
	self.inventory.add_item(heal)
	self.cycle_spell(0)
	
	var hb: ValueBar = get_node("ResourceBars/Health")
	hb.update(-50)

func use_consumable(item: ConsumableItem) -> void:
	inventory.remove_item(item)
	item.run(self, item)

func attune_spell(spell: Spell) -> void:
	if len(attuned_spells) <= attunement_slots:
		attuned_spells.append(spell)

func cycle_spell(direction: int = 1) -> void:
	current_spell += direction
	if current_spell >= len(attuned_spells):
		current_spell = 0
	elif current_spell < 0:
		current_spell = len(attuned_spells) -1

	var spell: Spell = get_current_spell()
	if spell:
		cast_moveset = spell.cast_moveset

func get_current_spell() -> Spell:
	var spell: Spell = null
	if len(attuned_spells) > 0:
		spell = attuned_spells[current_spell]
	return spell

func equip(item: EquipmentItem, secondary_slot: int = 0) -> void:
	var slot: String = item.primary_slot
	if secondary_slot:
		slot = item.secondary_slot
	var previous_item: Item = equipment.get_item(slot)
	if previous_item:
		inventory.add_item(previous_item)
	equipment.equip(item, secondary_slot)
	inventory.remove_item(item)
	_update_equipment_slot(slot, item)

func unequip(slot: String) -> void:
	var item: EquipmentItem = equipment.get_item(slot)
	if item:
		inventory.add_item(item)
	equipment.unequip(slot)
	_update_equipment_slot(slot, null)

func _update_equipment_slot(slot: String, item: EquipmentItem) -> void:
	var node = get_node("Rig/Skeleton3D/%s" % slot)
	if slot == StaticNames.slot_offhand and two_handed:
		node = get_node("Rig/Skeleton3D/%s" % StaticNames.slot_back)
	for child in node.get_children():
		node.remove_child(child)
		if slot == StaticNames.slot_mainhand:
			moveset = moveset_fist

	if item:
		var item_instance = item.instantiate()
		node.add_child(item_instance)
		if item.moveset:
			moveset = item.moveset
