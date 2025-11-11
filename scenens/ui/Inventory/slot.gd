extends HBoxContainer
class_name Slot

@onready var _icon: TextureRect  = $IconMargin/TextureMargin/IconTexture
@onready var _label: Label = $LabelMargin/Label

var current_item: Item

func set_item(new_item: Item) -> void:
	self.clear()
	self.current_item = new_item
	
	self._icon.texture = new_item.icon
	self._label.text = new_item.name
	
func clear() -> void:
	self.current_item = null
	self._icon.texture = null
	self._label.text = ""
