extends Control

@onready var InventoryList: VBoxContainer = $CenterContainer/MainSizeControl/hDivider/InventoryListMargin/VBoxContainer/InventorySizeControl/InventoryList
@onready var tab_bar: TabBar = $CenterContainer/MainSizeControl/hDivider/InventoryListMargin/VBoxContainer/TabBar
@onready var item_context: ItemContext = $ItemContext
@onready var SelectedType: int = 0
@onready var player: Player = get_node("../Player")

var selected_item: int = 0
var type_inventory: Array
var toggle_player_lock: bool = false

func _ready() -> void:
	player.toggle_menu.connect(self._on_toggle_menu)
	for type in player.inventory.items:
		tab_bar.add_tab(type)

#region Menu Handling
func _process(_delta: float) -> void:
	if toggle_player_lock:
		player.dialog_lock = !player.dialog_lock
		toggle_player_lock = false

	if visible:
		if not item_context.visible:
			if Input.is_action_just_pressed("arrow_up"):
				self.increment_selected_item(-1)
			elif Input.is_action_just_pressed("arrow_down"):
				self.increment_selected_item(1)

			elif Input.is_action_just_pressed("arrow_left"):
				increment_selected_type(-1)
			elif Input.is_action_just_pressed("arrow_right"):
				increment_selected_type(1)

			elif Input.is_action_just_pressed("Action"):
				open_item_context_menu()

		else:
			if Input.is_action_just_pressed("arrow_up"):
				item_context.increment_selection(-1)
			elif Input.is_action_just_pressed("arrow_down"):
				item_context.increment_selection(1)

			elif Input.is_action_just_pressed("Action"):
				item_context.trigger()
			elif Input.is_action_just_pressed("menu"):
				item_context.visible = false
				toggle_player_lock = true

func _on_toggle_menu(in_menu: bool) -> void:
	self.visible = in_menu
	if self.visible:
		self.display_inventory_type()
		self.display_equipment()
#endregion

#region Item Inventory
func get_selected_item() -> Item:
	var item: Item = null
	var banner: ItemBanner = InventoryList.get_child(selected_item)
	if banner:
		item = banner.item
	return item

func increment_selected_item(value: int) -> void:
	if len(InventoryList.get_children()) > 0:
		toggle_highlight_visibility()
		selected_item += value
		if selected_item < 0:
			selected_item = len(type_inventory) -1
		elif selected_item > len(type_inventory) -1:
			selected_item = 0
		toggle_highlight_visibility()
	
func increment_selected_type(value: int) -> void:
	SelectedType += value
	if SelectedType < 0:
		SelectedType = len(StaticNames.types) -1
	elif SelectedType > len(StaticNames.types) -1:
		SelectedType = 0
	tab_bar.current_tab = SelectedType
	selected_item = 0
	display_inventory_type()

func toggle_highlight_visibility() -> void:
	var item_banner: ItemBanner = InventoryList.get_child(selected_item)
	if item_banner:
		var highlight: Control = item_banner.get_node("Highlight")
		highlight.visible = !highlight.visible

func display_inventory_type() -> void:
	self._clear_inventory_list()
	var type = tab_bar.get_tab_title(SelectedType)
	type_inventory = player.inventory.get_type_list(type)
	for i in range(type_inventory.size()):
		var item = type_inventory[i]
		var banner = ItemBanner.new_item_banner(item)
		if i == selected_item:
			banner.get_node("Highlight").visible = true
		InventoryList.add_child(banner)

func _clear_inventory_list() -> void:
	for child in InventoryList.get_children():
		InventoryList.remove_child(child)
#endregion

#region Item Context Menu
func open_item_context_menu() -> void:
	if len(InventoryList.get_children()) > 0:
		item_context.visible = true
		item_context.current_selection = 0

		var item: Item = get_selected_item()
		var banner: ItemBanner = InventoryList.get_child(selected_item)
		var br: Rect2 = banner.get_global_rect()
		var location: Vector2 = Vector2(br.position.x, br.position.y + br.size.y)
		item_context.position = location
		
		_set_up_item_context_menu(item)
		toggle_player_lock = true
		item_context.toggle_highlight_visibility()

func _set_up_item_context_menu(item: Item) -> void:
	for option: SelectableOption in item_context.container.get_children():
		option.highlight.visible = false
		if option.text == "Use":
			if item.type == StaticNames.type_consumables:
				option.set_function(use_item)
			else:
				item_context.container.remove_child(option)

		elif option.text == "Equip": 
			if item.type in StaticNames.types_equipment:
				option.set_function(equip)
			else:
				item_context.container.remove_child(option)

		elif option.text == "Discard":
			option.set_function(discard)

		elif option.text == "Cancel":
			option.set_function(cancel)
	item_context.reset_size()

func use_item() -> void:
	var item: Item = get_selected_item()
	print("used item %s" % item.name)
	display_inventory_type()
	toggle_player_lock = true
	
func equip() -> void:
	var item: Item = get_selected_item()
	player.equip(item)
	display_inventory_type()
	display_equipment()
	toggle_player_lock = true
	
func discard() -> void:
	var item: Item = get_selected_item()
	player.inventory.remove_item(item)
	display_inventory_type()
	toggle_player_lock = true

func cancel() -> void:
	item_context.visible = false
	toggle_player_lock = true
#endregion

#region Equipment
func display_equipment() -> void:
	var slots: Dictionary = player.equipment.slots
	var eq_slots_path = "CenterContainer/MainSizeControl/hDivider/EquipmentMargin/EquipmentSizeControl/VBoxContainer"
	for slot in slots:
		var item: Item = slots.get(slot)
		if item:
			var eq_slot: Slot = get_node(eq_slots_path + "/%s" % slot)
			eq_slot.set_item(item)
#endregion

func _on_tab_bar_tab_button_pressed(tab: int) -> void:
	SelectedType = tab
	display_inventory_type()
